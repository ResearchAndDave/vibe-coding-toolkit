# Context Window Management
<!-- Preventing context saturation before it kills your session -->

## The Problem

> "Steve's team described how AI models begin to forget critical instructions 
> when the context window is only 50% full."
> — Chapter 15, Vibe Coding

AI context windows are limited. When they fill up:
- AI forgets earlier instructions
- Quality of responses degrades
- Auto-compaction may lose important context
- Sessions can become unusable

---

## Context Usage Guidelines

### Zones

| Usage | Zone | Action |
|-------|------|--------|
| 0-50% | 🟢 Safe | Work normally |
| 50-70% | 🟡 Caution | Monitor closely, prepare to compact |
| 70-90% | 🔴 Danger | Compact soon, document state |
| 90%+ | ⚫ Critical | Stop, compact immediately |

### Warning Signs

**Early Signs** (50-70%):
- AI occasionally forgets recent instructions
- Needs more reminders
- Slightly slower responses

**Serious Signs** (70-90%):
- Repeating mistakes you corrected
- Forgetting project rules
- Conflicting with earlier decisions
- Verbose, unfocused responses

**Critical Signs** (90%+):
- Major context loss
- Inability to follow instructions
- Auto-compaction triggered unexpectedly

---

## Proactive Management

### Before Sessions
- [ ] Start with clear, focused context
- [ ] Don't load unnecessary files
- [ ] Summarize rather than paste full docs

### During Sessions
- [ ] Monitor context usage (if visible)
- [ ] Keep file reads targeted
- [ ] Remove outdated context when possible
- [ ] Summarize progress periodically

### Before Compaction
- [ ] Have AI document current state
- [ ] Save all important decisions
- [ ] Write SESSION_HANDOFF.md
- [ ] Commit any changes

---

## Compaction Process

### When to Compact
- Context approaching 50% (proactive)
- Noticing quality degradation
- Switching to unrelated task
- Natural break in work

### Safe Compaction Steps

1. **Pause current work**
   ```
   Let's pause here. We're going to clear context to keep things fresh.
   ```

2. **Document state**
   ```
   Before we clear context, please write down:
   1. What we've accomplished
   2. Current state of the code
   3. What we were about to do
   4. Any important decisions or context
   
   Save this to SESSION_HANDOFF.md
   ```

3. **Verify documentation**
   - Read what AI wrote
   - Add anything missing
   - Commit changes

4. **Clear and resume**
   - Clear context / start new session
   - Load fresh context with handoff notes
   - Resume work
   
   **Or use native resume** (if available):
   ```bash
   # Claude Code
   claude --continue      # Most recent session
   claude --resume        # Interactive picker
   
   # Gemini CLI (v0.20.0+)
   gemini --resume        # Most recent session
   gemini --list-sessions # See all sessions
   ```
   Still verify AI's understanding even with native resume.

### Compaction Prompt
```
We need to compact context. Please:

1. Write a comprehensive summary of our session to SESSION_HANDOFF.md:
   - Work completed
   - Current code state
   - Next steps (specific)
   - Key decisions made
   - Any gotchas for later

2. List files that were modified

3. Confirm everything important is captured

After you write the handoff, I'll start a fresh session.
```

---

## Context-Efficient Practices

### Loading Files
```
# Good: Targeted read
"Read the handleAuth function from src/auth/service.ts"

# Bad: Full file load
"Read src/auth/service.ts" (2000 lines)
```

### Sharing Information
```
# Good: Summarized
"The auth module uses JWT tokens, validates against Redis, 
and throws AuthError on failure."

# Bad: Full dump
[Pastes 500 lines of code]
```

### Instructions
```
# Good: Concise
"Add input validation to handleUser"

# Bad: Verbose
"I would like you to please add some validation to 
the handleUser function. The validation should check 
that the input is valid and if it's not valid it should..."
```

### History
```
# Good: Relevant summary
"Earlier we decided to use Redis for sessions because of 
horizontal scaling requirements."

# Bad: Full conversation replay
[Re-explains entire conversation history]
```

---

## What to Keep vs. Discard

### Keep in Context
- Current task details
- Relevant code sections
- Recent decisions
- Active golden rules
- Error messages being debugged

### Safe to Discard
- Completed task details
- Old debugging attempts
- Superseded decisions
- Verbose explanations (summarize instead)
- Files no longer being modified

---

## Multi-Session Context Strategy

### Short Tasks (< 30 min)
- Minimal context management
- Compact at natural end

### Medium Tasks (1-2 hours)
- Check context at 50%
- One planned compaction mid-session
- Document at each checkpoint

### Long Tasks (2+ hours)
- Multiple planned compactions
- Strong handoff documentation
- Consider task decomposition

### Multi-Day Tasks
- Full handoff at each session end
- Start each day fresh
- Rely on written documentation

---

## Context Budget Planning

For a typical session, budget:

| Component | % of Context |
|-----------|--------------|
| System prompt / AGENTS.md | 5-10% |
| Current task context | 20-30% |
| Code under modification | 20-30% |
| Conversation history | 20-30% |
| Buffer for responses | 10-20% |

**Total**: ~100% at end of useful session

### If Context Is Filling Fast
- Task may be too large → Decompose
- Loading too many files → Be selective
- Verbose conversation → Be concise
- Debug loops eating context → Compact and restart

---

## Recovery from Context Issues

### Lost Critical Context
```
1. Stop current work
2. Check SESSION_HANDOFF.md
3. Check git log for recent commits
4. Reconstruct from documentation
5. Start fresh session with reconstructed context
```

### AI Forgetting Instructions
```
1. Remind of specific instruction
2. If persists, check context usage
3. If high, compact and restart
4. Put critical instructions in AGENTS.md
```

### Degraded Response Quality
```
1. Check context usage
2. Compact if above 70%
3. Start fresh with clean context
4. Be more selective about what you load
```

---

## Quick Reference

### Proactive Compaction
```
At ~50% context:
1. "Let's document progress before continuing"
2. AI writes handoff doc
3. Review and supplement
4. Clear context
5. Resume with fresh context + handoff notes
```

### Emergency Compaction
```
At 90%+ or quality degraded:
1. "Stop - context is full"
2. Quick state dump
3. Commit everything
4. Start new session
5. Reload minimal context
```

---

> "The more frequently you checkpoint, the more options you have."
> — Chapter 15, Vibe Coding

**Apply this to context too: The more frequently you manage context, 
the better your AI collaboration.**
