# Workspace Isolation Checklist
<!-- Avoiding the Stewnami -->

## The Risk

> "If one developer with two projects and two agents can create this level of 
> code corruption, imagine what happens when fifty developers with five agents 
> each start cooking in your company's code base kitchen."
> — Chapter 16, Vibe Coding

---

## Three Essential Strategies

### 1. Partition Clearly

**Directories**
- [ ] Each agent has assigned working directory
- [ ] Directories are documented in FLEET_STATUS.md
- [ ] No overlapping directory assignments
- [ ] Shared directories are read-only or carefully coordinated

**Repositories**
- [ ] Avoid nesting repos (repo inside repo)
- [ ] Each agent ideally has own clone
- [ ] If sharing repo, use worktrees
- [ ] Clear separation between project boundaries

**Branches**
- [ ] Naming convention established (e.g., `[agent]-[task]-[desc]`)
- [ ] Each agent works only on their branches
- [ ] Branch ownership is documented
- [ ] Temp branches tracked for cleanup

**Databases**
- [ ] Separate schemas/namespaces per agent
- [ ] Or separate database instances
- [ ] No concurrent writes to same tables

**Ports**
- [ ] Port ranges assigned per agent
- [ ] No overlapping ranges
- [ ] Documented in workspace plan

---

### 2. Label Explicitly

**Terminal Windows**
- [ ] Different colors per agent
- [ ] Agent name visible in prompt
- [ ] Window titles identify workspace

**Prompts**
- [ ] Custom PS1 with agent identifier
- [ ] Directory shown in prompt
- [ ] Branch shown in prompt (if using git)

**Visual Arrangement**
- [ ] Consistent window layout
- [ ] Agent windows in predictable positions
- [ ] Color coding matches documentation

**Example Setup**:
```bash
# Terminal profile for Agent Alpha
export PS1='🔴 ALPHA [\w] ($(git branch --show-current 2>/dev/null)) $ '
# Set terminal background to light red
```

---

### 3. Simplify When Possible

**Remove Complexity That Confuses AI**:
- [ ] No nested repositories
- [ ] No complex module remappings
- [ ] No symlinks between workspaces
- [ ] Standard project layouts
- [ ] Merged separate repos if they keep getting confused

**Steve's Example**: 
- Abandoned separate repos for server/client
- Merged to reduce AI confusion
- Removed Gradle module name remappings

---

## Pre-Flight Checklist

Before starting multi-agent session:

### Environment
- [ ] All agent workspaces set up
- [ ] Terminal colors configured
- [ ] No leftover state from previous sessions

### Documentation
- [ ] FLEET_STATUS.md is current
- [ ] WORKSPACE_PARTITION.md exists
- [ ] Agent assignments documented

### Boundaries
- [ ] Each agent knows their:
  - [ ] Branch prefix
  - [ ] Directory scope
  - [ ] Port range
  - [ ] File ownership

### Verification
- [ ] All agents start in correct directory
- [ ] All agents on correct branch
- [ ] No uncommitted changes in workspaces

---

## During-Work Checklist

### Every 30 Minutes
- [ ] Verify each agent is in correct workspace
- [ ] Check branch names match agent
- [ ] No workspace drift detected

### Before Major Operations
- [ ] Confirm agent identity
- [ ] Verify branch
- [ ] Check directory

### Before Commits
- [ ] Correct branch?
- [ ] Correct directory?
- [ ] Files match agent's scope?

### Before Merges
- [ ] Source branch correct?
- [ ] Target branch correct?
- [ ] Conflict check done?

---

## Warning Signs

### Something Is Wrong If:

**Directory Issues**:
- Agent mentions files outside their scope
- Unexpected file modifications appear
- "File not found" for expected files

**Branch Issues**:
- Commits appear on wrong branch
- Branch name doesn't match agent prefix
- Merge conflicts from unexpected sources

**Repository Issues**:
- Wrong project files visible
- Unexpected directory structure
- Clone appears inside another clone

---

## Recovery Actions

### Agent in Wrong Directory
```bash
1. Stop agent immediately
2. Check git status
3. Stash any changes: git stash
4. Navigate to correct directory
5. Apply changes if needed: git stash pop
6. Restart agent with explicit path
```

### Agent on Wrong Branch
```bash
1. Stop agent
2. Commit or stash changes
3. Check out correct branch
4. Cherry-pick or apply changes
5. Restart agent
```

### Cross-Contamination Detected
```bash
1. Stop all affected agents
2. Don't panic
3. Map out what went wrong
4. Isolate contaminated changes
5. Consider rollback to known good state
6. Restart with reinforced boundaries
```

### Full Workspace Disaster
```bash
1. Stop everything
2. Push any recoverable work
3. Delete contaminated clones
4. Fresh clone from remote
5. Rebuild workspaces from scratch
6. Strengthen partitioning
```

---

## Weekly Audit

- [ ] Branch naming convention followed?
- [ ] No unauthorized cross-workspace commits?
- [ ] Cleanup of completed temp branches?
- [ ] Port assignments still appropriate?
- [ ] Any simplification opportunities?

---

## Sandboxing Enforcement Levels

### Level 1: Honor System
- Tell agents their boundaries
- Trust they follow rules
- Audit occasionally

### Level 2: Separate Clones
- Each agent has own repo clone
- Physical separation
- Still relies on branch discipline

### Level 3: Git Worktrees
- Isolated working directories
- Shared git history
- Better isolation than single clone

### Level 4: Docker Containers
- Complete isolation
- Mounted volumes for scope
- Network isolation for ports
- Strongest guarantee

### Level 5: Separate Machines/VMs
- Ultimate isolation
- Higher overhead
- For highest-risk scenarios

---

## Quick Reference

| Situation | Check |
|-----------|-------|
| Starting work | Am I in the right directory? |
| Creating branch | Does name start with my prefix? |
| Modifying files | Are these files in my scope? |
| Running service | Am I using my port range? |
| Before commit | Is everything in my workspace? |
| Before merge | Am I merging to correct target? |

---

*"The more ambitious your AI-assisted projects become, the more you need 
clear boundaries between workspaces."*
