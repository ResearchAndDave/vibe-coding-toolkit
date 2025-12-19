# Workspace Partition Plan
<!-- Prevent "stewnamis" by clearly isolating agent workspaces -->

## The Problem

> "With AI coding agents, there is risk of similarly vast destruction if you 
> aren't paying attention. One way this can happen is via a worrisome new class 
> of problems: workspace confusion at scale."
> — Chapter 16, Vibe Coding

Without clear partitions, agents can:
- Work in wrong directories
- Commit to wrong branches
- Mix up repositories
- Overwrite each other's work
- Create "stewnamis" of merged messes

---

## Partition Strategy

### Level 1: Repository Isolation

| Agent | Repository | Clone Path | Purpose |
|-------|------------|------------|---------|
| | | `/home/dev/work/[name]` | |
| | | `/home/dev/work/[name]` | |

**Rule**: One agent per repository clone when possible.

**Warning**: Avoid nesting repositories (repo inside repo) — this confuses AI.

---

### Level 2: Branch Isolation

| Agent | Branch Pattern | Example | Base Branch |
|-------|---------------|---------|-------------|
| | `[agent]-*` | `alpha-feat-auth` | main |
| | `[agent]-*` | `bravo-fix-login` | main |

**Rule**: Each agent works only on branches with their prefix.

**Cleanup**: Branches must be listed for deletion when work merges.

---

### Level 3: Directory Isolation

| Agent | Primary Directory | Can Read | Cannot Touch |
|-------|-------------------|----------|--------------|
| | `src/[module]/` | `src/shared/` | `src/[other]/` |
| | `src/[module]/` | `src/shared/` | `src/[other]/` |

**Rule**: Agents modify only their assigned directories.

**Enforcement**: Honor system OR sandboxing (Docker).

---

### Level 4: File Isolation

For fine-grained control within shared directories:

| File Pattern | Owner | Others |
|--------------|-------|--------|
| `*.controller.ts` | Agent A | Read-only |
| `*.service.ts` | Agent B | Read-only |
| `*.test.ts` | Agent C | Read-only |

---

### Level 5: Resource Isolation

#### Ports
| Agent | Port Range | Current Use |
|-------|------------|-------------|
| | 3000-3099 | |
| | 3100-3199 | |

#### Databases
| Agent | Database | Schema/Namespace |
|-------|----------|------------------|
| | | |

#### External Services
| Agent | API Keys | Rate Limit Share |
|-------|----------|-----------------|
| | | |

---

## Visual Labeling

### Terminal Colors
```
Agent Alpha  → Red background/border
Agent Bravo  → Green background/border  
Agent Charlie → Blue background/border
Agent Delta  → Yellow background/border
```

### Window Arrangement
```
┌─────────────────────────────────────────┐
│            Monitor Layout               │
├───────────────────┬─────────────────────┤
│  Agent Alpha      │   Agent Bravo       │
│  🔴 RED           │   🟢 GREEN          │
│  Branch: alpha-*  │   Branch: bravo-*   │
│  Dir: /work/alpha │   Dir: /work/bravo  │
├───────────────────┼─────────────────────┤
│  Agent Charlie    │   Agent Delta       │
│  🔵 BLUE          │   🟡 YELLOW         │
│  Branch: charlie-*│   Branch: delta-*   │
│  Dir: /work/charlie│  Dir: /work/delta  │
└───────────────────┴─────────────────────┘
```

### Prompt Customization
```bash
# Add to each terminal's profile
# Alpha
PS1='🔴 ALPHA [\\w] $ '

# Bravo  
PS1='🟢 BRAVO [\\w] $ '

# Charlie
PS1='🔵 CHARLIE [\\w] $ '

# Delta
PS1='🟡 DELTA [\\w] $ '
```

---

## Sandboxing Options

### Option 1: Honor System
Tell each agent its boundaries in the prompt:
```
You are Agent Alpha. You may ONLY:
- Work on branches starting with 'alpha-'
- Modify files in src/auth/
- Use ports 3000-3099

You may NOT:
- Touch any other branches
- Modify files outside src/auth/
- Use ports outside your range
```

### Option 2: Docker Containers
```yaml
# docker-compose.yml
services:
  agent-alpha:
    volumes:
      - ./src/auth:/work/src/auth
      - ./src/shared:/work/src/shared:ro
    ports:
      - "3000-3099:3000-3099"
    
  agent-bravo:
    volumes:
      - ./src/api:/work/src/api
      - ./src/shared:/work/src/shared:ro
    ports:
      - "3100-3199:3100-3199"
```

### Option 3: Git Worktrees
```bash
# Create isolated worktrees per agent
git worktree add ../work-alpha alpha-main
git worktree add ../work-bravo bravo-main
git worktree add ../work-charlie charlie-main
git worktree add ../work-delta delta-main
```

---

## Conflict Prevention Matrix

| Resource Type | Isolation Method | Enforcement |
|---------------|------------------|-------------|
| Branches | Naming convention | Manual check |
| Directories | Assignment | Honor system |
| Files | Ownership list | Review |
| Ports | Range allocation | Docker |
| Database | Schemas | Permissions |
| APIs | Endpoint ownership | Documentation |

---

## Simplification Opportunities

Sometimes the best solution is reducing complexity:

### Problematic Patterns
- ❌ Nested repositories
- ❌ Monorepo with unclear boundaries
- ❌ Shared mutable state
- ❌ Complex Gradle/Maven module mappings
- ❌ Symlinks between workspaces

### Simpler Alternatives
- ✅ Separate repositories per service
- ✅ Clear module boundaries
- ✅ Immutable shared dependencies
- ✅ Standard build configurations
- ✅ Independent clones per agent

---

## Verification Checklist

Before starting multi-agent work:

- [ ] Each agent has dedicated branch prefix
- [ ] Directory ownership is documented
- [ ] Port ranges are assigned
- [ ] Terminal colors are set
- [ ] Sandboxing is configured (if used)
- [ ] Agents have been briefed on boundaries
- [ ] FLEET_STATUS.md is current

---

## Recovery When Partitions Fail

### Detected: Agent in Wrong Branch
```bash
1. Stop the agent
2. Stash or commit changes
3. Move changes to correct branch
4. Restart agent in correct context
```

### Detected: Cross-Contamination
```bash
1. Stop all affected agents
2. Identify contaminated changes
3. Revert or cherry-pick carefully
4. Verify partition integrity
5. Restart with explicit boundaries
```

### Detected: Merge Mess
```bash
1. Don't panic
2. See disaster-recovery.md
3. Consider "Captain Jack Aubrey" approach
4. Let AI devise recovery strategy
```

---

## Partition Audit Template

Weekly check:

| Check | Status | Notes |
|-------|--------|-------|
| All agents on correct branches? | ✅/❌ | |
| No unauthorized file changes? | ✅/❌ | |
| Port ranges respected? | ✅/❌ | |
| No nested repo issues? | ✅/❌ | |
| Branch cleanup current? | ✅/❌ | |

---

*Document created: [date]*
*Last partition review: [date]*
