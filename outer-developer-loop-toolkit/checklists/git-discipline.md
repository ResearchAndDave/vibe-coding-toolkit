# Git Discipline Checklist
<!-- Preventing catastrophic code loss -->

## The Stakes

> "Steve had the same gut-punching panic familiar to anyone who's ever dropped 
> a production database when you know there is no backup. It's that heart-stopping 
> moment where you cycle through the five stages of grief in a few seconds."
> — Chapter 16, Vibe Coding

Steve lost a week of work and $3,000 because of "branch litterbug" cleanup gone wrong.

---

## Critical Lessons

### 1. Mind the Branches

AI creates branches faster than you can track.

**Rules**:
- [ ] Review branches after every major task
- [ ] Use consistent naming conventions
- [ ] Track temp branches in plans
- [ ] Prune aggressively (after verification)
- [ ] Don't let litter pile up

**Branch Naming Convention**:
```
[agent]-[type]-[description]

Examples:
alpha-feat-user-auth
bravo-fix-login-bug
charlie-test-api-coverage
temp-experiment-caching
```

**Track Branches in Plans**:
```markdown
## Active Branches
- main (protected)
- alpha-feat-auth (Agent Alpha, in progress)
- bravo-fix-login (Agent Bravo, ready to merge)

## Temp Branches (DELETE AFTER MERGE)
- temp-spike-redis (Alpha, delete when auth merges)
```

---

### 2. Always Know Where You Are

- [ ] Branch visible in terminal prompt
- [ ] Repository clear from context
- [ ] Directory obvious from prompt

**Terminal Setup**:
```bash
# Add to .bashrc/.zshrc
parse_git_branch() {
    git branch 2>/dev/null | sed -n 's/* //p'
}
PS1='[\w] ($(parse_git_branch)) $ '
```

**Before Any Git Operation**:
```bash
# Always run first
git status
pwd
git branch --show-current
```

---

### 3. Git Control is YOUR Responsibility

Consider keeping critical operations manual:

| Operation | AI Allowed? | Why |
|-----------|-------------|-----|
| git add | ✅ Yes | Low risk |
| git commit | ⚠️ Careful | Review message |
| git push | ⚠️ Consider manual | Can't easily undo |
| git merge | ❌ Manual | High risk |
| git branch -d | ❌ Manual | Can lose code |
| git reset --hard | ❌ Never | Destructive |
| git push --force | ❌ Never | Catastrophic |

**AGENTS.md Rule**:
```markdown
## Git Rules
- You may: git add, git status, git diff, git log
- Ask before: git commit, git checkout, git branch
- Never do: git push, git merge, git reset, git branch -d
```

---

### 4. Push to Remote Often

- [ ] Push after every significant checkpoint
- [ ] Push before ending session
- [ ] Push before cleanup operations
- [ ] Consider cloud backup beyond Git

**Safe Push Ritual**:
```bash
# Before pushing
git status           # Check what's staged
git log -3           # Verify recent commits
git diff origin/main # See what's going up

# Push
git push origin [branch]

# Verify
git log origin/[branch] -1  # Confirm push succeeded
```

---

### 5. Be Careful During Cleanups

**Before Deleting Branches**:
- [ ] List all branches: `git branch -a`
- [ ] Check what's unique to branch: `git log main..[branch]`
- [ ] Verify it's merged: `git branch --merged`
- [ ] Eyeball the diff one more time
- [ ] Ask AI to confirm nothing precious
- [ ] Delete only when certain

**Cleanup Prompt**:
```
List all branches and for each one tell me:
1. Last commit date
2. Whether it's been merged to main
3. What unique commits it contains
4. Your recommendation: keep or delete

DO NOT delete anything. Just give me the analysis.
```

---

### 6. Code Reviews Are Your Safety Net

AI commits can be verbose. Don't skim.

- [ ] Read commit messages carefully
- [ ] Check for incorrect paths
- [ ] Look for mistaken assumptions
- [ ] Watch for branch confusion clues
- [ ] Verify files match expected scope

---

## Daily Git Hygiene

### Start of Day
```bash
git fetch --all
git status
git branch -v
git log --oneline -10
```

### End of Day
- [ ] All work committed
- [ ] All branches pushed
- [ ] Temp branches documented
- [ ] Status updated in tracking docs

### Weekly
- [ ] Prune merged branches
- [ ] Review orphaned branches
- [ ] Cloud backup if paranoid
- [ ] Clean up stale remotes

---

## Branch Audit Script

```bash
#!/bin/bash
# branch-audit.sh

echo "=== Local Branches ==="
git branch -v

echo ""
echo "=== Remote Branches ==="
git branch -rv

echo ""
echo "=== Merged Branches (safe to delete) ==="
git branch --merged main | grep -v "main"

echo ""
echo "=== Unmerged Branches (CAREFUL) ==="
git branch --no-merged main

echo ""
echo "=== Branches with no recent commits (30+ days) ==="
for branch in $(git branch | sed 's/*//'); do
    last_commit=$(git log -1 --format="%ci" $branch 2>/dev/null | cut -d' ' -f1)
    if [[ -n "$last_commit" ]]; then
        days_ago=$(( ($(date +%s) - $(date -d "$last_commit" +%s)) / 86400 ))
        if [[ $days_ago -gt 30 ]]; then
            echo "$branch: $days_ago days old"
        fi
    fi
done
```

---

## Recovery Scenarios

### Lost Commits (Branch Deleted Too Soon)
```bash
# Find lost commits in reflog
git reflog

# Recover specific commit
git checkout -b recovery [commit-hash]

# Or cherry-pick back
git cherry-pick [commit-hash]
```

### Wrong Branch (Committed to Wrong Place)
```bash
# Move commits to correct branch
git checkout correct-branch
git cherry-pick [commits]

# Remove from wrong branch
git checkout wrong-branch
git reset --hard HEAD~N  # N = number of commits
```

### Merge Mess (Conflicts Everywhere)
```bash
# The "Captain Jack Aubrey" approach
# Give AI high-level goal, let it figure out recovery

Prompt:
"These branches are a mess. Figure out how to rescue the work and 
get it properly merged. Don't screw it up worse. Make it recoverable."
```

### Nuclear Option (Start Fresh)
```bash
# If workspace is hopelessly corrupted
# ONLY if you've pushed everything

# 1. Backup current state
cp -r project project-backup-$(date +%Y%m%d)

# 2. Note any uncommitted work
git status > uncommitted.txt
git diff > uncommitted.patch

# 3. Fresh clone
cd ..
rm -rf project
git clone [remote-url] project

# 4. Reapply uncommitted if needed
cd project
git apply ../project-backup-*/uncommitted.patch
```

---

## Pre-Merge Checklist

- [ ] Source branch is correct
- [ ] Target branch is correct
- [ ] Source is up to date with target
- [ ] Tests pass on source
- [ ] No unexpected files changed
- [ ] Conflicts reviewed carefully
- [ ] Commit message is clear

---

## AGENTS.md Git Rules

```markdown
## Version Control Rules

### Branch Discipline
- Always work on feature branches, never main
- Branch names: [agent]-[type]-[description]
- List temp branches in tracking doc
- Ask before deleting any branch

### Commit Discipline
- Commit frequently with clear messages
- One logical change per commit
- Never commit broken code to main

### Forbidden Operations
- git push --force (NEVER)
- git reset --hard on shared branches (NEVER)
- Deleting branches without verification (NEVER)
- Merging without running tests (NEVER)

### Ask First
- Before pushing to remote
- Before merging branches
- Before deleting branches
- Before any destructive operation
```

---

## Quick Reference

| Situation | Action |
|-----------|--------|
| End of task | Commit + Push |
| End of day | Verify all pushed |
| Before cleanup | Audit all branches |
| Before delete | Triple-check merge status |
| Made a mistake | Check reflog immediately |
| Total mess | Captain Jack Aubrey approach |

---

*"There's a trade-off between speed and safety—his unsettling experience made 
Steve think, 'Maybe I'm driving the car too damned fast.'"*
