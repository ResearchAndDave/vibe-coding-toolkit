# Fleet Command Dashboard
<!-- Central command post for managing 4+ AI coding agents -->

## Overview

> "Going from two agents to four wasn't twice as complicated. It required 
> over 10x as much organizational work."
> — Chapter 16, Vibe Coding

This dashboard is your "kitchen clipboard" for orchestrating multiple agents at scale.

---

## Fleet Status

| Agent | Role | Status | Branch | Current Task | Last Check |
|-------|------|--------|--------|--------------|------------|
| Alpha | | 🟢 | | | |
| Bravo | | 🟢 | | | |
| Charlie | | 🟢 | | | |
| Delta | | 🟢 | | | |
| Echo | | ⚪ | | | |
| Foxtrot | | ⚪ | | | |

**Legend**: 
🟢 Active | 🟡 Waiting | 🔴 Blocked | ⚪ Idle | ✅ Complete | ❌ Failed

---

## Agent Roles (Long-Running)

Define dedicated roles for each agent to reduce confusion:

| Agent | Dedicated Role | Workspace | Primary Files |
|-------|---------------|-----------|---------------|
| Alpha | | | |
| Bravo | | | |
| Charlie | | | |
| Delta | | | |

**Example Roles**:
- "Bugs Agent" — Handles bug fixes and issue triage
- "TypeScript Client Agent" — Works on frontend
- "API Agent" — Backend API development
- "Test Agent" — Test writing and coverage
- "Docs Agent" — Documentation and comments
- "Refactor Agent" — Code cleanup and optimization

---

## Workspace Partitions

### Directory Assignments
| Agent | Working Directory | Can Access | Cannot Access |
|-------|-------------------|------------|---------------|
| Alpha | | | |
| Bravo | | | |
| Charlie | | | |
| Delta | | | |

### Repository Assignments
| Agent | Repository | Clone Location |
|-------|------------|----------------|
| Alpha | | |
| Bravo | | |
| Charlie | | |
| Delta | | |

### Branch Naming Convention
```
[agent]-[task]-[description]

Examples:
alpha-feat-user-auth
bravo-fix-login-bug
charlie-refactor-api
delta-test-coverage
```

### Port Allocations
| Agent | Port Range | Services |
|-------|------------|----------|
| Alpha | 3000-3099 | |
| Bravo | 3100-3199 | |
| Charlie | 3200-3299 | |
| Delta | 3300-3399 | |

---

## Work Queues

### Agent Alpha: [Role]
**Current**: 
**Queue**:
1. [ ] 
2. [ ] 
3. [ ] 

**Blocked On**: 

---

### Agent Bravo: [Role]
**Current**: 
**Queue**:
1. [ ] 
2. [ ] 
3. [ ] 

**Blocked On**: 

---

### Agent Charlie: [Role]
**Current**: 
**Queue**:
1. [ ] 
2. [ ] 
3. [ ] 

**Blocked On**: 

---

### Agent Delta: [Role]
**Current**: 
**Queue**:
1. [ ] 
2. [ ] 
3. [ ] 

**Blocked On**: 

---

## Coordination Log

| Time | Agent | Action | Dependencies | Notes |
|------|-------|--------|--------------|-------|
| | | | | |
| | | | | |
| | | | | |

---

## Merge Schedule

### Ready to Merge
| Agent | Branch | Into | Conflicts? | Tests Pass? |
|-------|--------|------|------------|-------------|
| | | main | | |

### Merge Order (Dependency-Aware)
```
1. [Branch] — no dependencies
2. [Branch] — depends on #1
3. [Branch] — depends on #1, #2
```

### Potential Conflicts
| Files | Agents | Resolution Plan |
|-------|--------|-----------------|
| | | |

---

## Terminal/Window Organization

### Window Layout
```
┌─────────────────┬─────────────────┐
│  Alpha (RED)    │  Bravo (GREEN)  │
│  [role]         │  [role]         │
├─────────────────┼─────────────────┤
│  Charlie (BLUE) │  Delta (YELLOW) │
│  [role]         │  [role]         │
└─────────────────┴─────────────────┘
```

### Color Coding
| Agent | Terminal Color | Visual Marker |
|-------|---------------|---------------|
| Alpha | Red | 🔴 |
| Bravo | Green | 🟢 |
| Charlie | Blue | 🔵 |
| Delta | Yellow | 🟡 |

---

## Communication Channels

### Shared Context
- Project plan: [location]
- Architecture docs: [location]
- API contracts: [location]

### Handoff Protocol
When work passes between agents:
1. Source agent writes handoff note
2. Update this dashboard
3. Target agent acknowledges
4. Source agent confirms handoff complete

---

## Resource Contention Monitor

### Currently Locked Resources
| Resource | Held By | Since | Expected Release |
|----------|---------|-------|------------------|
| | | | |

### Contention History (Last Week)
| Date | Resource | Agents | Resolution |
|------|----------|--------|------------|
| | | | |

---

## Health Checks

### Last Full Check: [timestamp]

| Agent | Responding | Tests Pass | Branch Clean | Context OK |
|-------|------------|------------|--------------|------------|
| Alpha | ✅ | ✅ | ✅ | ✅ |
| Bravo | ✅ | ✅ | ✅ | ✅ |
| Charlie | ✅ | ✅ | ✅ | ✅ |
| Delta | ✅ | ✅ | ✅ | ✅ |

### Issues Detected
- [ ] 

---

## Daily Standup Template

```markdown
## Fleet Standup [Date]

### Alpha
- Yesterday: 
- Today: 
- Blockers: 

### Bravo
- Yesterday: 
- Today: 
- Blockers: 

### Charlie
- Yesterday: 
- Today: 
- Blockers: 

### Delta
- Yesterday: 
- Today: 
- Blockers: 

### Coordination Needs
- 

### Merges Planned
- 
```

---

## Scaling Notes

### From 2 → 4 Agents
- Need central coordination document (this)
- Need explicit workspace partitions
- Need merge planning process
- Need role specialization

### From 4 → 6+ Agents
- Consider hierarchical coordination
- May need dedicated "coordinator" agent
- Automated conflict detection
- More rigorous partition enforcement

---

## Quick Commands

```bash
# Check all branches across agents
git branch -a | grep -E "alpha|bravo|charlie|delta"

# Find which agent touched a file
git log --all --oneline -- [file] | head -10

# Check for uncommitted work across clones
for d in */; do echo "=== $d ==="; (cd "$d" && git status -s); done

# Find port usage
lsof -i -P | grep LISTEN | grep -E "30[0-3][0-9]{2}"
```

---

*Last Updated: [timestamp]*
*Fleet Manager: [name]*
