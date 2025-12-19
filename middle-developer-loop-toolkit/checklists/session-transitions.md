# Session Transitions Checklist
<!-- Rituals for starting and ending AI coding sessions -->

## The Problem

> "Your AI assistant effectively walks into a closet and forgets everything 
> at the end of each chat session. When you fire up a new conversation, it 
> starts with a completely blank slate."
> — Chapter 15, Vibe Coding

**You** are responsible for carrying project state forward.

---

## Starting a Session

### 1. Orient Yourself (2-3 min)
- [ ] Check git status and current branch
- [ ] Review recent commits
- [ ] Note any uncommitted changes

```bash
git status
git log --oneline -5
git branch -v
```

### 2. Load Context (2-3 min)
- [ ] Read AGENTS.md (golden rules)
- [ ] Read SESSION_HANDOFF.md from last session
- [ ] Review AGENT_STATUS.md (if multi-agent)

### 3. Brief the AI (1-2 min)
- [ ] Provide project context
- [ ] Share relevant handoff notes
- [ ] State today's goals

**Opening Prompt Template**:
```
We're continuing work on [project]. 

Here's where we left off:
[Paste key points from SESSION_HANDOFF.md]

Today's goal: [Primary objective]

Before we start, please confirm you understand the context.
```

### 4. Verify State (1-2 min)
- [ ] Confirm AI understands the codebase
- [ ] Run tests to verify baseline
- [ ] Check that services start correctly

```bash
npm test  # or equivalent
npm start  # quick smoke test
```

---

## During a Session

### Regular Check-ins (Every 15-30 min)
- [ ] Is AI still on track?
- [ ] Context window usage OK?
- [ ] Any signs of confusion?
- [ ] Time to checkpoint?

### Context Management
**At ~50% context remaining**:
- [ ] Have AI summarize progress
- [ ] Write state to SESSION_HANDOFF.md
- [ ] Consider clearing context

**Signs of Context Saturation**:
- Forgetting recent instructions
- Repeating earlier mistakes
- Increased confusion
- Slower responses

### Checkpoints
**Checkpoint after**:
- Completing a subtask
- Tests passing
- Significant progress
- Before risky operations

```bash
git add -A
git commit -m "Checkpoint: [description]"
```

---

## Ending a Session

### 1. Reach a Stopping Point (5-10 min)
- [ ] Complete current subtask (or note where you stopped)
- [ ] Run all tests
- [ ] Verify code is in a good state

### 2. Document State (3-5 min)

**Have AI write SESSION_HANDOFF.md**:
```
Let's wrap up this session. Please write a handoff document covering:
1. What we accomplished
2. Current state of the code
3. Any uncommitted changes
4. What to do next
5. Any gotchas or context the next session needs

Be specific enough that we can pick up exactly where we left off.
```

### 3. Review and Supplement
- [ ] Read AI's handoff notes
- [ ] Add anything it missed
- [ ] Correct any inaccuracies
- [ ] Note your own observations

### 4. Commit Everything
- [ ] Stage all changes
- [ ] Write clear commit message
- [ ] Push to remote (backup!)

```bash
git add -A
git status  # Review what's being committed
git commit -m "[Type]: [Description of session's work]"
git push
```

### 5. Clean Up
- [ ] Close unnecessary branches
- [ ] Remove temp files
- [ ] Update AGENT_STATUS.md (if multi-agent)

### 6. Final Verification
- [ ] Changes pushed to remote
- [ ] SESSION_HANDOFF.md updated
- [ ] No broken state left behind
- [ ] Tests still passing

---

## Quick Reference Cards

### 5-Minute Session Start
```
1. git status && git log --oneline -3
2. Read SESSION_HANDOFF.md
3. Tell AI: "Continuing from [last point]. Goal: [X]"
4. Run tests to verify baseline
```

### 5-Minute Session End
```
1. Reach checkpoint, run tests
2. AI writes handoff doc
3. git add -A && git commit -m "[msg]" && git push
4. Verify push succeeded
```

---

## Session Transition Templates

> **More prompts**: See `prompts/agent-handoff.md` for additional prompt templates including multi-agent handoffs, context compaction, and special situations.

### Handoff Request Prompt
```
We need to end this session. Please create a handoff document:

## Session Summary
[What we accomplished]

## Current State  
[Code status: compiles? tests pass? works?]

## Uncommitted Changes
[What's in the working tree]

## Next Steps
[Specific next actions, in order]

## Context to Remember
[Key decisions, gotchas, important details]

## Commands to Resume
[Exact commands to get started next time]
```

### Session Resume Prompt
```
Resuming work from a previous session. Here's the context:

[Paste SESSION_HANDOFF.md content]

Please:
1. Confirm you understand the current state
2. Ask any clarifying questions
3. Then we'll continue with [next step]
```

---

## Handling Interruptions

### Unexpected End (Crash/Emergency)
```
When you return:
1. Check git status for uncommitted work
2. Review git log for last commits
3. Check for any crash logs
4. Reconstruct state as best as possible
5. Document gaps in knowledge
```

### Planned Break (Meeting/Lunch)
```
Quick pause:
1. Commit current work (even partial)
2. Note where you are in SESSION_HANDOFF.md
3. Leave terminal/editor state intact if possible
```

### Long Break (Days/Weeks)
```
Extended pause:
1. Full session end ritual
2. Extra detail in handoff notes
3. Consider creating a project status doc
4. Ensure tests pass
5. Update any project management tools
```

---

## Native Resume Capabilities

Modern AI coding agents have built-in session persistence. Use these when available to supplement (not replace) manual handoffs.

### Claude Code

**Resume from command line**:
```bash
# Resume most recent session
claude --continue
# or
claude -c

# Interactive session picker
claude --resume

# Resume specific session by ID
claude --resume <session-id>
```

**Inside an active session**:
```
/resume    # Opens interactive session picker
/compact   # Summarize to save tokens before break
```

**How it works**:
- Automatically saves conversation history to `~/.claude/projects/`
- Restores full context from previous session
- Sessions are project-directory scoped

**Limitations**:
- Sessions are local-only (no cross-machine sync)
- Auto-compaction near 200K tokens may lose context
- Still benefits from SESSION_HANDOFF.md for key decisions

### Gemini CLI

**Resume from command line** (v0.20.0+):
```bash
# Resume most recent session
gemini --resume
# or
gemini -r

# Resume by index (after listing)
gemini --resume 1

# Resume by session UUID
gemini --resume <session-uuid>

# List all sessions
gemini --list-sessions
```

**Inside an active session**:
```
/resume    # Opens interactive session browser with search
```

**How it works**:
- **Automatic saving** — No manual `/chat save` needed (as of v0.20.0)
- Sessions stored in `~/.gemini/tmp/<project_hash>/chats/`
- Sessions are project-directory scoped

**Session browser features**:
- Browse past sessions with timestamps and message counts
- Press `/` to search across session content
- Press `Enter` to resume selected session

### When to Use Native Resume vs Manual Handoff

| Scenario | Recommended Approach |
|----------|---------------------|
| Quick break (< 1 hour) | Native resume |
| Same-day continuation | Native resume + quick review |
| Next-day continuation | Native resume + SESSION_HANDOFF.md |
| Multi-day break | Full manual handoff ritual |
| Complex multi-file work | Manual handoff (more reliable) |
| Sharing with teammates | Manual handoff (transferable) |
| Context was compacted | Manual handoff (native lost detail) |

### Best Practice: Belt and Suspenders

Even with native resume, maintain manual handoffs:

```
1. Use native resume for convenience
2. Keep SESSION_HANDOFF.md updated for insurance
3. If native resume feels "off", fall back to manual
4. Always verify AI's understanding after resuming
```

**Verification prompt after native resume**:
```
We just resumed from a previous session. Before we continue:
1. Summarize what we were working on
2. What's the current state of the code?
3. What were we about to do next?

Let me verify this matches my notes.
```

### Tool-Specific Tips

**Claude Code**:
- Use `--continue` for quick same-session resume
- Use `--resume` when you need to pick from multiple sessions
- Check context usage with `/status`

**Gemini CLI**:
- Sessions auto-save as of v0.20.0 — no manual save needed
- Use `--list-sessions` to see available sessions before resuming
- Configure retention in `settings.json` (`sessionRetention`)

---

## Common Mistakes

### ❌ Ending Without Handoff
**Result**: Lost context, duplicated work
**Fix**: Always write SESSION_HANDOFF.md

### ❌ Vague Handoff Notes
**Result**: Confusion on resume
**Fix**: Be specific about state and next steps

### ❌ Not Pushing Changes
**Result**: Lost work if local issues
**Fix**: Always push at session end

### ❌ Leaving Broken State
**Result**: Hard to resume
**Fix**: Always reach a checkpoint

### ❌ Skipping AGENTS.md on Start
**Result**: AI doesn't know the rules
**Fix**: Always brief AI on golden rules

---

## Metrics to Track

| Metric | Target |
|--------|--------|
| Time to start session | < 5 min |
| Context loss incidents | 0 per week |
| Sessions ending broken | 0 |
| Time to resume after days | < 15 min |

---

*Based on "The Memento Method" from Chapter 15, Vibe Coding*
