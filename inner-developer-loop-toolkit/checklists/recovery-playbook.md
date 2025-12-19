# Recovery Playbook
<!-- Fix forward or roll back? Decision framework for when things go wrong -->

## Decision Framework

### Quick Decision Tree

```
                    Things Went Wrong
                          │
                          ▼
              ┌─────────────────────┐
              │ Do you understand   │
              │ what went wrong?    │
              └─────────────────────┘
                    │           │
                   Yes          No
                    │           │
                    ▼           ▼
              ┌─────────┐   ┌─────────────┐
              │ Can you │   │ Roll back   │
              │ fix it  │   │ & analyze   │
              │ quickly?│   └─────────────┘
              └─────────┘
               │       │
              Yes      No
               │       │
               ▼       ▼
         ┌─────────┐ ┌─────────────┐
         │ Fix     │ │ Were there  │
         │ Forward │ │ good changes│
         └─────────┘ │ to keep?    │
                     └─────────────┘
                       │         │
                      Yes        No
                       │         │
                       ▼         ▼
               ┌───────────┐ ┌──────────┐
               │ Selective │ │ Full     │
               │ Rollback  │ │ Rollback │
               └───────────┘ └──────────┘
```

---

## Fix Forward

### When to Fix Forward ✅
- You understand what broke
- The fix is straightforward
- Tests still pass (mostly)
- AI made progress worth keeping
- Time to fix < time to roll back and redo

### How to Fix Forward

1. **Identify the issue**
   ```bash
   # Check what changed
   git diff HEAD~5
   
   # Find when tests started failing
   git bisect start
   git bisect bad HEAD
   git bisect good [known-good-commit]
   ```

2. **Isolate the fix**
   ```
   Tell AI: "Stop all other work. Focus only on fixing [specific issue]."
   ```

3. **Fix incrementally**
   ```
   - Make smallest possible fix
   - Run tests
   - Commit if passes
   - Repeat
   ```

4. **Verify completely**
   ```bash
   ./scripts/verify-ai-claims.sh
   ```

---

## Roll Back

### When to Roll Back 🔄
- Don't understand what broke
- Multiple interrelated issues
- Tests completely broken
- Code is incomprehensible
- AI made too many changes to track
- Time spent debugging > time to redo

### How to Roll Back

#### Option A: Soft Rollback (Keep History)
```bash
# Create a revert commit (preserves history)
git revert HEAD~3..HEAD

# Or revert specific commits
git revert abc123 def456
```

#### Option B: Hard Rollback (Clean Slate)
```bash
# WARNING: Destroys commits - use with caution
# First, save current state just in case
git branch backup-branch

# Reset to known good state
git reset --hard [good-commit]

# If already pushed, force push (coordinate with team!)
git push --force-with-lease
```

#### Option C: Selective Rollback
```bash
# Checkout specific files from good commit
git checkout [good-commit] -- path/to/file.ts

# Or cherry-pick good commits
git cherry-pick [good-commit-1] [good-commit-2]
```

### After Rolling Back
1. Document what went wrong
2. Identify what to do differently
3. Start fresh with smaller scope
4. Checkpoint more frequently

---

## Selective Rollback (Best of Both Worlds)

### When to Use
- AI made both good and bad changes
- Some features work, others broken
- Want to keep progress but fix issues

### How to Do It

1. **Identify good vs bad commits**
   ```bash
   # Review recent commits
   git log --oneline -20
   
   # See what each commit changed
   git show [commit] --stat
   ```

2. **Create a recovery branch**
   ```bash
   git checkout -b recovery-branch [last-known-good]
   ```

3. **Cherry-pick good commits**
   ```bash
   git cherry-pick [good-commit-1]
   git cherry-pick [good-commit-2]
   # Skip bad commits
   ```

4. **Test after each pick**
   ```bash
   npm test  # or equivalent
   ```

5. **Merge back when stable**
   ```bash
   git checkout main
   git merge recovery-branch
   ```

---

## Git Bisect: Finding Where It Broke

### When to Use
- Tests were passing, now failing
- Don't know which commit caused the issue
- Multiple commits between good and bad

### How to Bisect

```bash
# Start bisect
git bisect start

# Mark current (broken) as bad
git bisect bad

# Mark known working commit as good
git bisect good [commit-hash]

# Git will checkout middle commit
# Test it, then mark:
git bisect good  # if this commit works
git bisect bad   # if this commit is broken

# Repeat until Git finds the culprit
# Git will show: "first bad commit is..."

# When done
git bisect reset
```

### Automated Bisect
```bash
# If you have a test that reproduces the issue:
git bisect start
git bisect bad HEAD
git bisect good [good-commit]
git bisect run npm test  # or any command that returns 0 on success
```

---

## Recovery Scenarios

### Scenario 1: "Godzilla and Tokyo"
**Situation**: AI made sweeping changes, everything is broken

**Response**:
1. `git branch disaster-backup` (save current state)
2. `git reset --hard [last-known-good]`
3. Document what went wrong
4. Restart with much smaller scope
5. Checkpoint after every small success

### Scenario 2: Tests Pass But Feature Broken
**Situation**: Tests green but feature doesn't work

**Response**:
1. Don't trust the tests
2. Write a test that actually fails (for the broken behavior)
3. Fix forward with new test as guide
4. Review existing tests for gaps

### Scenario 3: One File Corrupted
**Situation**: Single file is a mess, rest is fine

**Response**:
```bash
# Recover just that file
git checkout [good-commit] -- path/to/broken-file.ts

# Or start fresh on just that file
git diff [good-commit] -- path/to/broken-file.ts > changes.patch
# Review patch, apply good parts manually
```

### Scenario 4: Merge Conflict Hell
**Situation**: Multiple agents/branches conflicting

**Response**:
1. Pick the most complete branch as base
2. `git merge --abort` any in-progress merges
3. Manually integrate changes one file at a time
4. Test after each integration

### Scenario 5: AI Committed Without Permission
**Situation**: AI auto-committed broken code

**Response**:
```bash
# Undo the commit but keep changes
git reset --soft HEAD~1

# Review changes
git diff --cached

# Discard bad, keep good
git reset HEAD path/to/bad-file.ts
git checkout -- path/to/bad-file.ts
```

---

## Prevention (After Recovery)

### Update Your Process
- [ ] Checkpoint more frequently
- [ ] Smaller task scope
- [ ] More verification between steps
- [ ] Update AGENTS.md with lessons learned

### Update AGENTS.md
```markdown
## Lessons Learned
- [Date]: Don't let AI modify [X] without explicit approval
- [Date]: Always verify [Y] before proceeding
```

### Recovery Metrics
Track to improve:
| Metric | This Incident |
|--------|---------------|
| Time to detect | |
| Time to recover | |
| Commits lost | |
| Work hours lost | |
| Root cause | |

---

## Quick Reference

| Situation | Action | Time |
|-----------|--------|------|
| Single test failing | Fix forward | 5-15 min |
| Multiple tests failing | Assess, maybe rollback | 15-30 min |
| Build broken | Roll back | Immediate |
| Feature broken, tests pass | Fix tests first | 30+ min |
| Everything broken | Roll back | Immediate |
| Don't understand changes | Roll back | Immediate |

---

## Emergency Commands

```bash
# See what happened
git log --oneline -20
git diff HEAD~5

# Save current disaster
git branch oh-no-backup

# Nuclear option
git reset --hard [known-good-commit]

# Find the culprit
git bisect start && git bisect bad && git bisect good [commit]

# Just undo last commit
git reset --soft HEAD~1
```

---

> "The more frequently you checkpoint, the more options you have."
> — Chapter 14, Vibe Coding

**When in doubt, roll back. Time spent on broken code is time wasted.**
