# Middle Developer Loop Toolkit

A reusable implementation of AI coding session management practices from Chapter 15 of "Vibe Coding" by Gene Kim and Steve Yegge.

## The Problem

> "Unlike a human teammate who remembers yesterday's progress and discussions, your AI assistant effectively walks into a closet and forgets everything at the end of each chat session."

AI assistants have no persistent memory. **You** must carry project state forward.

## The Solution

This toolkit provides templates, checklists, and prompts for:

- **Session Continuity** — Bridge AI's memory gaps between sessions
- **Multi-Agent Coordination** — Run 2+ agents without collisions
- **Context Management** — Prevent context window saturation
- **Workspace Design** — Structure projects for AI collaboration

## Quick Start

**Minimum viable adoption** (5 minutes):

1. Copy `templates/AGENTS.md` to your project root
2. Customize the ALWAYS/NEVER rules for your stack
3. Reference it at the start of every AI session

**Full adoption**: See [QUICK_START.md](docs/QUICK_START.md)

## Which Template Do I Need?

| Situation | Template |
|-----------|----------|
| Working alone, single session | `AGENTS.md` only |
| Working alone, multi-session | Add `SESSION_HANDOFF.md` |
| Running multiple agents | Add `AGENT_STATUS.md` |
| New/risky technology | Use `TRACER_BULLET.md` first |
| Evaluating AI-readiness | Run `workspace-audit.md` |

## Repository Structure

```
middle-developer-loop-toolkit/
├── templates/              # Fill-in documents for your projects
│   ├── AGENTS.md           # Golden rules (ALWAYS/NEVER do)
│   ├── SESSION_HANDOFF.md  # Session state documentation
│   ├── AGENT_STATUS.md     # Multi-agent tracking dashboard
│   ├── WORKSPACE_LAYOUT.md # AI-friendly project structure
│   └── TRACER_BULLET.md    # Minimal implementation template
├── templates-lite/         # Minimal versions for simple projects
├── checklists/             # Procedural checklists
├── prompts/                # Copy-paste prompts for AI agents
├── docs/                   # Guides and integration docs
│   ├── QUICK_START.md      # Step-by-step adoption guide
│   └── integrations/       # Tool-specific setup
├── examples/               # Filled-in template examples
└── scripts/                # Automation helpers
```

## Key Concepts

### The Memento Method
Document session state before ending. Your future self (and AI) will thank you.

### Golden Rules
Project-specific rules injected into every session. Keep them short—longer lists are less likely to be followed.

### Multi-Agent Scaling
| Agents | Coordination Overhead |
|--------|----------------------|
| 1 | None |
| 2 | 2x mental load |
| 4 | 10x+ organizational work |

### Context Window Zones
| Usage | Status | Action |
|-------|--------|--------|
| 0-50% | Safe | Work normally |
| 50-70% | Caution | Prepare to compact |
| 70-90% | Danger | Compact soon |
| 90%+ | Critical | Stop and compact |

## Related Toolkits

This is part of a three-toolkit system matching the developer loop hierarchy:

- **Inner Loop** (seconds-minutes): Task execution, checkpointing, verification
- **Middle Loop** (hours-days): This toolkit — session continuity, multi-agent coordination
- **Outer Loop** (days-weeks): Project planning, architecture decisions

## Installation

```bash
# Clone the toolkit
git clone <repository-url>

# Initialize in your project
./scripts/init-middle-loop.sh /path/to/your-project

# Or manually copy what you need
cp templates/AGENTS.md /path/to/your-project/
```

## Success Metrics

| Metric | Target |
|--------|--------|
| Session startup time | < 5 minutes |
| Context loss between sessions | Near zero |
| Agent collision incidents | < 1 per week |
| Time to resume after break | < 10 minutes |

## Contributing

Templates should remain generic with placeholder sections. When adding content:
- Use `[BRACKETS]` for fill-in fields
- Use `- [ ]` for checklist items
- Include HTML comments for user instructions
- Reference Chapter 15 as the source

## License

MIT

## Attribution

Based on Chapter 15: The Middle Developer Loop from "Vibe Coding" by Gene Kim and Steve Yegge.
