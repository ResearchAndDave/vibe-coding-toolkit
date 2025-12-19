# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

The Middle Developer Loop Toolkit implements session management and multi-agent coordination practices from Chapter 15 of "Vibe Coding" by Gene Kim and Steve Yegge. It provides templates, checklists, and prompts for managing hour-to-day transitions when working with AI coding assistants.

**Core problem solved**: AI assistants forget everything between sessions. This toolkit externalizes memory through structured documentation.

## Repository Structure

```
middle-developer-loop-toolkit/
├── templates/              # Comprehensive templates for projects
│   ├── AGENTS.md           # Golden rules (ALWAYS/NEVER do)
│   ├── SESSION_HANDOFF.md  # Session state documentation
│   ├── AGENT_STATUS.md     # Multi-agent tracking dashboard
│   ├── WORKSPACE_LAYOUT.md # AI-friendly project structure
│   └── TRACER_BULLET.md    # Minimal implementation template
├── templates-lite/         # Minimal versions for simple projects
│   ├── AGENTS_LITE.md
│   ├── SESSION_HANDOFF_LITE.md
│   └── AGENT_STATUS_LITE.md
├── checklists/             # Procedural checklists
│   ├── multi-agent-coord.md
│   ├── session-transitions.md
│   ├── context-management.md
│   └── workspace-audit.md
├── prompts/                # Copy-paste prompts for AI agents
│   ├── keep-busy.md
│   ├── workspace-optimization.md
│   └── agent-handoff.md
├── docs/                   # Guides and integration docs
│   ├── QUICK_START.md
│   ├── TROUBLESHOOTING.md
│   └── integrations/       # Tool-specific setup guides
├── examples/               # Filled-in template examples
└── scripts/
    └── init-middle-loop.sh # Initialize templates in a project
```

## Typical Workflow

**Session Start**:
1. Read AGENTS.md (golden rules)
2. Read SESSION_HANDOFF.md (last session state)
3. Verify git status
4. Brief AI on context and goals

**Session End**:
1. Reach a checkpoint (tests passing)
2. AI writes SESSION_HANDOFF.md
3. Review and supplement
4. Commit and push

**Multi-Agent**:
1. Plan work split and resource allocation
2. Create AGENT_STATUS.md dashboard
3. Round-robin attention (2-5 min per agent)
4. Update status after each switch

## How Templates Connect

```
AGENTS.md ─────────────────────────────────────────────┐
    │ (read at start of every session)                 │
    ▼                                                  │
SESSION_HANDOFF.md ◄────► Session N ────► Session N+1 │
    │ (written at end, read at start)                  │
    ▼                                                  │
AGENT_STATUS.md                                        │
    │ (tracks parallel work)                           │
    ▼                                                  │
TRACER_BULLET.md                                       │
    (precedes risky implementations)                   │
```

## Key Concepts

### Session Continuity (Memento Method)
- Document state before ending sessions using `SESSION_HANDOFF.md`
- Clear context proactively at 50% remaining
- Native resume supplements but doesn't replace manual handoffs

### Golden Rules (AGENTS.md)
- Project-specific rules injected into every AI session
- Categories: ALWAYS do, NEVER do, conventions, lessons learned
- Keep the list short—longer lists are less likely to be followed

### Multi-Agent Coordination
- Scale: 2 agents = 2x mental load, 4 agents = 10x+ organizational work
- Requirements: separation, decoupling, clear interfaces, resource isolation
- Track agents with `AGENT_STATUS.md` dashboard

### Context Management Zones
| Usage | Status | Action |
|-------|--------|--------|
| 0-50% | Safe | Work normally |
| 50-70% | Caution | Prepare to compact |
| 70-90% | Danger | Compact soon |
| 90%+ | Critical | Stop and compact |

## Success Metrics

| Metric | Target |
|--------|--------|
| Session startup time | < 5 minutes |
| Context loss between sessions | Near zero |
| Agent collision incidents | < 1 per week |
| Time to resume after break | < 10 minutes |

## Related Toolkits

This is part of a three-toolkit system:
- **Inner Loop** (seconds-minutes): Task execution, checkpointing, verification
- **Middle Loop** (hours-days): This toolkit — session continuity, multi-agent coordination
- **Outer Loop** (days-weeks): Project planning, architecture decisions

## Working with This Repository

This is a documentation toolkit—files are templates and guides meant to be copied to target projects and customized.

### Adopting in a New Project

```bash
# Quick setup
./scripts/init-middle-loop.sh /path/to/project --lite

# Full setup
./scripts/init-middle-loop.sh /path/to/project --full
```

### When Making Changes

1. Templates should remain generic with placeholder sections
2. Checklists should be actionable with checkbox syntax
3. Prompts should be copy-paste ready with clear instructions
4. All files reference Chapter 15 of "Vibe Coding" as the source
5. Update examples when templates change significantly

## File Conventions

- All documentation is Markdown
- Templates use HTML comments for instructions to users
- Placeholder text uses `[BRACKETS]` for fill-in fields
- Checklists use `- [ ]` checkbox syntax
- Code blocks in prompts should be fenced for easy copying
- Cross-reference related files to help users navigate
