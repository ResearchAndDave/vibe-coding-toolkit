#!/bin/bash
# install.sh - Install the Inner Developer Loop Toolkit
#
# Usage:
#   ./install.sh              # Make scripts executable only
#   ./install.sh --link       # Also symlink to ~/.local/bin
#   ./install.sh --alias      # Generate shell aliases to add to your rc file

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$SCRIPT_DIR/scripts"
BIN_DIR="${HOME}/.local/bin"

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

# Make all scripts executable
make_executable() {
    log_info "Making scripts executable..."
    chmod +x "$SCRIPTS_DIR"/*.sh
    chmod +x "$SCRIPT_DIR/install.sh"
    log_success "Scripts are now executable"
}

# Create symlinks in ~/.local/bin
create_symlinks() {
    log_info "Creating symlinks in $BIN_DIR..."

    mkdir -p "$BIN_DIR"

    for script in "$SCRIPTS_DIR"/*.sh; do
        local name=$(basename "$script" .sh)
        local target="$BIN_DIR/$name"

        if [ -L "$target" ]; then
            rm "$target"
        fi

        ln -s "$script" "$target"
        log_success "Linked: $name -> $script"
    done

    echo ""
    if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
        log_warn "$BIN_DIR is not in your PATH"
        echo "Add this to your shell rc file:"
        echo ""
        echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
        echo ""
    else
        log_success "Commands available: checkpoint, test-runner, verify-ai-claims, lint-and-correct"
    fi
}

# Generate aliases for shell rc file
generate_aliases() {
    log_info "Shell aliases (add to ~/.bashrc or ~/.zshrc):"
    echo ""
    echo "# Inner Developer Loop Toolkit"
    echo "alias checkpoint='$SCRIPTS_DIR/checkpoint.sh'"
    echo "alias test-runner='$SCRIPTS_DIR/test-runner.sh'"
    echo "alias verify-ai-claims='$SCRIPTS_DIR/verify-ai-claims.sh'"
    echo "alias lint-and-correct='$SCRIPTS_DIR/lint-and-correct.sh'"
    echo ""
    echo "# Shortcuts"
    echo "alias ck='$SCRIPTS_DIR/checkpoint.sh'"
    echo "alias tr='$SCRIPTS_DIR/test-runner.sh'"
    echo "alias vai='$SCRIPTS_DIR/verify-ai-claims.sh'"
    echo "alias lac='$SCRIPTS_DIR/lint-and-correct.sh'"
    echo ""
}

# Show usage
usage() {
    cat << EOF
Inner Developer Loop Toolkit Installer

Usage: ./install.sh [OPTIONS]

Options:
    (none)      Make scripts executable only
    --link      Also create symlinks in ~/.local/bin
    --alias     Print shell aliases to add to your rc file
    --help      Show this help

Examples:
    ./install.sh              # Basic install
    ./install.sh --link       # Install + add to PATH via symlinks
    ./install.sh --alias >> ~/.zshrc   # Add aliases to zsh

EOF
}

# Main
main() {
    echo ""
    echo "=================================="
    echo " Inner Developer Loop Toolkit"
    echo "=================================="
    echo ""

    case "${1:-}" in
        --link)
            make_executable
            echo ""
            create_symlinks
            ;;
        --alias)
            make_executable
            echo ""
            generate_aliases
            ;;
        --help|-h)
            usage
            ;;
        "")
            make_executable
            echo ""
            log_info "Scripts are ready to use from: $SCRIPTS_DIR"
            echo ""
            echo "Run with --link to add commands to PATH"
            echo "Run with --alias to generate shell aliases"
            ;;
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac

    echo ""
    log_success "Installation complete"
}

main "$@"
