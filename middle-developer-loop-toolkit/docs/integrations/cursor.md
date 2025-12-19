# Cursor Integration

How to use the Middle Developer Loop Toolkit with Cursor IDE.

## Setup

### 1. Initialize Templates

```bash
# From toolkit directory
./scripts/init-middle-loop.sh /path/to/your-project --full
```

### 2. Configure Cursor Rules

Cursor reads rules from `.cursor/rules/` or `.cursorrules`. You can integrate AGENTS.md:

**Option A: Create .cursorrules from AGENTS.md**
```bash
cp AGENTS.md .cursorrules
```

**Option B: Use .cursor/rules/ directory**
```bash
mkdir -p .cursor/rules
cp AGENTS.md .cursor/rules/project-rules.md
```

### 3. File Placement

```
your-project/
├── .cursor/
│   └── rules/
│       └── project-rules.md  # Cursor auto-reads this
├── .cursorrules              # Alternative location
├── AGENTS.md                 # Human-readable copy
├── SESSION_HANDOFF.md        # Session state
└── AGENT_STATUS.md           # Multi-agent tracking
```

## Session Management

### Starting a Session

Cursor maintains conversation history within the IDE, but context resets when you close Cursor or start a new chat.

**New chat with context:**
1. Open Cursor chat (Cmd/Ctrl + L)
2. Start with:
```
Read SESSION_HANDOFF.md and summarize where we left off.
What should we work on next?
```

**Or reference files directly:**
1. Select SESSION_HANDOFF.md in file tree
2. Cmd/Ctrl + L to add to chat
3. Ask: "Based on this handoff, what's our next step?"

### During a Session

**Use @-mentions for context:**
```
@SESSION_HANDOFF.md What was the last thing we worked on?
@AGENTS.md What are the project rules for error handling?
```

**Add files to context:**
- Drag files into chat
- Use @filename syntax
- Select code and Cmd/Ctrl + L

### Ending a Session

Before closing Cursor or starting new work:

```
Please update SESSION_HANDOFF.md with:
1. What we accomplished
2. Current code state
3. Next steps
4. Any decisions or gotchas
```

**Or use Cursor's edit feature:**
1. Open SESSION_HANDOFF.md
2. Select the content
3. Cmd/Ctrl + K for inline edit
4. Prompt: "Update this handoff with today's session"

## Cursor-Specific Features

### Using @ References

```
@AGENTS.md - Reference project rules
@SESSION_HANDOFF.md - Reference session state
@src/module/ - Reference entire directory
@package.json - Reference specific file
```

### Composer Mode

For larger changes, use Composer (Cmd/Ctrl + I):

1. Start Composer
2. Add context: "Following rules in @AGENTS.md..."
3. Describe the task
4. Review and apply changes

### Inline Editing

For quick updates to SESSION_HANDOFF.md:
1. Select text to update
2. Cmd/Ctrl + K
3. Describe the update

## Multi-Agent with Cursor

Cursor doesn't have native multi-agent support, but you can:

### Option 1: Multiple Chat Tabs
- Open multiple chat panels
- Assign each to different parts of codebase
- Manually coordinate

### Option 2: Use with Terminal Agents
- Use Cursor for UI/frontend work
- Use Claude Code in terminal for backend work
- Track in AGENT_STATUS.md

### Option 3: Sequential Work
- Focus on one task at a time
- Use SESSION_HANDOFF.md for continuity
- More reliable than parallel attempts

## Tips

1. **Use .cursorrules**: Put critical rules here so Cursor always knows them

2. **@ is your friend**: Reference files directly instead of pasting content

3. **Composer for multi-file**: Use Composer mode for changes spanning multiple files

4. **Pin context files**: Keep AGENTS.md and SESSION_HANDOFF.md easily accessible

5. **Commit before switching**: Always commit before starting a new chat thread

## Troubleshooting

### "Cursor ignoring my rules"
- Check .cursorrules exists and is valid
- Rules may be too long - prioritize
- Explicitly reference: "Following @.cursorrules..."

### "Lost context between chats"
- Use SESSION_HANDOFF.md religiously
- @ reference it at start of each chat
- Keep handoff notes detailed

### "Changes in wrong files"
- Use @ to be explicit about file scope
- "Only modify @src/auth/*, nothing else"
- Review changes before accepting
