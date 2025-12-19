# Troubleshooting Guide

Common problems and solutions when using the Middle Developer Loop Toolkit.

---

## Session Continuity Issues

### "AI keeps forgetting project rules"

**Symptoms**: AI ignores conventions, makes forbidden changes, forgets constraints.

**Causes & Solutions**:

| Cause | Solution |
|-------|----------|
| AGENTS.md too long | Trim to 3-5 rules per section |
| Rules too vague | Be specific: "Use async/await" not "Use modern patterns" |
| Not loading at session start | Always start with "Read AGENTS.md" |
| Tool not reading rules file | Check tool-specific file location (CLAUDE.md, .cursorrules, etc.) |

### "Sessions feel like starting over"

**Symptoms**: Losing context, repeating explanations, duplicating work.

**Causes & Solutions**:

| Cause | Solution |
|-------|----------|
| No handoff document | Always update SESSION_HANDOFF.md before ending |
| Handoff too vague | Include specific file names, line numbers, decisions |
| Not reading handoff | Start sessions with "Read SESSION_HANDOFF.md" |
| Native resume failed | Fall back to manual SESSION_HANDOFF.md |

### "Context fills up too fast"

**Symptoms**: AI forgets recent instructions, quality degrades mid-session.

**Causes & Solutions**:

| Cause | Solution |
|-------|----------|
| Loading too many files | Be selective about what you load |
| Verbose conversation | Be concise in requests |
| Not compacting | Compact proactively at 50% |
| Long debugging loops | Checkpoint and restart fresh |

---

## Multi-Agent Issues

### "Agents keep conflicting"

**Symptoms**: Merge conflicts, port collisions, broken builds.

**Causes & Solutions**:

| Cause | Solution |
|-------|----------|
| Overlapping file ownership | Define stricter boundaries in AGENT_STATUS.md |
| Same branch | Use separate branches per agent |
| Same ports | Allocate port ranges per agent |
| Shared test database | Use separate test databases |

### "Agent coordination is exhausting"

**Symptoms**: Constant context switching, losing track of progress.

**Causes & Solutions**:

| Cause | Solution |
|-------|----------|
| Too many agents | Reduce to 2 agents max |
| Tasks too similar | Pick more different tasks to reduce mental overlap |
| No dashboard | Use AGENT_STATUS.md religiously |
| Switching too fast | Spend 5+ minutes per agent before switching |

### "Agents getting confused about scope"

**Symptoms**: Agents working on wrong files, stepping on each other.

**Causes & Solutions**:

| Cause | Solution |
|-------|----------|
| Vague boundaries | Explicit file paths: "src/auth/* only" |
| No negative constraints | Add "DO NOT modify: src/cart/*" |
| Shared dependencies | Define interface first, then implement |

---

## Template Issues

### "Templates are overwhelming"

**Symptoms**: Not using templates because they're too complex.

**Solutions**:
1. Start with `templates-lite/` versions
2. Only fill in sections you need
3. Grow the template as your needs grow
4. Delete unused sections

### "Handoff notes aren't useful"

**Symptoms**: Notes exist but don't help resume work.

**Signs of bad handoff**:
- Generic summaries: "Worked on auth"
- Missing specifics: No file names, no decisions
- No next steps: "Continue working"

**Signs of good handoff**:
- Specific: "Added validateToken() in src/auth/jwt.ts:45"
- Decisions recorded: "Chose RS256 because..."
- Clear next step: "Implement refresh token endpoint"

---

## Tool-Specific Issues

### Claude Code

| Issue | Solution |
|-------|----------|
| `--continue` doesn't remember | Use SESSION_HANDOFF.md as backup |
| CLAUDE.md not being read | Check file is in project root |
| `/compact` loses important context | Document state before compacting |

### Cursor

| Issue | Solution |
|-------|----------|
| .cursorrules ignored | File may be too long, trim it |
| Lost context between chats | Use SESSION_HANDOFF.md + @file references |
| Changes in wrong files | Use explicit @file references |

### GitHub Copilot

| Issue | Solution |
|-------|----------|
| Instructions not followed | copilot-instructions.md may be truncated |
| No session persistence | This is normal, use SESSION_HANDOFF.md |
| Limited context | Use #file references extensively |

### Gemini CLI

| Issue | Solution |
|-------|----------|
| Sessions not persisting | Upgrade to v0.20.0+ |
| Resume seems incomplete | Fall back to SESSION_HANDOFF.md |
| GEMINI.md not read | Check file is in project root |

---

## Workflow Issues

### "Tracer bullets keep failing"

**Symptoms**: Minimal implementations don't work, time box exceeded.

**Causes & Solutions**:

| Cause | Solution |
|-------|----------|
| Scope too large | Make it smaller — absolute minimum |
| Unfamiliar tech | AI may not be trained well on it |
| Missing setup | Check prerequisites before starting |
| Wrong approach | Try different technology/pattern |

**When tracer bullet fails**: Take manual control or pivot technology.

### "Keep-busy prompts not helping"

**Symptoms**: Agent produces low-value output when idle.

**Causes & Solutions**:

| Cause | Solution |
|-------|----------|
| Prompts too vague | Be specific: "Add tests for auth module" |
| Wrong task type | Match task to agent's current context |
| No verification | Always review output when you return |

---

## Recovery Procedures

### Recovering from Interrupted Session

```bash
# Check what's uncommitted
git status

# See recent commits
git log --oneline -10

# Check for stash
git stash list

# Reconstruct state
# 1. Read any temp files
# 2. Check SESSION_HANDOFF.md (may be outdated)
# 3. Review git diff for work in progress
```

### Recovering from Merge Conflicts

```bash
# See what's conflicting
git status

# Option 1: Keep one side
git checkout --ours <file>    # Keep current branch
git checkout --theirs <file>  # Keep incoming branch

# Option 2: Manual merge
# Edit files, then:
git add <resolved-files>
git commit
```

### Recovering from Context Loss

1. Stop current work
2. Check SESSION_HANDOFF.md for last known state
3. Check git log for recent commits
4. Reconstruct context manually
5. Start fresh session with reconstructed context

---

## Prevention Checklists

### Prevent Context Loss
- [ ] Update SESSION_HANDOFF.md before ending
- [ ] Compact before context reaches 70%
- [ ] Commit frequently
- [ ] Push to remote at session end

### Prevent Agent Conflicts
- [ ] Allocate resources before starting agents
- [ ] Use separate branches
- [ ] Define file ownership explicitly
- [ ] Update AGENT_STATUS.md regularly

### Prevent Rule Violations
- [ ] Keep AGENTS.md short and specific
- [ ] Load rules at session start
- [ ] Verify AI understanding before proceeding
- [ ] Add lessons learned after issues

---

*If you encounter an issue not covered here, document it and add to this guide.*
