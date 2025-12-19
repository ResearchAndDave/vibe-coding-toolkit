#!/bin/bash
#
# Initialize Middle Developer Loop templates in a target project
#
# Usage:
#   ./init-middle-loop.sh /path/to/project [--lite] [--full]
#
# Options:
#   --lite    Use minimal templates (default)
#   --full    Use comprehensive templates
#   --force   Overwrite existing files
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOOLKIT_DIR="$(dirname "$SCRIPT_DIR")"

# Default options
USE_LITE=true
FORCE=false
TARGET_DIR=""

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --lite)
            USE_LITE=true
            shift
            ;;
        --full)
            USE_LITE=false
            shift
            ;;
        --force)
            FORCE=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 /path/to/project [--lite|--full] [--force]"
            echo ""
            echo "Options:"
            echo "  --lite    Use minimal templates (default)"
            echo "  --full    Use comprehensive templates"
            echo "  --force   Overwrite existing files"
            echo ""
            echo "Templates installed:"
            echo "  AGENTS.md         - Golden rules for AI sessions"
            echo "  SESSION_HANDOFF.md - Session state documentation"
            echo ""
            echo "With --full, also installs:"
            echo "  AGENT_STATUS.md   - Multi-agent tracking"
            exit 0
            ;;
        *)
            if [[ -z "$TARGET_DIR" ]]; then
                TARGET_DIR="$1"
            else
                echo -e "${RED}Error: Unknown option $1${NC}"
                exit 1
            fi
            shift
            ;;
    esac
done

# Validate target directory
if [[ -z "$TARGET_DIR" ]]; then
    echo -e "${RED}Error: Target directory required${NC}"
    echo "Usage: $0 /path/to/project [--lite|--full] [--force]"
    exit 1
fi

if [[ ! -d "$TARGET_DIR" ]]; then
    echo -e "${RED}Error: Directory does not exist: $TARGET_DIR${NC}"
    exit 1
fi

# Convert to absolute path
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

echo -e "${GREEN}Initializing Middle Developer Loop in: $TARGET_DIR${NC}"
echo ""

# Function to copy file with confirmation
copy_template() {
    local src="$1"
    local dst="$2"
    local name="$(basename "$dst")"

    if [[ -f "$dst" ]] && [[ "$FORCE" != true ]]; then
        echo -e "${YELLOW}Skipping $name (already exists, use --force to overwrite)${NC}"
        return 0
    fi

    cp "$src" "$dst"
    echo -e "${GREEN}Created $name${NC}"
}

# Select template source
if [[ "$USE_LITE" == true ]]; then
    echo "Using lite templates..."
    AGENTS_SRC="$TOOLKIT_DIR/templates-lite/AGENTS_LITE.md"
    HANDOFF_SRC="$TOOLKIT_DIR/templates-lite/SESSION_HANDOFF_LITE.md"
    STATUS_SRC="$TOOLKIT_DIR/templates-lite/AGENT_STATUS_LITE.md"
else
    echo "Using full templates..."
    AGENTS_SRC="$TOOLKIT_DIR/templates/AGENTS.md"
    HANDOFF_SRC="$TOOLKIT_DIR/templates/SESSION_HANDOFF.md"
    STATUS_SRC="$TOOLKIT_DIR/templates/AGENT_STATUS.md"
fi

echo ""

# Copy core templates
copy_template "$AGENTS_SRC" "$TARGET_DIR/AGENTS.md"
copy_template "$HANDOFF_SRC" "$TARGET_DIR/SESSION_HANDOFF.md"

# Copy additional templates for full mode
if [[ "$USE_LITE" != true ]]; then
    copy_template "$STATUS_SRC" "$TARGET_DIR/AGENT_STATUS.md"
fi

echo ""
echo -e "${GREEN}Done!${NC}"
echo ""
echo "Next steps:"
echo "  1. Open AGENTS.md and customize the NEVER/ALWAYS rules"
echo "  2. Add your project's build commands"
echo "  3. Reference AGENTS.md at the start of each AI session"
echo ""
echo "Quick reference:"
echo "  Session start: Read AGENTS.md and SESSION_HANDOFF.md"
echo "  Session end:   Update SESSION_HANDOFF.md before stopping"
echo ""
if [[ "$USE_LITE" == true ]]; then
    echo "Tip: Run with --full for comprehensive templates"
fi
