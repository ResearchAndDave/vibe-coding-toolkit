# Claude Code Integration

How to use the Middle Developer Loop Toolkit with Claude Code (CLI).

## Setup

### 1. Initialize Templates

```bash
# From toolkit directory
./scripts/init-middle-loop.sh /path/to/your-project --full
```

### 2. Create CLAUDE.md (Optional but Recommended)

Claude Code automatically reads `CLAUDE.md` from your project root. You can include your AGENTS.md content here:

```bash
# Option A: Symlink AGENTS.md as CLAUDE.md
ln -s AGENTS.md CLAUDE.md

# Option B: Create separate CLAUDE.md with project-specific additions
cat AGENTS.md > CLAUDE.md
echo "" >> CLAUDE.md
echo "## Additional Claude Code Notes" >> CLAUDE.md
```

### 3. File Placement

```
your-project/
├── CLAUDE.md           # Auto-read by Claude Code
├── AGENTS.md           # Golden rules (can be same as CLAUDE.md)
├── SESSION_HANDOFF.md  # Session state
└── AGENT_STATUS.md     # Multi-agent tracking (if needed)
```

## Session Management

### Starting a Session

Claude Code has built-in session persistence. You have two options:

**Option A: Resume Previous Session**
```bash
# Resume most recent session
claude --continue

# Or pick from session list
claude --resume
```

After resuming, verify context:
```
Summarize where we left off. What were we working on and what's next?
```

**Option B: Fresh Start with Manual Context**
```bash
claude
```
Then:
```
Read AGENTS.md and SESSION_HANDOFF.md.
Summarize the current state and what we should work on.
```

### During a Session

**Check context usage:**
```
/status
```

**When context is filling (>50%):**
```
/compact
```
This summarizes the conversation to free up space.

**Before compacting, save state:**
```
Before we compact, please update SESSION_HANDOFF.md with:
1. What we've done
2. Current code state
3. What's next
4. Key decisions made
```

### Ending a Session

**Standard end:**
```
We're wrapping up. Please update SESSION_HANDOFF.md with full handoff notes.
```

**Then commit:**
```bash
git add SESSION_HANDOFF.md
git commit -m "Update session handoff"
```

## Multi-Agent with Claude Code

### Running Multiple Instances

Open separate terminals:

**Terminal 1 (Agent A):**
```bash
cd /path/to/project
git checkout -b feature-a
claude
```
```
You are Agent A. Your task is [X].
Your files: src/module-a/*
DO NOT modify: src/module-b/*
Read AGENTS.md for project rules.
```

**Terminal 2 (Agent B):**
```bash
cd /path/to/project
git checkout -b feature-b
claude
```
```
You are Agent B. Your task is [Y].
Your files: src/module-b/*
DO NOT modify: src/module-a/*
Read AGENTS.md for project rules.
```

### Tracking Agents

Keep AGENT_STATUS.md open in an editor and update manually as you switch between terminals.

## Useful Commands

| Command | Purpose |
|---------|---------|
| `claude --continue` | Resume most recent session |
| `claude --resume` | Interactive session picker |
| `/status` | Check context usage |
| `/compact` | Summarize to free context |
| `/clear` | Clear conversation (start fresh) |

## Tips

1. **Use CLAUDE.md**: Claude Code reads it automatically, reducing manual context loading

2. **Compact proactively**: Don't wait until context is full

3. **Commit before resuming**: Native resume works best when code state matches session state

4. **Verify after resume**: Always ask Claude to summarize understanding after `--continue`

5. **Session scope**: Sessions are directory-scoped, so switching projects starts fresh

## Troubleshooting

### "Context seems stale after resume"
- Run `/status` to check context usage
- Use `/compact` if high
- Fall back to SESSION_HANDOFF.md for key context

### "Claude forgot project rules"
- Check if CLAUDE.md exists in project root
- Manually remind: "Read AGENTS.md and follow those rules"

### "Multiple agents conflicting"
- Use separate git branches
- Check file ownership in AGENT_STATUS.md
- More explicit boundary instructions to each agent
