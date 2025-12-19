#!/bin/bash
# api-diff-check.sh - Detect potential API breaking changes
# Part of the Outer Developer Loop Toolkit

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

usage() {
    cat << EOF
Usage: $(basename "$0") [options] [base-ref]

Checks for potential API breaking changes between current state and base-ref.

Options:
    -t TYPE     Project type: node|python|go|java|generic (auto-detected)
    -v          Verbose output
    -s          Strict mode (fail on warnings too)
    -h          Show this help

Arguments:
    base-ref    Git ref to compare against (default: origin/main)

Examples:
    $(basename "$0")                    # Compare to origin/main
    $(basename "$0") HEAD~5             # Compare to 5 commits ago
    $(basename "$0") -t node main       # Force node type, compare to main

What it checks:
    - Removed exports/public functions
    - Changed function signatures
    - Removed or changed types
    - Database schema changes (if detected)
    - API endpoint changes (OpenAPI/Swagger)
EOF
}

# Detect project type
detect_project_type() {
    if [[ -f "package.json" ]]; then
        echo "node"
    elif [[ -f "setup.py" || -f "pyproject.toml" || -f "requirements.txt" ]]; then
        echo "python"
    elif [[ -f "go.mod" ]]; then
        echo "go"
    elif [[ -f "pom.xml" || -f "build.gradle" ]]; then
        echo "java"
    else
        echo "generic"
    fi
}

# Check if we're in a git repository
check_git() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo -e "${RED}Error: Not in a git repository${NC}"
        exit 1
    fi
}

# Count breaking changes
WARNINGS=0
ERRORS=0

warn() {
    echo -e "${YELLOW}⚠ WARNING: $1${NC}"
    WARNINGS=$((WARNINGS + 1))
}

error() {
    echo -e "${RED}✗ BREAKING: $1${NC}"
    ERRORS=$((ERRORS + 1))
}

ok() {
    echo -e "${GREEN}✓ $1${NC}"
}

info() {
    if [[ "$VERBOSE" == "true" ]]; then
        echo -e "${BLUE}ℹ $1${NC}"
    fi
}

# Check for removed exports in Node.js
check_node_exports() {
    local base_ref=$1
    
    info "Checking Node.js exports..."
    
    # Find index.ts/js files (usually contain exports)
    local export_files=$(git diff --name-only "$base_ref" -- "*/index.ts" "*/index.js" "*.d.ts" 2>/dev/null || true)
    
    if [[ -z "$export_files" ]]; then
        info "No export files changed"
        return
    fi
    
    for file in $export_files; do
        if [[ ! -f "$file" ]]; then
            continue
        fi
        
        # Check for removed exports
        local removed=$(git diff "$base_ref" -- "$file" | grep "^-export" | grep -v "^---" || true)
        if [[ -n "$removed" ]]; then
            error "Removed exports in $file:"
            echo "$removed" | head -5
        fi
        
        # Check for changed function signatures
        local changed=$(git diff "$base_ref" -- "$file" | grep -E "^[-+].*function.*\(" | head -10 || true)
        if [[ -n "$changed" ]]; then
            warn "Potential signature changes in $file:"
            echo "$changed" | head -5
        fi
    done
}

# Check for removed functions in Python
check_python_exports() {
    local base_ref=$1
    
    info "Checking Python exports..."
    
    # Find __init__.py files
    local init_files=$(git diff --name-only "$base_ref" -- "*/__init__.py" 2>/dev/null || true)
    
    for file in $init_files; do
        if [[ ! -f "$file" ]]; then
            continue
        fi
        
        # Check for removed __all__ entries or imports
        local removed=$(git diff "$base_ref" -- "$file" | grep -E "^-.*(__all__|from|import)" | grep -v "^---" || true)
        if [[ -n "$removed" ]]; then
            warn "Potential removed exports in $file:"
            echo "$removed" | head -5
        fi
    done
    
    # Check for removed public functions (not starting with _)
    local py_files=$(git diff --name-only "$base_ref" -- "*.py" 2>/dev/null || true)
    
    for file in $py_files; do
        if [[ ! -f "$file" ]]; then
            continue
        fi
        
        local removed_funcs=$(git diff "$base_ref" -- "$file" | grep -E "^-def [^_]" | grep -v "^---" || true)
        if [[ -n "$removed_funcs" ]]; then
            error "Removed public functions in $file:"
            echo "$removed_funcs" | head -5
        fi
    done
}

# Check for removed public functions in Go
check_go_exports() {
    local base_ref=$1
    
    info "Checking Go exports..."
    
    local go_files=$(git diff --name-only "$base_ref" -- "*.go" 2>/dev/null || true)
    
    for file in $go_files; do
        if [[ ! -f "$file" ]]; then
            continue
        fi
        
        # Go public functions start with capital letter
        local removed=$(git diff "$base_ref" -- "$file" | grep -E "^-func [A-Z]" | grep -v "^---" || true)
        if [[ -n "$removed" ]]; then
            error "Removed public functions in $file:"
            echo "$removed" | head -5
        fi
        
        # Check for changed struct fields
        local struct_changes=$(git diff "$base_ref" -- "$file" | grep -E "^[-+].*[A-Z][a-zA-Z]*\s+[a-zA-Z]" | head -10 || true)
        if [[ -n "$struct_changes" ]]; then
            warn "Potential struct changes in $file"
        fi
    done
}

# Check for removed public methods in Java
check_java_exports() {
    local base_ref=$1
    
    info "Checking Java exports..."
    
    local java_files=$(git diff --name-only "$base_ref" -- "*.java" 2>/dev/null || true)
    
    for file in $java_files; do
        if [[ ! -f "$file" ]]; then
            continue
        fi
        
        # Check for removed public methods
        local removed=$(git diff "$base_ref" -- "$file" | grep -E "^-\s*public" | grep -v "^---" || true)
        if [[ -n "$removed" ]]; then
            error "Removed public members in $file:"
            echo "$removed" | head -5
        fi
    done
}

# Check for database migration issues
check_database_changes() {
    local base_ref=$1
    
    info "Checking database migrations..."
    
    # Look for migration files
    local migration_files=$(git diff --name-only "$base_ref" -- "**/migrations/*" "**/migrate/*" "*.sql" 2>/dev/null || true)
    
    if [[ -z "$migration_files" ]]; then
        info "No migration files changed"
        return
    fi
    
    for file in $migration_files; do
        if [[ ! -f "$file" ]]; then
            continue
        fi
        
        # Check for DROP statements
        local drops=$(git diff "$base_ref" -- "$file" | grep -iE "^\+.*DROP (TABLE|COLUMN|INDEX)" || true)
        if [[ -n "$drops" ]]; then
            error "Destructive database changes in $file:"
            echo "$drops" | head -5
        fi
        
        # Check for column type changes
        local alters=$(git diff "$base_ref" -- "$file" | grep -iE "^\+.*ALTER.*TYPE" || true)
        if [[ -n "$alters" ]]; then
            warn "Column type changes in $file:"
            echo "$alters" | head -5
        fi
        
        # Check for NOT NULL on existing columns
        local notnull=$(git diff "$base_ref" -- "$file" | grep -iE "^\+.*(SET NOT NULL|NOT NULL)" || true)
        if [[ -n "$notnull" ]]; then
            warn "NOT NULL constraints in $file (check if column has defaults):"
            echo "$notnull" | head -5
        fi
    done
}

# Check for OpenAPI/Swagger changes
check_openapi_changes() {
    local base_ref=$1
    
    info "Checking OpenAPI/Swagger specs..."
    
    local api_files=$(git diff --name-only "$base_ref" -- "*.yaml" "*.yml" "*.json" 2>/dev/null | \
        grep -iE "(openapi|swagger|api)" || true)
    
    if [[ -z "$api_files" ]]; then
        info "No API spec files changed"
        return
    fi
    
    for file in $api_files; do
        if [[ ! -f "$file" ]]; then
            continue
        fi
        
        # Check for removed paths
        local removed_paths=$(git diff "$base_ref" -- "$file" | grep -E "^-\s*/(.*):$" | grep -v "^---" || true)
        if [[ -n "$removed_paths" ]]; then
            error "Removed API paths in $file:"
            echo "$removed_paths" | head -5
        fi
        
        # Check for removed required fields
        local removed_required=$(git diff "$base_ref" -- "$file" | grep -E "^-.*required:" | grep -v "^---" || true)
        if [[ -n "$removed_required" ]]; then
            warn "Changed required fields in $file"
        fi
    done
}

# Generic checks for any project
check_generic() {
    local base_ref=$1
    
    info "Running generic API checks..."
    
    # Check for removed files that might be APIs
    local removed_files=$(git diff --name-only --diff-filter=D "$base_ref" 2>/dev/null || true)
    if [[ -n "$removed_files" ]]; then
        warn "Files removed:"
        echo "$removed_files" | head -10
    fi
    
    # Check for renamed files (might break imports)
    local renamed_files=$(git diff --name-only --diff-filter=R "$base_ref" 2>/dev/null || true)
    if [[ -n "$renamed_files" ]]; then
        warn "Files renamed (check import paths):"
        echo "$renamed_files" | head -10
    fi
}

# Main execution
VERBOSE=false
STRICT=false
PROJECT_TYPE=""
BASE_REF="origin/main"

while getopts "t:vsh" opt; do
    case $opt in
        t) PROJECT_TYPE=$OPTARG ;;
        v) VERBOSE=true ;;
        s) STRICT=true ;;
        h) usage; exit 0 ;;
        *) usage; exit 1 ;;
    esac
done

shift $((OPTIND - 1))

if [[ -n "$1" ]]; then
    BASE_REF=$1
fi

check_git

# Auto-detect project type if not specified
if [[ -z "$PROJECT_TYPE" ]]; then
    PROJECT_TYPE=$(detect_project_type)
fi

echo -e "${BLUE}=== API Breaking Change Check ===${NC}"
echo "Project type: $PROJECT_TYPE"
echo "Comparing to: $BASE_REF"
echo ""

# Run type-specific checks
case $PROJECT_TYPE in
    node)
        check_node_exports "$BASE_REF"
        ;;
    python)
        check_python_exports "$BASE_REF"
        ;;
    go)
        check_go_exports "$BASE_REF"
        ;;
    java)
        check_java_exports "$BASE_REF"
        ;;
esac

# Run common checks
check_database_changes "$BASE_REF"
check_openapi_changes "$BASE_REF"
check_generic "$BASE_REF"

# Summary
echo ""
echo -e "${BLUE}=== Summary ===${NC}"

if [[ $ERRORS -eq 0 && $WARNINGS -eq 0 ]]; then
    ok "No API breaking changes detected"
    exit 0
fi

if [[ $WARNINGS -gt 0 ]]; then
    echo -e "${YELLOW}Warnings: $WARNINGS${NC}"
fi

if [[ $ERRORS -gt 0 ]]; then
    echo -e "${RED}Breaking changes: $ERRORS${NC}"
    exit 1
fi

if [[ "$STRICT" == "true" && $WARNINGS -gt 0 ]]; then
    echo -e "${RED}Strict mode: failing due to warnings${NC}"
    exit 1
fi

exit 0
