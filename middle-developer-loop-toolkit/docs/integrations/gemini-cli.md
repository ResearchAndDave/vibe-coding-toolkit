# Gemini CLI Integration

How to use the Middle Developer Loop Toolkit with Gemini CLI.

## Setup

### 1. Initialize Templates

```bash
# From toolkit directory
./scripts/init-middle-loop.sh /path/to/your-project --full
```

### 2. Configure GEMINI.md (Optional)

Gemini CLI reads `GEMINI.md` from your project root if present:

```bash
cp AGENTS.md GEMINI.md
```

### 3. File Placement

```
your-project/
├── GEMINI.md              # Auto-read by Gemini CLI
├── AGENTS.md              # Human-readable copy
├── SESSION_HANDOFF.md     # Session state
└── AGENT_STATUS.md        # Multi-agent tracking
```

## Session Management

### Starting a Session

**Option A: Resume Previous Session (v0.20.0+)**
```bash
# Resume most recent session
gemini --resume

# Or list and pick
gemini --list-sessions
gemini --resume 1  # Resume by index
```

After resuming, verify:
```
Summarize where we left off and what we should do next.
```

**Option B: Fresh Start with Manual Context**
```bash
gemini
```
Then:
```
Read AGENTS.md and SESSION_HANDOFF.md.
Summarize the current state and next steps.
```

### During a Session

**Read files:**
```
Read src/auth/service.ts and explain the authentication flow.
```

**Edit files:**
```
Update src/auth/service.ts to add input validation.
```

**Run commands:**
```
Run npm test and show me the results.
```

**Use slash commands:**
```
/resume   - Browse and resume past sessions
```

### Ending a Session

Sessions auto-save in v0.20.0+, but manual handoff is still valuable:

```
We're wrapping up. Please update SESSION_HANDOFF.md with:
1. What we accomplished
2. Current code state (compiles? tests?)
3. What to do next
4. Key decisions and gotchas
```

Then commit:
```bash
git add SESSION_HANDOFF.md
git commit -m "Update session handoff"
```

## Gemini CLI Features

### Session Persistence (v0.20.0+)
- Sessions auto-save (no manual `/chat save` needed)
- Sessions are project-directory scoped
- Stored in `~/.gemini/tmp/<project_hash>/chats/`

### Session Browser
The `/resume` command opens an interactive browser:
- Browse past sessions with timestamps
- Press `/` to search across session content
- Press `Enter` to resume selected session

### Configuration
Edit `~/.gemini/settings.json`:
```json
{
  "sessionRetention": "30d"  // How long to keep sessions
}
```

## Multi-Agent with Gemini CLI

### Running Multiple Instances

**Terminal 1 (Agent A):**
```bash
cd /path/to/project
git checkout -b feature-a
gemini
```
```
You are Agent A working on authentication.
Your files: src/auth/*
DO NOT modify: src/api/*, src/db/*
Read AGENTS.md for rules.
```

**Terminal 2 (Agent B):**
```bash
cd /path/to/project
git checkout -b feature-b
gemini
```
```
You are Agent B working on the API layer.
Your files: src/api/*
DO NOT modify: src/auth/*, src/db/*
Read AGENTS.md for rules.
```

### Tracking Agents

Update AGENT_STATUS.md as you switch between terminals:

```markdown
| Agent | Branch | Task | Status |
|-------|--------|------|--------|
| A | feature-a | Auth module | 🟢 Active |
| B | feature-b | API endpoints | 🟡 Waiting |
```

## Command Reference

| Command | Purpose |
|---------|---------|
| `gemini` | Start new session |
| `gemini --resume` | Resume most recent session |
| `gemini --resume N` | Resume session by index |
| `gemini --list-sessions` | List all saved sessions |
| `/resume` | Interactive session browser |

## Tips

1. **Use GEMINI.md**: Gemini CLI reads it automatically at session start

2. **Trust auto-save**: Sessions persist automatically in v0.20.0+

3. **Use /resume for search**: The session browser lets you search content

4. **Verify after resume**: Always confirm Gemini's understanding of context

5. **Separate branches for agents**: Prevents file conflicts in multi-agent work

## Troubleshooting

### "Session resume seems incomplete"
- Check `gemini --list-sessions` for session age
- Older sessions may have been pruned
- Fall back to SESSION_HANDOFF.md content

### "Gemini not reading project rules"
- Check GEMINI.md exists in project root
- Manually ask: "Read GEMINI.md and follow those rules"

### "Multiple agents conflicting"
- Use separate git branches per agent
- Check AGENT_STATUS.md for file ownership
- Be more explicit about boundaries in prompts

### "Sessions not persisting"
- Ensure you're on v0.20.0 or later: `gemini --version`
- Check settings.json for sessionRetention
- Sessions are directory-scoped - same directory required
