#!/bin/bash
# architecture-report.sh - Generate architecture health report
# Part of the Outer Developer Loop Toolkit

set -e

# Colors (for terminal output)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

usage() {
    cat << EOF
Usage: $(basename "$0") [options] [directory]

Generate an architecture health report for a codebase.

Options:
    -o FILE     Output to file instead of stdout
    -f FORMAT   Output format: md|json|text (default: md)
    -v          Verbose output
    -h          Show this help

Arguments:
    directory   Directory to analyze (default: current directory)

What it analyzes:
    - File sizes and counts
    - Directory structure depth
    - Potential coupling (cross-directory imports)
    - Large files that may need splitting
    - Dependency patterns

Examples:
    $(basename "$0")                        # Analyze current directory
    $(basename "$0") src/ -o report.md      # Analyze src/, save to file
    $(basename "$0") -f json > metrics.json # Output as JSON
EOF
}

# Initialize counters
TOTAL_FILES=0
TOTAL_LINES=0
LARGE_FILES=0
DEEP_DIRS=0

# Detect file types to analyze
get_source_extensions() {
    # Common source file extensions
    echo "ts tsx js jsx py go rs java kt scala rb php cs cpp c h hpp"
}

# Count lines in a file
count_lines() {
    wc -l < "$1" 2>/dev/null || echo 0
}

# Find all source files
find_source_files() {
    local dir=$1
    local extensions=$(get_source_extensions)
    
    local find_args=""
    for ext in $extensions; do
        if [[ -n "$find_args" ]]; then
            find_args="$find_args -o"
        fi
        find_args="$find_args -name \"*.$ext\""
    done
    
    eval "find \"$dir\" -type f \( $find_args \) 2>/dev/null" | grep -v node_modules | grep -v vendor | grep -v ".git"
}

# Analyze file sizes
analyze_file_sizes() {
    local dir=$1
    local threshold=${2:-500}
    
    local files=$(find_source_files "$dir")
    
    if [[ -z "$files" ]]; then
        return
    fi
    
    echo "$files" | while read file; do
        if [[ -f "$file" ]]; then
            local lines=$(count_lines "$file")
            TOTAL_FILES=$((TOTAL_FILES + 1))
            TOTAL_LINES=$((TOTAL_LINES + lines))
            
            if [[ $lines -gt $threshold ]]; then
                echo "$lines $file"
            fi
        fi
    done | sort -rn
}

# Analyze directory depth
analyze_directory_depth() {
    local dir=$1
    local max_depth=${2:-5}
    
    find "$dir" -type d 2>/dev/null | \
        grep -v node_modules | grep -v vendor | grep -v ".git" | \
        while read d; do
            local depth=$(echo "$d" | tr '/' '\n' | wc -l)
            if [[ $depth -gt $max_depth ]]; then
                echo "$depth $d"
            fi
        done | sort -rn | head -10
}

# Analyze imports/dependencies
analyze_imports() {
    local dir=$1
    
    # Count cross-directory imports (simplified heuristic)
    find "$dir" -name "*.ts" -o -name "*.js" -o -name "*.py" 2>/dev/null | \
        grep -v node_modules | grep -v vendor | \
        while read file; do
            # Count relative imports that go up directories
            local deep_imports=$(grep -c "\.\.\/" "$file" 2>/dev/null || echo 0)
            if [[ $deep_imports -gt 3 ]]; then
                echo "$deep_imports $file"
            fi
        done | sort -rn | head -10
}

# Find potential circular dependencies (simplified)
find_circular_hints() {
    local dir=$1
    
    # This is a heuristic - look for files that import each other
    # Real circular dependency detection needs language-specific tooling
    
    echo "Note: For accurate circular dependency detection, use:"
    echo "  - Node.js: npx madge --circular src/"
    echo "  - Python: pycycle --source ."
    echo "  - Go: go vet (built-in)"
}

# Generate markdown report
generate_markdown_report() {
    local dir=$1
    
    cat << EOF
# Architecture Health Report

**Generated:** $(date)
**Directory:** $dir

## Summary

EOF

    # File statistics
    local file_count=$(find_source_files "$dir" | wc -l)
    local total_lines=0
    
    while read file; do
        if [[ -f "$file" ]]; then
            local lines=$(count_lines "$file")
            total_lines=$((total_lines + lines))
        fi
    done < <(find_source_files "$dir")
    
    cat << EOF
| Metric | Value |
|--------|-------|
| Total source files | $file_count |
| Total lines of code | $total_lines |
| Average file size | $((total_lines / (file_count + 1))) lines |

## Large Files (> 500 lines)

Files over 500 lines may be difficult for AI to process and might benefit from splitting.

| Lines | File |
|-------|------|
EOF

    analyze_file_sizes "$dir" 500 | head -20 | while read lines file; do
        echo "| $lines | $file |"
    done

    cat << EOF

## Deep Directory Nesting

Directories more than 5 levels deep may indicate overly complex structure.

| Depth | Directory |
|-------|-----------|
EOF

    analyze_directory_depth "$dir" 5 | while read depth dir; do
        echo "| $depth | $dir |"
    done

    cat << EOF

## Files with Many Upward Imports

Files with many "../" imports may indicate coupling issues.

| Import Count | File |
|--------------|------|
EOF

    analyze_imports "$dir" | while read count file; do
        echo "| $count | $file |"
    done

    cat << EOF

## Circular Dependency Detection

$(find_circular_hints "$dir")

## Recommendations

### High Priority
EOF

    # Generate recommendations based on findings
    local large_count=$(analyze_file_sizes "$dir" 500 | wc -l)
    if [[ $large_count -gt 0 ]]; then
        echo "- [ ] Split $large_count files that are over 500 lines"
    fi
    
    local deep_count=$(analyze_directory_depth "$dir" 5 | wc -l)
    if [[ $deep_count -gt 0 ]]; then
        echo "- [ ] Flatten $deep_count deeply nested directories"
    fi

    cat << EOF

### Medium Priority
- [ ] Review files with many upward imports for potential refactoring
- [ ] Run language-specific circular dependency detection
- [ ] Consider adding module READMEs for documentation

### AI-Friendliness Improvements
- [ ] Ensure no single file exceeds context window limits (~8K lines)
- [ ] Add AGENTS.md with project-specific rules
- [ ] Document public APIs in each module

## File Size Distribution

\`\`\`
EOF

    # Simple histogram
    local small=0 medium=0 large=0 huge=0
    
    while read file; do
        if [[ -f "$file" ]]; then
            local lines=$(count_lines "$file")
            if [[ $lines -lt 100 ]]; then
                small=$((small + 1))
            elif [[ $lines -lt 300 ]]; then
                medium=$((medium + 1))
            elif [[ $lines -lt 500 ]]; then
                large=$((large + 1))
            else
                huge=$((huge + 1))
            fi
        fi
    done < <(find_source_files "$dir")

    echo "< 100 lines:  $small files"
    echo "100-300 lines: $medium files"
    echo "300-500 lines: $large files"
    echo "> 500 lines:  $huge files"
    
    echo '```'
}

# Generate JSON report
generate_json_report() {
    local dir=$1
    
    local file_count=$(find_source_files "$dir" | wc -l)
    local total_lines=0
    
    while read file; do
        if [[ -f "$file" ]]; then
            local lines=$(count_lines "$file")
            total_lines=$((total_lines + lines))
        fi
    done < <(find_source_files "$dir")
    
    local large_files=$(analyze_file_sizes "$dir" 500 | wc -l)
    local deep_dirs=$(analyze_directory_depth "$dir" 5 | wc -l)
    
    cat << EOF
{
  "generated": "$(date -Iseconds)",
  "directory": "$dir",
  "metrics": {
    "total_files": $file_count,
    "total_lines": $total_lines,
    "average_file_size": $((total_lines / (file_count + 1))),
    "large_files_count": $large_files,
    "deep_directories_count": $deep_dirs
  },
  "large_files": [
EOF

    local first=true
    analyze_file_sizes "$dir" 500 | head -20 | while read lines file; do
        if [[ "$first" == "true" ]]; then
            first=false
        else
            echo ","
        fi
        echo -n "    {\"lines\": $lines, \"file\": \"$file\"}"
    done
    
    cat << EOF

  ],
  "health_score": $(calculate_health_score "$file_count" "$large_files" "$deep_dirs")
}
EOF
}

# Calculate a simple health score
calculate_health_score() {
    local total=$1
    local large=$2
    local deep=$3
    
    # Start at 100, deduct for issues
    local score=100
    
    # Deduct for large files (max 30 points)
    local large_penalty=$((large * 3))
    if [[ $large_penalty -gt 30 ]]; then
        large_penalty=30
    fi
    score=$((score - large_penalty))
    
    # Deduct for deep directories (max 20 points)
    local deep_penalty=$((deep * 4))
    if [[ $deep_penalty -gt 20 ]]; then
        deep_penalty=20
    fi
    score=$((score - deep_penalty))
    
    echo $score
}

# Main execution
OUTPUT_FILE=""
FORMAT="md"
VERBOSE=false

while getopts "o:f:vh" opt; do
    case $opt in
        o) OUTPUT_FILE=$OPTARG ;;
        f) FORMAT=$OPTARG ;;
        v) VERBOSE=true ;;
        h) usage; exit 0 ;;
        *) usage; exit 1 ;;
    esac
done

shift $((OPTIND - 1))

TARGET_DIR=${1:-.}

if [[ ! -d "$TARGET_DIR" ]]; then
    echo -e "${RED}Error: Directory not found: $TARGET_DIR${NC}"
    exit 1
fi

# Generate report
case $FORMAT in
    md|markdown)
        if [[ -n "$OUTPUT_FILE" ]]; then
            generate_markdown_report "$TARGET_DIR" > "$OUTPUT_FILE"
            echo -e "${GREEN}Report saved to: $OUTPUT_FILE${NC}"
        else
            generate_markdown_report "$TARGET_DIR"
        fi
        ;;
    json)
        if [[ -n "$OUTPUT_FILE" ]]; then
            generate_json_report "$TARGET_DIR" > "$OUTPUT_FILE"
            echo -e "${GREEN}Report saved to: $OUTPUT_FILE${NC}"
        else
            generate_json_report "$TARGET_DIR"
        fi
        ;;
    text|txt)
        # Simple text format
        echo "Architecture Report: $TARGET_DIR"
        echo "Generated: $(date)"
        echo ""
        echo "=== Large Files ==="
        analyze_file_sizes "$TARGET_DIR" 500 | head -10
        echo ""
        echo "=== Deep Directories ==="
        analyze_directory_depth "$TARGET_DIR" 5
        ;;
    *)
        echo -e "${RED}Unknown format: $FORMAT${NC}"
        exit 1
        ;;
esac
