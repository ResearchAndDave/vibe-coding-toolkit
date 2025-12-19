# Middle Developer Loop Toolkit
## A Reusable Implementation of "Vibe Coding" Chapter 15

---

## Executive Summary

This toolkit implements the Middle Developer Loop practices from Chapter 15 of the Vibe Coding book. The Middle Loop focuses on hour-to-day transitions—managing handoffs between work sessions, coordinating multiple agents, and maintaining context across time.

Unlike the Inner Loop (seconds to minutes), the Middle Loop deals with:
- **Session continuity** — Bridging AI's memory gaps between sessions
- **Multi-agent orchestration** — Running 2+ agents without collisions
- **Workspace organization** — Designing systems that work with AI, not against it
- **Persistent rules** — Golden rules that survive every session

---

## Key Insight from Chapter 15

> "Unlike a human teammate who remembers yesterday's progress and discussions, 
> your AI assistant effectively walks into a closet and forgets everything at 
> the end of each chat session."

The Middle Loop is about **you** carrying project state forward, since AI cannot.

---

## Implementation Architecture

```
middle-developer-loop-toolkit/
├── IMPLEMENTATION_PLAN.md           # This document
├── templates/
│   ├── AGENTS.md                    # Golden rules template
│   ├── SESSION_HANDOFF.md           # Memento Method template
│   ├── AGENT_STATUS.md              # Multi-agent tracking dashboard
│   ├── WORKSPACE_LAYOUT.md          # AI-friendly project structure
│   └── TRACER_BULLET.md             # Minimal implementation template
├── checklists/
│   ├── multi-agent-coord.md         # Running multiple agents safely
│   ├── session-transitions.md       # Before/after session checklist
│   ├── workspace-audit.md           # Is your project AI-friendly?
│   └── context-management.md        # Managing context window limits
└── prompts/
    ├── keep-busy.md                 # Productive tasks for idle agents
    ├── workspace-optimization.md    # Prompts for AI-friendly refactoring
    └── agent-handoff.md             # Prompts for session transitions
```

---

## Component Breakdown

### 1. Session Continuity (The Memento Method)

**Problem**: AI forgets everything between sessions.

**Solution**: Externalize memory through documentation.

**Implementation**:
- `templates/SESSION_HANDOFF.md` — Document state before ending sessions
- `checklists/session-transitions.md` — Before/after session rituals
- `checklists/context-management.md` — Managing context window saturation

**Key Practices**:
- Clear context proactively at 20-50% remaining
- Have AI write state to Markdown before compaction
- Always specify what to carry forward
- Review and supplement AI's notes

---

### 2. Golden Rules (AGENTS.md)

**Problem**: AI doesn't know your project's unique rules.

**Solution**: Documented rules injected into every session.

**Implementation**:
- `templates/AGENTS.md` — Comprehensive rules template

**Categories**:
- **Always do** — Mandatory practices
- **Never do** — Forbidden patterns  
- **Project conventions** — Style, structure, naming
- **Tech stack rules** — Framework-specific guidance
- **Lessons learned** — Accumulated wisdom from past sessions

**Key Insight**:
> "The longer your list of rules, the less likely AI will follow them all. 
> Choose carefully."

---

### 3. Multi-Agent Coordination

**Problem**: Multiple agents can collide on shared resources.

**Solution**: Intentional coordination and resource partitioning.

**Implementation**:
- `templates/AGENT_STATUS.md` — Central command post for tracking agents
- `checklists/multi-agent-coord.md` — Coordination patterns and anti-patterns

**Scaling Complexity** (from Chapter 15):
| Agents | Coordination Overhead |
|--------|----------------------|
| 1 | None |
| 2 | 2x mental load |
| 4 | 10x+ organizational work |
| 4+ | Requires dedicated infrastructure |

**Key Requirements**:
- **Separation** — Different parts of codebase
- **Decoupling** — No tight interface dependencies
- **Clear interfaces** — Well-defined boundaries
- **Resource isolation** — Ports, databases, files

**Contention Sources**:
- Merge conflicts (same files)
- Port conflicts (same services)
- Database/file contention
- Branch confusion
- MCP server conflicts

---

### 4. Tracer Bullets

**Problem**: Multi-agent work can fail when interfaces aren't stable.

**Solution**: Minimal end-to-end implementations to prove paths work.

**Implementation**:
- `templates/TRACER_BULLET.md` — Tracer bullet template

**Use When**:
- Establishing interfaces between agents/components
- Before large time investments
- When AI seems to struggle with technology
- Starting work with unfamiliar tech
- Multiple agents need to integrate

**Pattern**:
```
1. Define smallest possible end-to-end slice
2. Have AI implement just that slice
3. Success? → Expand incrementally
4. Failure? → Take manual control or pivot
```

**Key Insight** (from Chapter 15):
> "The tracer bullet proved to us that AI wasn't trained well enough to handle 
> obscure Gradle problems. When you see AI struggle with a focused task, it's 
> a clear signal that you'll get 'no mechanical advantage' using it for that 
> particular domain."

---

### 5. Agent Productivity

**Problem**: Agents sit idle while you're occupied.

**Solution**: Keep-busy directives that add value.

**Implementation**:
- `prompts/keep-busy.md` — Productive tasks for idle agents

**Productive Tasks** (from Chapter 15):
1. Run all tests again and report failures
2. Improve test cases
3. Review for missing edge cases
4. Iterate on first draft
5. Summarize suspicious code
6. Clean up temporary files
7. Write Markdown summaries
8. Update documentation
9. Try to break the solution
10. Prepare code review package

**Key Insight**:
> "This self-critiquing pattern allows Steve to reclaim 15–20% more productive 
> time and spares him the tedium of reviewing half-baked outputs."

---

### 6. Design for AI Manufacturing

**Problem**: Some codebases fight against AI assistance.

**Solution**: Restructure to work "with the grain" of AI.

**Implementation**:
- `templates/WORKSPACE_LAYOUT.md` — AI-friendly project structure
- `checklists/workspace-audit.md` — Evaluate AI-friendliness
- `prompts/workspace-optimization.md` — Refactoring prompts

**Principles**:
- Choose languages with robust training data
- Use conventional project structures
- Prefer popular frameworks over exotic ones
- Split large files that exceed context limits
- Consistent naming and organization
- Minimize "magic" and implicit behavior

**Warning Signs**:
- Files too large for agent to read at once
- Unconventional project layouts
- Obscure languages/frameworks
- Tightly coupled modules
- Inconsistent patterns

---

## Workflow Patterns

### Starting a Multi-Agent Session

```
1. Review AGENT_STATUS.md from last session
2. Plan today's work split
3. Verify resource allocation (ports, branches, files)
4. Start agents with clear, bounded tasks
5. Update status document as work begins
```

### During Multi-Agent Work

```
Round-robin attention:
- Check Agent A (2-5 min)
- Check Agent B (2-5 min)
- Update AGENT_STATUS.md
- Repeat

Watch for:
- Agents waiting on you
- Contention signs
- Context saturation
- Agents going off track
```

### Ending a Session (Memento Method)

```
1. Have each agent reach a checkpoint
2. Run tests to verify state
3. Have AI write SESSION_HANDOFF.md
4. Review and supplement AI's notes
5. Commit all work
6. Update AGENT_STATUS.md
7. Push to remote (backup!)
```

---

## Implementation Priority

### Phase 1: Foundation (Week 1)
- [ ] Create AGENTS.md for your project
- [ ] Establish session handoff ritual
- [ ] Set up basic multi-agent workflow (2 agents)

### Phase 2: Scaling (Week 2)
- [ ] Create AGENT_STATUS.md tracking system
- [ ] Develop keep-busy directive library
- [ ] Audit workspace for AI-friendliness

### Phase 3: Optimization (Week 3)
- [ ] Refactor workspace for AI manufacturing
- [ ] Build context management discipline
- [ ] Scale to 3-4 agents if needed

### Phase 4: Refinement (Week 4)
- [ ] Accumulate lessons learned in AGENTS.md
- [ ] Optimize session transitions
- [ ] Document team-specific patterns

---

## Success Metrics

| Metric | Target |
|--------|--------|
| Session startup time | < 5 minutes |
| Context loss between sessions | Near zero |
| Agent collision incidents | < 1 per week |
| Idle agent time | < 10% |
| Time to resume after break | < 10 minutes |

---

## Relationship to Inner Loop

The Middle Loop builds on Inner Loop practices:

| Inner Loop (Ch.14) | Middle Loop (Ch.15) |
|-------------------|---------------------|
| Task decomposition | Multi-session task tracking |
| Checkpointing | Session handoffs |
| Verification | Cross-session verification |
| Single-agent focus | Multi-agent coordination |
| Immediate corrections | Accumulated golden rules |

**Use Together**: Inner Loop for moment-to-moment work, Middle Loop for continuity across time.

---

## Quick Reference

### Before Each Session
- [ ] Read AGENTS.md
- [ ] Review SESSION_HANDOFF.md from last time
- [ ] Check AGENT_STATUS.md
- [ ] Verify git status and branches
- [ ] Plan session goals

### After Each Session
- [ ] All agents at checkpoints
- [ ] Tests passing
- [ ] SESSION_HANDOFF.md updated
- [ ] AGENT_STATUS.md current
- [ ] Changes committed and pushed
- [ ] Branches cleaned up

---

*Based on Chapter 15: The Middle Developer Loop from "Vibe Coding" by Gene Kim and Steve Yegge*
