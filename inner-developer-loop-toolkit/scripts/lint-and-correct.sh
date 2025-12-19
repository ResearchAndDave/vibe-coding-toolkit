#!/bin/bash
# lint-and-correct.sh - Multi-phase code cleanup for AI-generated code
# Part of the Inner Developer Loop Toolkit

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Configuration
PHASES_DIR="${PHASES_DIR:-.lint-phases}"
DRY_RUN=${DRY_RUN:-false}

log_phase() {
    echo ""
    echo -e "${CYAN}════════════════════════════════════════${NC}"
    echo -e "${CYAN}  PHASE: $1${NC}"
    echo -e "${CYAN}════════════════════════════════════════${NC}"
    echo ""
}

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_action() {
    echo -e "${YELLOW}[ACTION]${NC} $1"
}

usage() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS] [PHASES...]

Multi-phase code cleanup following the Inner Developer Loop methodology.
Run phases sequentially - each phase may affect subsequent phases.

Phases (in recommended order):
    style       Check code style and elegance
    efficiency  Check algorithmic appropriateness
    warnings    Clean up errors and warnings
    errors      Ensure robust error handling
    debug       Remove debug cruft
    format      Consistent formatting (final pass)
    all         Run all phases in order

Options:
    -d, --dry-run     Show what would be done without making changes
    -p, --project     Specify project type (node|python|rust|go|java)
    -h, --help        Show this help message

Examples:
    $(basename "$0") all                    # Run all phases
    $(basename "$0") style warnings         # Run specific phases
    $(basename "$0") -d all                 # Dry run all phases

EOF
}

detect_project_type() {
    if [ -f "package.json" ]; then
        echo "node"
    elif [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
        echo "python"
    elif [ -f "Cargo.toml" ]; then
        echo "rust"
    elif [ -f "go.mod" ]; then
        echo "go"
    elif [ -f "build.gradle" ] || [ -f "pom.xml" ]; then
        echo "java"
    else
        echo "unknown"
    fi
}

# Phase 1: Code Style and Elegance
phase_style() {
    log_phase "1. CODE STYLE AND ELEGANCE"
    
    log_info "Checking if code 'feels' right and matches project patterns..."
    
    local project_type=$(detect_project_type)
    
    case $project_type in
        node)
            log_action "Running ESLint..."
            if [ "$DRY_RUN" = "true" ]; then
                npx eslint . --max-warnings 0 2>&1 || true
            else
                npx eslint . --fix 2>&1 || true
            fi
            ;;
        python)
            log_action "Running ruff/pylint..."
            if command -v ruff &> /dev/null; then
                if [ "$DRY_RUN" = "true" ]; then
                    ruff check . 2>&1 || true
                else
                    ruff check . --fix 2>&1 || true
                fi
            fi
            ;;
        rust)
            log_action "Running clippy..."
            if [ "$DRY_RUN" = "true" ]; then
                cargo clippy -- -D warnings 2>&1 || true
            else
                cargo clippy --fix --allow-dirty 2>&1 || true
            fi
            ;;
        go)
            log_action "Running go vet and staticcheck..."
            go vet ./... 2>&1 || true
            if command -v staticcheck &> /dev/null; then
                staticcheck ./... 2>&1 || true
            fi
            ;;
        java)
            local linter_ran=false

            # Try Gradle checkstyle
            if [ -f "build.gradle" ] || [ -f "build.gradle.kts" ]; then
                if grep -q "checkstyle" build.gradle* 2>/dev/null; then
                    log_action "Running Checkstyle (Gradle)..."
                    ./gradlew checkstyleMain checkstyleTest 2>&1 || true
                    linter_ran=true
                fi
                if grep -q "pmd" build.gradle* 2>/dev/null; then
                    log_action "Running PMD (Gradle)..."
                    ./gradlew pmdMain pmdTest 2>&1 || true
                    linter_ran=true
                fi
            # Try Maven checkstyle
            elif [ -f "pom.xml" ]; then
                if grep -q "checkstyle" pom.xml 2>/dev/null; then
                    log_action "Running Checkstyle (Maven)..."
                    ./mvnw checkstyle:check 2>&1 || true
                    linter_ran=true
                fi
                if grep -q "pmd" pom.xml 2>/dev/null; then
                    log_action "Running PMD (Maven)..."
                    ./mvnw pmd:check 2>&1 || true
                    linter_ran=true
                fi
            fi

            # Fallback to standalone tools
            if [ "$linter_ran" = false ]; then
                if command -v checkstyle &> /dev/null; then
                    log_action "Running Checkstyle (standalone)..."
                    find . -name "*.java" -not -path "*/build/*" -not -path "*/target/*" 2>/dev/null | \
                        xargs checkstyle -c /google_checks.xml 2>&1 || true
                    linter_ran=true
                fi
                if command -v pmd &> /dev/null; then
                    log_action "Running PMD (standalone)..."
                    pmd check -d . -R rulesets/java/quickstart.xml -f text 2>&1 || true
                    linter_ran=true
                fi
            fi

            if [ "$linter_ran" = false ]; then
                log_info "No Java linter found (configure Checkstyle/PMD in build tool or install standalone)"
            fi
            ;;
    esac

    # Check for common style issues
    log_info "Checking for common style issues..."
    
    # Long lines (over 120 chars)
    local long_lines=$(find . -name "*.js" -o -name "*.ts" -o -name "*.py" -o -name "*.go" -o -name "*.rs" -o -name "*.java" 2>/dev/null | \
        xargs grep -l '.\{121\}' 2>/dev/null || true)
    if [ -n "$long_lines" ]; then
        log_warn "Files with lines > 120 chars:"
        echo "$long_lines"
    fi
    
    # Deep nesting (rough check for 4+ levels of indentation)
    log_info "Checking for deep nesting..."
    local deep_nest=$(grep -rn "^                    " --include="*.js" --include="*.ts" --include="*.py" --include="*.java" . 2>/dev/null | head -5 || true)
    if [ -n "$deep_nest" ]; then
        log_warn "Potential deep nesting found (review manually):"
        echo "$deep_nest"
    fi
    
    log_success "Style check complete"
}

# Phase 2: Algorithmic Appropriateness
phase_efficiency() {
    log_phase "2. ALGORITHMIC APPROPRIATENESS"
    
    log_info "Checking for potentially inefficient patterns..."
    
    # Check for common inefficiency patterns
    local issues_found=false
    
    # Nested loops (potential O(n²))
    log_info "Checking for nested loops..."
    local nested=$(grep -rn "for.*for\|while.*while" --include="*.js" --include="*.ts" --include="*.py" . 2>/dev/null | head -5 || true)
    if [ -n "$nested" ]; then
        log_warn "Potential nested loops (review for O(n²) issues):"
        echo "$nested"
        issues_found=true
    fi
    
    # Multiple array iterations that could be combined
    log_info "Checking for multiple array iterations..."
    local multi_iter=$(grep -rn "\.map.*\.map\|\.filter.*\.filter\|\.forEach.*\.forEach" --include="*.js" --include="*.ts" . 2>/dev/null | head -5 || true)
    if [ -n "$multi_iter" ]; then
        log_warn "Multiple chained iterations (could potentially be combined):"
        echo "$multi_iter"
        issues_found=true
    fi
    
    # String concatenation in loops
    log_info "Checking for string concatenation in loops..."
    local str_concat=$(grep -rn "+=" --include="*.py" --include="*.java" . 2>/dev/null | grep -E "for|while" | head -5 || true)
    if [ -n "$str_concat" ]; then
        log_warn "Potential string concatenation in loops:"
        echo "$str_concat"
        issues_found=true
    fi
    
    if [ "$issues_found" = false ]; then
        log_success "No obvious efficiency issues found"
    else
        log_warn "Review flagged items for potential optimization"
    fi
}

# Phase 3: Error/Warning Cleanup
phase_warnings() {
    log_phase "3. ERROR/WARNING CLEANUP"
    
    local project_type=$(detect_project_type)
    
    log_info "Checking for compiler/interpreter warnings..."
    
    case $project_type in
        node)
            log_action "TypeScript check..."
            if [ -f "tsconfig.json" ]; then
                npx tsc --noEmit 2>&1 || true
            fi
            ;;
        python)
            log_action "Running pyflakes..."
            if command -v pyflakes &> /dev/null; then
                pyflakes . 2>&1 || true
            fi
            ;;
        rust)
            log_action "Cargo check..."
            cargo check 2>&1 || true
            ;;
        go)
            log_action "Go build check..."
            go build ./... 2>&1 || true
            ;;
    esac
    
    # Check for unused imports
    log_info "Checking for unused imports..."
    case $project_type in
        node)
            npx eslint . --rule 'no-unused-vars: warn' 2>&1 | grep "no-unused-vars" | head -10 || true
            ;;
        python)
            if command -v autoflake &> /dev/null; then
                if [ "$DRY_RUN" = "true" ]; then
                    autoflake --check -r . 2>&1 | head -10 || true
                else
                    autoflake --in-place --remove-unused-variables -r . 2>&1 || true
                fi
            fi
            ;;
    esac
    
    log_success "Warning check complete"
}

# Phase 4: Robust Error Handling
phase_errors() {
    log_phase "4. ERROR HANDLING CHECK"
    
    log_info "Checking for proper error handling..."
    
    # Empty catch blocks
    log_info "Checking for empty catch blocks..."
    local empty_catch=$(grep -rn "catch.*{[[:space:]]*}" --include="*.js" --include="*.ts" --include="*.java" . 2>/dev/null || true)
    if [ -n "$empty_catch" ]; then
        log_warn "Empty catch blocks found (silent failures):"
        echo "$empty_catch"
    fi
    
    # Bare except in Python
    log_info "Checking for bare except clauses..."
    local bare_except=$(grep -rn "except:" --include="*.py" . 2>/dev/null | grep -v "except:.*#" || true)
    if [ -n "$bare_except" ]; then
        log_warn "Bare except clauses (too broad):"
        echo "$bare_except"
    fi
    
    # Missing null checks (very basic)
    log_info "Checking for potential null pointer issues..."
    local null_issues=$(grep -rn "\\.\\." --include="*.js" --include="*.ts" . 2>/dev/null | head -5 || true)
    # This is a very rough check - optional chaining might be needed
    
    # Check for TODO error handling
    log_info "Checking for TODO markers in error handling..."
    local todo_errors=$(grep -rn "TODO.*error\|FIXME.*error\|XXX.*error" --include="*.js" --include="*.ts" --include="*.py" --include="*.java" . 2>/dev/null || true)
    if [ -n "$todo_errors" ]; then
        log_warn "TODO markers found related to error handling:"
        echo "$todo_errors"
    fi
    
    log_success "Error handling check complete"
}

# Phase 5: Debug Cruft Removal
phase_debug() {
    log_phase "5. DEBUG CRUFT REMOVAL"
    
    log_info "Checking for debug/temporary code..."
    
    # Console.log / print statements
    log_info "Checking for console.log/print statements..."
    local debug_logs=$(grep -rn "console.log\|console.debug\|print(" --include="*.js" --include="*.ts" --include="*.py" . 2>/dev/null | grep -v "node_modules" | grep -v "__pycache__" | head -10 || true)
    if [ -n "$debug_logs" ]; then
        log_warn "Debug logging found (remove before commit):"
        echo "$debug_logs"
    fi
    
    # debugger statements
    log_info "Checking for debugger statements..."
    local debuggers=$(grep -rn "debugger" --include="*.js" --include="*.ts" . 2>/dev/null || true)
    if [ -n "$debuggers" ]; then
        log_warn "Debugger statements found:"
        echo "$debuggers"
    fi
    
    # Commented out code blocks (rough detection)
    log_info "Checking for commented-out code..."
    local commented=$(grep -rn "^[[:space:]]*//.*function\|^[[:space:]]*//.*if\|^[[:space:]]*#.*def\|^[[:space:]]*#.*class" --include="*.js" --include="*.ts" --include="*.py" . 2>/dev/null | head -10 || true)
    if [ -n "$commented" ]; then
        log_warn "Potentially commented-out code:"
        echo "$commented"
    fi
    
    # Temporary files
    log_info "Checking for temporary files..."
    local temp_files=$(find . -name "*.tmp" -o -name "*.temp" -o -name "*.bak" -o -name "*~" 2>/dev/null | grep -v node_modules || true)
    if [ -n "$temp_files" ]; then
        log_warn "Temporary files found:"
        echo "$temp_files"
        if [ "$DRY_RUN" != "true" ]; then
            read -p "Remove these files? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                echo "$temp_files" | xargs rm -f
                log_success "Temporary files removed"
            fi
        fi
    fi
    
    log_success "Debug cruft check complete"
}

# Phase 6: Consistent Formatting
phase_format() {
    log_phase "6. CONSISTENT FORMATTING"
    
    local project_type=$(detect_project_type)
    
    log_info "Applying consistent formatting..."
    
    case $project_type in
        node)
            if [ -f ".prettierrc" ] || [ -f "prettier.config.js" ]; then
                log_action "Running Prettier..."
                if [ "$DRY_RUN" = "true" ]; then
                    npx prettier --check . 2>&1 || true
                else
                    npx prettier --write . 2>&1 || true
                fi
            else
                log_info "No Prettier config found"
            fi
            ;;
        python)
            if command -v black &> /dev/null; then
                log_action "Running Black..."
                if [ "$DRY_RUN" = "true" ]; then
                    black --check . 2>&1 || true
                else
                    black . 2>&1 || true
                fi
            fi
            if command -v isort &> /dev/null; then
                log_action "Running isort..."
                if [ "$DRY_RUN" = "true" ]; then
                    isort --check-only . 2>&1 || true
                else
                    isort . 2>&1 || true
                fi
            fi
            ;;
        rust)
            log_action "Running rustfmt..."
            if [ "$DRY_RUN" = "true" ]; then
                cargo fmt --check 2>&1 || true
            else
                cargo fmt 2>&1 || true
            fi
            ;;
        go)
            log_action "Running gofmt..."
            if [ "$DRY_RUN" = "true" ]; then
                gofmt -l . 2>&1 || true
            else
                gofmt -w . 2>&1 || true
            fi
            ;;
        java)
            local formatter_ran=false

            # Try Spotless first (build tool plugin)
            if [ -f "build.gradle" ] || [ -f "build.gradle.kts" ]; then
                if grep -q "spotless" build.gradle* 2>/dev/null; then
                    log_action "Running Spotless (Gradle)..."
                    if [ "$DRY_RUN" = "true" ]; then
                        ./gradlew spotlessCheck 2>&1 || true
                    else
                        ./gradlew spotlessApply 2>&1 || true
                    fi
                    formatter_ran=true
                fi
            elif [ -f "pom.xml" ]; then
                if grep -q "spotless" pom.xml 2>/dev/null; then
                    log_action "Running Spotless (Maven)..."
                    if [ "$DRY_RUN" = "true" ]; then
                        ./mvnw spotless:check 2>&1 || true
                    else
                        ./mvnw spotless:apply 2>&1 || true
                    fi
                    formatter_ran=true
                fi
            fi

            # Fallback to google-java-format CLI only if Spotless didn't run
            if [ "$formatter_ran" = false ]; then
                if command -v google-java-format &> /dev/null; then
                    log_action "Running google-java-format..."
                    local java_files=$(find . -name "*.java" -not -path "*/build/*" -not -path "*/target/*" 2>/dev/null)
                    if [ -n "$java_files" ]; then
                        if [ "$DRY_RUN" = "true" ]; then
                            echo "$java_files" | xargs google-java-format --dry-run 2>&1 || true
                        else
                            echo "$java_files" | xargs google-java-format --replace 2>&1 || true
                        fi
                    fi
                else
                    log_info "No Java formatter found (install google-java-format or configure Spotless)"
                fi
            fi
            ;;
    esac

    log_success "Formatting complete"
}

# Run all phases
run_all_phases() {
    phase_style
    phase_efficiency
    phase_warnings
    phase_errors
    phase_debug
    phase_format
    
    echo ""
    log_phase "CLEANUP COMPLETE"
    log_info "All phases have been run."
    log_info "Review any warnings above and address as needed."
    log_info "Run tests to verify nothing was broken: verify-ai-claims.sh"
}

# Main
main() {
    local phases=()
    
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -d|--dry-run)
                DRY_RUN=true
                log_info "Dry run mode - no changes will be made"
                shift
                ;;
            -p|--project)
                PROJECT_TYPE="$2"
                shift 2
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            all)
                phases=("all")
                shift
                ;;
            style|efficiency|warnings|errors|debug|format)
                phases+=("$1")
                shift
                ;;
            *)
                log_error "Unknown option or phase: $1"
                usage
                exit 1
                ;;
        esac
    done
    
    # Default to all if no phases specified
    if [ ${#phases[@]} -eq 0 ]; then
        phases=("all")
    fi
    
    echo ""
    echo "════════════════════════════════════════"
    echo "    Multi-Phase Code Cleanup            "
    echo "    Inner Developer Loop Toolkit        "
    echo "════════════════════════════════════════"
    echo ""
    
    local project_type=${PROJECT_TYPE:-$(detect_project_type)}
    log_info "Project type: $project_type"
    
    for phase in "${phases[@]}"; do
        case "$phase" in
            all) run_all_phases ;;
            style) phase_style ;;
            efficiency) phase_efficiency ;;
            warnings) phase_warnings ;;
            errors) phase_errors ;;
            debug) phase_debug ;;
            format) phase_format ;;
        esac
    done
}

main "$@"
