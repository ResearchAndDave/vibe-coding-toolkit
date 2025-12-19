# Multi-Agent Coordination Patterns
<!-- Running multiple AI agents without collisions -->

## Overview

Running multiple AI coding agents can multiply your productivity—if you avoid collisions. This guide helps you set up, coordinate, and troubleshoot multi-agent workflows.

> "If you only have one cutting board and knife, they will always be competing for them."
> — Chapter 15, Vibe Coding

---

## Prerequisites for Multi-Agent Work

### Independence Requirements
Before running multiple agents, ensure:

- [ ] **Separation**: Agents work on different parts of codebase
- [ ] **Decoupling**: Components aren't tightly linked
- [ ] **Clear Interfaces**: Well-defined boundaries between components
- [ ] **Resource Isolation**: No shared ports, databases, files

### Infrastructure Checklist
- [ ] Separate terminal/session for each agent
- [ ] Separate Git branches (optional but recommended)
- [ ] Separate working directories (if possible)
- [ ] Different port ranges for services
- [ ] Separate database instances (for integration tests)

---

## Coordination Patterns

### Pattern 1: Parallel Isolation
Each agent works on completely separate components.

```
Agent A ──→ Module X (frontend)
Agent B ──→ Module Y (backend API)
Agent C ──→ Module Z (database layer)

No overlap, no coordination needed.
```

**Best for**: Independent features, separate services
**Risk level**: Low
**Coordination**: Minimal

### Pattern 2: Sequential Handoff
Agents work on same area, one at a time.

```
Agent A ──→ Design API contract ──→ Commit
                                    ↓
Agent B ◀────────────────────── Pull latest
        ──→ Implement server ──→ Commit
                                    ↓
Agent C ◀────────────────────── Pull latest
        ──→ Implement client ──→ Commit
```

**Best for**: Layered work on same component
**Risk level**: Low
**Coordination**: Pull before starting

### Pattern 3: Branch-Based Parallel
Agents work on branches that merge later.

```
main ─────┬─────────────────────┬─────→
          │                     │
Agent A   └─→ feature-a ───────→┤
                                │ Merge
Agent B   └─→ feature-b ───────→┤
```

**Best for**: Features with potential overlap
**Risk level**: Medium (merge conflicts)
**Coordination**: Careful merge planning

### Pattern 4: Interface Contract
Define interface first, then parallel implementation.

```
Step 1: Define interface (together)
        └─→ interface User { ... }

Step 2: Implement in parallel
        Agent A ──→ UserService (implements interface)
        Agent B ──→ UserClient (uses interface)
```

**Best for**: Client/server development
**Risk level**: Low if interface stable
**Coordination**: Interface must be agreed and frozen

---

## Contention Prevention

### Resource Allocation Table

| Resource | Agent A | Agent B | Agent C |
|----------|---------|---------|---------|
| Ports | 3000-3099 | 3100-3199 | 3200-3299 |
| Branch | feature-a | feature-b | feature-c |
| DB Schema | users_* | products_* | orders_* |
| Files | src/auth/* | src/cart/* | src/checkout/* |

### Before Starting Each Agent

```bash
# Check for conflicts
git fetch
git status
lsof -i :3000-3299  # Check ports in use

# Start fresh
git checkout main
git pull
git checkout -b agent-a-feature
```

---

## Contention Detection

### Signs of Agent Collision

| Symptom | Likely Cause |
|---------|--------------|
| Merge conflicts | Both modified same files |
| Port already in use | Both running services |
| Flaky tests | Shared test database |
| "File not found" | Branch confusion |
| Strange behavior | Conflicting config |

### Monitoring Commands

```bash
# See who's touching what files
git diff --stat

# Check running services
lsof -i -P | grep LISTEN

# See active branches
git branch -v

# Check for uncommitted work
git status
```

### When Collision Detected

1. **Stop both agents**
2. **Assess the damage**
   ```bash
   git diff
   git status
   ```
3. **Decide who continues**
   - More progress → Continue
   - Less entangled → Continue
4. **Roll back or merge**
   ```bash
   # Roll back one agent
   git stash
   
   # Or merge carefully
   git merge --no-commit other-branch
   ```

---

## Multi-Agent Workflow

### Starting a Session

```
1. Plan the split
   - What does Agent A do?
   - What does Agent B do?
   - Where might they overlap?

2. Set up isolation
   - Create branches
   - Assign resources
   - Define interfaces

3. Start agents
   - Give clear, bounded tasks
   - Emphasize boundaries

4. Monitor
   - Check periodically
   - Watch for collisions
```

### During the Session

```
Round-robin attention:
- Check Agent A (2-3 min)
- Check Agent B (2-3 min)
- Repeat

When switching agents:
- Let current agent reach checkpoint
- Don't leave mid-thought
- Commit before switching if possible
```

### Ending a Session

```
For each agent:
1. Reach a checkpoint
2. Run tests
3. Commit changes
4. Push branch (if ready)
5. Write session notes

Then:
6. Review for conflicts
7. Merge if appropriate
8. Update coordination table
```

---

## Agent Communication

### Shared Knowledge Files

Create files that multiple agents can read:

```
/docs/INTERFACES.md     - API contracts
/docs/DECISIONS.md      - Architectural decisions
/docs/AGENT_NOTES.md    - Cross-agent communication
```

### Agent-Specific Notes

Each agent maintains:

```
/docs/agent-a-notes.md
/docs/agent-b-notes.md
```

### Interface Definition Example

```typescript
// /src/interfaces/user.ts
// DO NOT MODIFY - Shared interface between agents

export interface User {
  id: string;
  email: string;
  name: string;
  createdAt: Date;
}

export interface UserService {
  getUser(id: string): Promise<User>;
  createUser(email: string, name: string): Promise<User>;
}
```

---

## Tracer Bullets for Multi-Agent

Before full parallel work, create minimal connections:

```
1. Define interface
2. Agent A: Stub implementation
3. Agent B: Client that uses stub
4. Verify they connect
5. Then: Parallel full implementation
```

---

## Exercise: Become a Multi-Agent Maestro

From Chapter 15:

1. **Set up two agents** in separate sessions
2. **Choose two problems** of similar complexity
3. **Alternate between agents**, keeping both productive
4. **Reflect** on what you learned

### Goals
- Neither agent waiting on you
- Both making progress
- No collisions
- Both complete successfully

---

## Troubleshooting

### "Agents keep conflicting"
→ Increase separation
→ Use branches
→ Clearer boundaries

### "Context switches are exhausting"
→ Fewer agents
→ Longer attention per agent
→ More different problems (less mental overlap)

### "Merge conflicts everywhere"
→ More modular code
→ Better interface definition
→ Sequential instead of parallel

### "Agents getting confused"
→ Separate AGENTS.md per branch
→ Clearer task definitions
→ More checkpoints

---

## Scaling Up

### 2 Agents
- Manual attention switching
- Direct coordination
- Same or adjacent terminals

### 3-5 Agents
- Need coordination system
- Dashboard or checklist
- More structured handoffs
- Consider supervisor agent

### 5+ Agents
- Orchestration tool needed
- Clear hierarchy
- Automated merge process
- Dedicated coordination time

---

## Quick Reference

### Before Multi-Agent Work
- [ ] Tasks are independent
- [ ] Resources are allocated
- [ ] Branches are created
- [ ] Interfaces are defined

### During Multi-Agent Work
- [ ] Round-robin attention
- [ ] Monitor for collisions
- [ ] Checkpoint frequently
- [ ] Don't leave agents stuck

### After Multi-Agent Work
- [ ] All agents at checkpoints
- [ ] Branches merged or saved
- [ ] Conflicts resolved
- [ ] Notes updated

---

> "Running multiple agents at a time is a hint of things to come. As the head 
> of a soon-to-be huge kitchen, you'll orchestrate a large and eventually 
> hierarchical team of cooks."
> — Chapter 15, Vibe Coding
