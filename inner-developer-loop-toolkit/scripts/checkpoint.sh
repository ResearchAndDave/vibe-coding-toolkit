#!/bin/bash
# checkpoint.sh - Automated Git checkpointing for vibe coding
# Part of the Inner Developer Loop Toolkit

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DEFAULT_BRANCH="main"
CHECKPOINT_PREFIX="checkpoint"
AUTO_PUSH=${AUTO_PUSH:-false}

usage() {
    cat << EOF
Usage: $(basename "$0") [COMMAND] [OPTIONS]

Commands:
    save [message]     Create a checkpoint with optional message
    explore [name]     Create a new branch for risky exploration
    abandon            Abandon current exploration, return to main
    recover [commit]   Recover to a specific checkpoint
    list               List recent checkpoints
    bisect             Start git bisect to find where things broke
    status             Show current checkpoint status

Options:
    -h, --help         Show this help message
    -p, --push         Push after checkpoint (for save command)
    -f, --force        Force operation without confirmation

Examples:
    $(basename "$0") save "Added user authentication"
    $(basename "$0") explore "risky-refactor"
    $(basename "$0") recover HEAD~3
    $(basename "$0") bisect

EOF
}

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in a git repository
check_git_repo() {
    if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        log_error "Not in a git repository"
        exit 1
    fi
}

# Get current branch name
get_current_branch() {
    git branch --show-current
}

# Check for uncommitted changes
has_changes() {
    ! git diff --quiet || ! git diff --cached --quiet
}

# Check for untracked files
has_untracked() {
    [ -n "$(git ls-files --others --exclude-standard)" ]
}

# Generate timestamp for checkpoint
timestamp() {
    date "+%Y%m%d-%H%M%S"
}

# Command: save - Create a checkpoint
cmd_save() {
    local message="$1"
    local push="$2"
    
    check_git_repo
    
    if ! has_changes && ! has_untracked; then
        log_warning "No changes to checkpoint"
        return 0
    fi
    
    # Default message if none provided
    if [ -z "$message" ]; then
        message="Checkpoint $(timestamp)"
    fi
    
    # Stage all changes
    log_info "Staging all changes..."
    git add -A
    
    # Show what we're committing
    echo ""
    log_info "Changes to be committed:"
    git diff --cached --stat
    echo ""
    
    # Commit
    log_info "Creating checkpoint..."
    git commit -m "$message"
    
    log_success "Checkpoint created: $message"
    
    # Push if requested
    if [ "$push" = "true" ] || [ "$AUTO_PUSH" = "true" ]; then
        log_info "Pushing to remote..."
        git push
        log_success "Pushed to remote"
    fi
    
    # Show current status
    echo ""
    log_info "Current position: $(git rev-parse --short HEAD)"
    log_info "Branch: $(get_current_branch)"
}

# Command: explore - Create a branch for risky work
cmd_explore() {
    local name="$1"
    
    check_git_repo
    
    if [ -z "$name" ]; then
        name="explore-$(timestamp)"
    fi
    
    local branch_name="$name"
    
    # Check for uncommitted changes
    if has_changes || has_untracked; then
        log_warning "You have uncommitted changes"
        read -p "Save them before exploring? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            cmd_save "Pre-exploration checkpoint"
        fi
    fi
    
    log_info "Creating exploration branch: $branch_name"
    git checkout -b "$branch_name"
    
    log_success "Now on branch: $branch_name"
    log_info "Do your risky work. Use 'checkpoint abandon' to discard or merge back to main."
}

# Command: abandon - Abandon current exploration
cmd_abandon() {
    local force="$1"
    
    check_git_repo
    
    local current=$(get_current_branch)
    
    if [ "$current" = "$DEFAULT_BRANCH" ]; then
        log_error "Already on $DEFAULT_BRANCH, nothing to abandon"
        return 1
    fi
    
    if has_changes || has_untracked; then
        if [ "$force" != "true" ]; then
            log_warning "You have uncommitted changes that will be lost!"
            read -p "Really abandon? (y/n) " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                log_info "Abandon cancelled"
                return 0
            fi
        fi
    fi
    
    log_info "Abandoning branch: $current"
    git checkout "$DEFAULT_BRANCH"
    git branch -D "$current"
    
    log_success "Abandoned $current, now on $DEFAULT_BRANCH"
}

# Command: recover - Recover to a previous checkpoint
cmd_recover() {
    local target="$1"
    
    check_git_repo
    
    if [ -z "$target" ]; then
        log_error "Please specify a commit to recover to"
        log_info "Use 'checkpoint list' to see recent checkpoints"
        return 1
    fi
    
    # Verify the commit exists
    if ! git rev-parse "$target" > /dev/null 2>&1; then
        log_error "Invalid commit: $target"
        return 1
    fi
    
    log_warning "This will create a new commit reverting to: $target"
    log_info "Commit: $(git log -1 --oneline "$target")"
    
    read -p "Continue? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "Recovery cancelled"
        return 0
    fi
    
    # Save current state first
    if has_changes || has_untracked; then
        cmd_save "Pre-recovery checkpoint"
    fi
    
    log_info "Recovering to $target..."
    git revert --no-commit "$target"..HEAD
    git commit -m "Recover to checkpoint: $(git log -1 --oneline "$target")"
    
    log_success "Recovered to $target"
}

# Command: list - List recent checkpoints
cmd_list() {
    check_git_repo
    
    local count=${1:-10}
    
    log_info "Recent checkpoints (last $count):"
    echo ""
    git log --oneline -n "$count" --decorate
    echo ""
    log_info "Use 'checkpoint recover <commit>' to restore"
}

# Command: bisect - Start git bisect
cmd_bisect() {
    check_git_repo
    
    log_info "Starting git bisect..."
    log_info "This will help find where things broke."
    echo ""
    
    read -p "Enter the last known good commit (or press Enter for earliest): " good_commit
    
    if [ -z "$good_commit" ]; then
        good_commit=$(git rev-list --max-parents=0 HEAD)
    fi
    
    git bisect start
    git bisect bad HEAD
    git bisect good "$good_commit"
    
    echo ""
    log_info "Bisect started. For each commit, test and run:"
    log_info "  git bisect good    # if this commit works"
    log_info "  git bisect bad     # if this commit is broken"
    log_info "  git bisect reset   # to end bisect"
}

# Command: status - Show checkpoint status
cmd_status() {
    check_git_repo
    
    echo ""
    log_info "Checkpoint Status"
    echo "═══════════════════════════════════════"
    echo ""
    
    echo "Branch:       $(get_current_branch)"
    echo "Last commit:  $(git log -1 --oneline)"
    echo "Commit time:  $(git log -1 --format='%cr')"
    echo ""
    
    if has_changes; then
        log_warning "Uncommitted changes:"
        git diff --stat
        echo ""
    fi
    
    if has_untracked; then
        log_warning "Untracked files:"
        git ls-files --others --exclude-standard
        echo ""
    fi
    
    if ! has_changes && ! has_untracked; then
        log_success "Working tree clean"
    fi
    
    echo ""
    echo "Recent checkpoints:"
    git log --oneline -n 5
}

# Main entry point
main() {
    local command="$1"
    shift || true
    
    case "$command" in
        save)
            local message=""
            local push="false"
            while [[ $# -gt 0 ]]; do
                case "$1" in
                    -p|--push) push="true"; shift ;;
                    *) message="$1"; shift ;;
                esac
            done
            cmd_save "$message" "$push"
            ;;
        explore)
            cmd_explore "$1"
            ;;
        abandon)
            local force="false"
            [[ "$1" == "-f" || "$1" == "--force" ]] && force="true"
            cmd_abandon "$force"
            ;;
        recover)
            cmd_recover "$1"
            ;;
        list)
            cmd_list "$1"
            ;;
        bisect)
            cmd_bisect
            ;;
        status)
            cmd_status
            ;;
        -h|--help|help)
            usage
            ;;
        *)
            if [ -z "$command" ]; then
                cmd_status
            else
                log_error "Unknown command: $command"
                usage
                exit 1
            fi
            ;;
    esac
}

main "$@"
