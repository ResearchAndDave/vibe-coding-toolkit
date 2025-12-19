#!/bin/bash
# branch-audit.sh - Find and analyze branch litter
# Part of the Outer Developer Loop Toolkit

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}Error: Not in a git repository${NC}"
    exit 1
fi

usage() {
    cat << EOF
Usage: $(basename "$0") [command] [options]

Commands:
    list        List all branches with status
    orphan      Find potentially orphaned branches
    stale       Find branches with no recent commits
    merged      List branches that have been merged to main
    unmerged    List branches not yet merged to main
    age         Show branches sorted by last commit date
    cleanup     Interactive cleanup of safe-to-delete branches
    report      Generate full audit report

Options:
    -d DAYS     Consider branches stale after DAYS (default: 30)
    -m BRANCH   Main branch name (default: main, falls back to master)
    -h          Show this help message

Examples:
    $(basename "$0") list
    $(basename "$0") stale -d 14
    $(basename "$0") cleanup
    $(basename "$0") report > branch-audit.md
EOF
}

# Determine main branch
get_main_branch() {
    if git show-ref --verify --quiet refs/heads/main; then
        echo "main"
    elif git show-ref --verify --quiet refs/heads/master; then
        echo "master"
    else
        echo "main"  # Default assumption
    fi
}

# Get last commit date for a branch
get_last_commit_date() {
    local branch=$1
    git log -1 --format="%ci" "$branch" 2>/dev/null | cut -d' ' -f1
}

# Get days since last commit
get_days_since_commit() {
    local branch=$1
    local last_commit=$(git log -1 --format="%ct" "$branch" 2>/dev/null)
    if [[ -n "$last_commit" ]]; then
        local now=$(date +%s)
        echo $(( (now - last_commit) / 86400 ))
    else
        echo "unknown"
    fi
}

# List all branches
cmd_list() {
    local main_branch=$(get_main_branch)
    
    echo -e "${BLUE}=== All Branches ===${NC}"
    echo ""
    
    echo -e "${GREEN}Local branches:${NC}"
    for branch in $(git branch --format='%(refname:short)'); do
        local days=$(get_days_since_commit "$branch")
        local merged=""
        if git branch --merged "$main_branch" | grep -q "^\s*$branch$"; then
            merged="${GREEN}[merged]${NC}"
        fi
        printf "  %-40s %s days ago %s\n" "$branch" "$days" "$merged"
    done
    
    echo ""
    echo -e "${GREEN}Remote branches:${NC}"
    git branch -r --format='%(refname:short)' | head -20
    
    local total=$(git branch -r | wc -l)
    if [[ $total -gt 20 ]]; then
        echo "  ... and $(($total - 20)) more"
    fi
}

# Find orphaned branches (not in main, not recently updated)
cmd_orphan() {
    local main_branch=$(get_main_branch)
    local stale_days=${1:-30}
    
    echo -e "${BLUE}=== Potentially Orphaned Branches ===${NC}"
    echo -e "${YELLOW}Branches not merged to $main_branch and older than $stale_days days${NC}"
    echo ""
    
    local found=0
    for branch in $(git branch --no-merged "$main_branch" --format='%(refname:short)'); do
        local days=$(get_days_since_commit "$branch")
        if [[ "$days" != "unknown" && "$days" -gt "$stale_days" ]]; then
            local last_date=$(get_last_commit_date "$branch")
            echo -e "${RED}  $branch${NC} - $days days old (last: $last_date)"
            found=$((found + 1))
        fi
    done
    
    if [[ $found -eq 0 ]]; then
        echo -e "${GREEN}  No orphaned branches found${NC}"
    else
        echo ""
        echo -e "${YELLOW}Found $found potentially orphaned branches${NC}"
        echo "Review these carefully before deleting!"
    fi
}

# Find stale branches
cmd_stale() {
    local stale_days=${1:-30}
    
    echo -e "${BLUE}=== Stale Branches (> $stale_days days) ===${NC}"
    echo ""
    
    local found=0
    for branch in $(git branch --format='%(refname:short)'); do
        local days=$(get_days_since_commit "$branch")
        if [[ "$days" != "unknown" && "$days" -gt "$stale_days" ]]; then
            local last_date=$(get_last_commit_date "$branch")
            echo "  $branch - $days days old (last: $last_date)"
            found=$((found + 1))
        fi
    done
    
    if [[ $found -eq 0 ]]; then
        echo -e "${GREEN}  No stale branches found${NC}"
    fi
}

# List merged branches
cmd_merged() {
    local main_branch=$(get_main_branch)
    
    echo -e "${BLUE}=== Merged Branches (safe to delete) ===${NC}"
    echo ""
    
    local branches=$(git branch --merged "$main_branch" --format='%(refname:short)' | grep -v "^$main_branch$")
    
    if [[ -z "$branches" ]]; then
        echo -e "${GREEN}  No merged branches to clean up${NC}"
    else
        echo "$branches" | while read branch; do
            local days=$(get_days_since_commit "$branch")
            echo "  $branch - merged, $days days since last commit"
        done
        echo ""
        echo -e "${YELLOW}These branches have been merged and can likely be deleted.${NC}"
        echo "Delete with: git branch -d <branch-name>"
    fi
}

# List unmerged branches
cmd_unmerged() {
    local main_branch=$(get_main_branch)
    
    echo -e "${BLUE}=== Unmerged Branches ===${NC}"
    echo -e "${YELLOW}Branches NOT merged to $main_branch${NC}"
    echo ""
    
    for branch in $(git branch --no-merged "$main_branch" --format='%(refname:short)'); do
        local days=$(get_days_since_commit "$branch")
        local commits=$(git rev-list --count "$main_branch".."$branch" 2>/dev/null || echo "?")
        echo "  $branch - $commits commits ahead, $days days since last commit"
    done
}

# Show branches by age
cmd_age() {
    echo -e "${BLUE}=== Branches by Age ===${NC}"
    echo ""
    
    git for-each-ref --sort=-committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)' | head -20
    
    local total=$(git branch | wc -l)
    if [[ $total -gt 20 ]]; then
        echo ""
        echo "Showing 20 of $total branches"
    fi
}

# Interactive cleanup
cmd_cleanup() {
    local main_branch=$(get_main_branch)
    
    echo -e "${BLUE}=== Interactive Branch Cleanup ===${NC}"
    echo ""
    
    local merged=$(git branch --merged "$main_branch" --format='%(refname:short)' | grep -v "^$main_branch$")
    
    if [[ -z "$merged" ]]; then
        echo -e "${GREEN}No merged branches to clean up!${NC}"
        return 0
    fi
    
    echo "The following branches are merged to $main_branch:"
    echo ""
    
    echo "$merged" | while read branch; do
        local days=$(get_days_since_commit "$branch")
        echo "  $branch ($days days old)"
    done
    
    echo ""
    echo -e "${YELLOW}Review each branch before deleting!${NC}"
    echo ""
    
    echo "$merged" | while read branch; do
        echo ""
        echo -e "${BLUE}Branch: $branch${NC}"
        echo "Last commit: $(git log -1 --oneline "$branch")"
        
        read -p "Delete this branch? [y/N/q] " response
        case $response in
            [Yy])
                git branch -d "$branch"
                echo -e "${GREEN}Deleted $branch${NC}"
                ;;
            [Qq])
                echo "Cleanup aborted"
                exit 0
                ;;
            *)
                echo "Skipped $branch"
                ;;
        esac
    done
}

# Generate full report
cmd_report() {
    local main_branch=$(get_main_branch)
    local stale_days=30
    
    cat << EOF
# Branch Audit Report
Generated: $(date)
Repository: $(basename $(git rev-parse --show-toplevel))
Main branch: $main_branch

## Summary

- Total local branches: $(git branch | wc -l)
- Total remote branches: $(git branch -r | wc -l)
- Merged to $main_branch: $(git branch --merged "$main_branch" | wc -l)
- Not merged: $(git branch --no-merged "$main_branch" | wc -l)

## Merged Branches (Safe to Delete)

EOF
    
    git branch --merged "$main_branch" --format='%(refname:short)' | grep -v "^$main_branch$" | while read branch; do
        echo "- $branch ($(get_days_since_commit "$branch") days old)"
    done
    
    cat << EOF

## Unmerged Branches

EOF
    
    git branch --no-merged "$main_branch" --format='%(refname:short)' | while read branch; do
        local days=$(get_days_since_commit "$branch")
        local commits=$(git rev-list --count "$main_branch".."$branch" 2>/dev/null || echo "?")
        echo "- $branch: $commits commits ahead, $days days old"
    done
    
    cat << EOF

## Stale Branches (> $stale_days days)

EOF
    
    for branch in $(git branch --format='%(refname:short)'); do
        local days=$(get_days_since_commit "$branch")
        if [[ "$days" != "unknown" && "$days" -gt "$stale_days" ]]; then
            echo "- $branch: $days days since last commit"
        fi
    done
    
    cat << EOF

## Recommendations

1. Delete merged branches to reduce clutter
2. Review stale unmerged branches for valuable work
3. Consider archiving or deleting very old branches
4. Enforce branch naming conventions

## Commands

\`\`\`bash
# Delete all merged branches (except main)
git branch --merged main | grep -v "main" | xargs git branch -d

# Delete specific branch
git branch -d <branch-name>

# Force delete unmerged branch (careful!)
git branch -D <branch-name>
\`\`\`
EOF
}

# Parse arguments
STALE_DAYS=30
MAIN_BRANCH=""

while getopts "d:m:h" opt; do
    case $opt in
        d) STALE_DAYS=$OPTARG ;;
        m) MAIN_BRANCH=$OPTARG ;;
        h) usage; exit 0 ;;
        *) usage; exit 1 ;;
    esac
done

shift $((OPTIND - 1))

COMMAND=${1:-list}

case $COMMAND in
    list)    cmd_list ;;
    orphan)  cmd_orphan $STALE_DAYS ;;
    stale)   cmd_stale $STALE_DAYS ;;
    merged)  cmd_merged ;;
    unmerged) cmd_unmerged ;;
    age)     cmd_age ;;
    cleanup) cmd_cleanup ;;
    report)  cmd_report ;;
    help)    usage ;;
    *)       echo "Unknown command: $COMMAND"; usage; exit 1 ;;
esac
