# GitHub Copilot Integration

How to use the Middle Developer Loop Toolkit with GitHub Copilot.

## Setup

### 1. Initialize Templates

```bash
# From toolkit directory
./scripts/init-middle-loop.sh /path/to/your-project --full
```

### 2. Configure Copilot Instructions

Copilot Chat reads instructions from `.github/copilot-instructions.md`:

```bash
mkdir -p .github
cp AGENTS.md .github/copilot-instructions.md
```

### 3. File Placement

```
your-project/
├── .github/
│   └── copilot-instructions.md  # Copilot auto-reads this
├── AGENTS.md                    # Human-readable copy
├── SESSION_HANDOFF.md           # Session state
└── AGENT_STATUS.md              # Multi-agent tracking
```

## Session Management

### Understanding Copilot's Context Model

GitHub Copilot has two main modes:
- **Code completion**: Inline suggestions (context is current file)
- **Copilot Chat**: Conversational (context is selected code + open files)

Neither has persistent session memory across restarts.

### Starting a Session

**In VS Code with Copilot Chat:**
1. Open Copilot Chat panel
2. Reference handoff:
```
#file:SESSION_HANDOFF.md

Based on this handoff, summarize where we are and what's next.
```

**In GitHub.com:**
1. Open Copilot Chat
2. Paste SESSION_HANDOFF.md content (file references not supported)

### During a Session

**Reference files with #file:**
```
#file:AGENTS.md What are the testing requirements?
#file:src/auth/service.ts Review this for security issues
```

**Reference selections:**
1. Select code in editor
2. Open Copilot Chat
3. Selection is automatically included

**Use slash commands:**
```
/explain - Explain selected code
/fix - Fix issues in selection
/tests - Generate tests for selection
```

### Ending a Session

Copilot Chat doesn't persist well, so manual handoff is essential:

```
Please write a session handoff document covering:
1. What we accomplished
2. Current code state
3. Next steps
4. Key decisions

Format as markdown for SESSION_HANDOFF.md
```

Copy the output to SESSION_HANDOFF.md manually.

## Copilot-Specific Features

### File References
```
#file:path/to/file.ts - Include file content
#file:AGENTS.md - Include project rules
```

### Slash Commands
| Command | Purpose |
|---------|---------|
| `/explain` | Explain selected code |
| `/fix` | Suggest fixes for issues |
| `/tests` | Generate tests |
| `/doc` | Generate documentation |
| `/simplify` | Simplify complex code |

### Workspace Context
Copilot can search your workspace:
```
@workspace Where is authentication handled?
@workspace Find all API endpoints
```

## Multi-Agent with Copilot

Copilot doesn't support multiple concurrent sessions, but you can:

### Sequential Agents
1. Work on Task A in one Copilot Chat session
2. Document in SESSION_HANDOFF.md
3. Clear chat or start new conversation
4. Work on Task B
5. Merge via git

### Copilot + Claude Code
- Use Copilot for inline completions and quick edits
- Use Claude Code for complex multi-file tasks
- Track in AGENT_STATUS.md

## Tips

1. **Use #file generously**: Copilot Chat has limited context awareness

2. **Keep copilot-instructions.md concise**: Long files may be truncated

3. **Leverage @workspace**: For finding code across the project

4. **Manual handoff is essential**: Copilot has no session persistence

5. **Selection matters**: Select relevant code before asking questions

## Workspace Agent Features

If using GitHub Copilot Workspace (beta):

### Task-Based Development
1. Describe task in natural language
2. Copilot creates implementation plan
3. Review and iterate on plan
4. Generate code across multiple files

### Integration with Toolkit
- Start with SESSION_HANDOFF.md context
- Let Workspace handle implementation
- Update SESSION_HANDOFF.md after completion

## Troubleshooting

### "Copilot ignoring instructions"
- Check .github/copilot-instructions.md exists
- File may be too long - keep under 500 lines
- Explicitly reference: "#file:.github/copilot-instructions.md"

### "Lost context frequently"
- Copilot Chat doesn't persist - this is normal
- Always start with #file:SESSION_HANDOFF.md
- Consider Claude Code for complex multi-turn work

### "Suggestions don't match project style"
- Ensure copilot-instructions.md has style rules
- Open example files in adjacent tabs
- Be explicit in comments above code
