# Vibe Coding Toolkit

A comprehensive toolkit for AI-assisted software development, implementing practices from "Vibe Coding" by Gene Kim and Steve Yegge.

## The Problem

AI coding assistants are powerful but have fundamental limitations:
- They forget everything between sessions
- They can claim "tests pass" without running them
- They generate bugs as fast as features
- Multiple agents can collide and corrupt each other's work
- They need guidance to navigate your codebase

## The Solution

Three toolkits organized by development timescale:

| Toolkit | Timescale | Focus |
|---------|-----------|-------|
| [Inner Loop](inner-developer-loop-toolkit/) | Seconds–minutes | Task execution, TDD, checkpointing, verification |
| [Middle Loop](middle-developer-loop-toolkit/) | Hours–days | Session continuity, multi-agent coordination |
| [Outer Loop](outer-developer-loop-toolkit/) | Days–weeks | Architecture decisions, API preservation, fleet management |

```
┌─────────────────────────────────────────────────────────────────┐
│                     OUTER LOOP (days-weeks)                     │
│          Architecture, API contracts, fleet management          │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │                 MIDDLE LOOP (hours-days)                  │  │
│  │        Session continuity, multi-agent coordination       │  │
│  │  ┌─────────────────────────────────────────────────────┐  │  │
│  │  │              INNER LOOP (seconds-minutes)           │  │  │
│  │  │        Task → Code → Test → Verify → Commit         │  │  │
│  │  └─────────────────────────────────────────────────────┘  │  │
│  └───────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

## The Goal: FAAFO

In Vibe Coding, **FAAFO** stands for **Fast, Autonomous, Fun to Operate** — the ideal state of AI-assisted development:

- **Fast** — Quick iteration, rapid feedback loops
- **Autonomous** — Optionality to change, test, and deploy modules independently
- **Fun** — Enjoyable development experience, not fighting the codebase
- **to Operate** — Maintainable, observable, easy to run

When AI generates tightly-coupled or bloated code, you lose FAAFO:

```
Module A + Module B → Tangled Mass → Can't test independently →
Can't change independently → Lost optionality → Lost FAAFO
```

> "When you take two well-defined modules that could be developed and maintained separately and fuse them together, you destroy the optionality in FAAFO, as well as fast and fun."

This toolkit helps you maintain FAAFO by providing guardrails, verification, and architectural discipline for AI-assisted development.

## Quick Start

### Option 1: Start with Session Rules (5 minutes)

Copy the golden rules template to your project:

```bash
cp middle-developer-loop-toolkit/templates/AGENTS.md /path/to/your-project/
```

Edit to add your project's ALWAYS/NEVER rules, then reference at every session start:

```
Read AGENTS.md and confirm you understand the project rules.
```

### Option 2: Full Inner Loop Setup

```bash
cd inner-developer-loop-toolkit
./install.sh
```

This gives you:
- `checkpoint.sh` — Git checkpointing with explore/abandon workflow
- `test-runner.sh` — Continuous TDD testing
- `verify-ai-claims.sh` — Trust-but-verify automation
- `lint-and-correct.sh` — Multi-phase code cleanup

### Option 3: Full Middle Loop Setup

```bash
./middle-developer-loop-toolkit/scripts/init-middle-loop.sh /path/to/your-project
```

This copies session management templates to your project.

## Core Principles

From "Vibe Coding" Chapters 14-16:

1. **Decompose ruthlessly** — Keep tasks small and laser-focused
2. **Checkpoint frequently** — Save every 5-10 minutes
3. **Trust but verify** — Never accept "tests pass" without running them yourself
4. **TDD is essential** — Write tests first; bugs multiply as fast as features
5. **Know when to take the wheel** — If AI loops or fumbles, step in
6. **Session continuity** — Document state before ending (Memento Method)
7. **API preservation** — Never break existing functionality

## What's in Each Toolkit

### Inner Loop (Chapter 14)

Scripts and checklists for moment-to-moment coding:

```bash
# Checkpointing
checkpoint.sh save "message"    # Quick commit
checkpoint.sh explore "name"    # Create exploration branch
checkpoint.sh abandon           # Discard exploration
checkpoint.sh recover <commit>  # Roll back

# Testing
test-runner.sh watch            # Continuous testing
test-runner.sh verify           # Verify AI claims

# Verification
verify-ai-claims.sh             # Full verification suite
```

### Middle Loop (Chapter 15)

Templates for session management and multi-agent work:

| Template | Purpose |
|----------|---------|
| `AGENTS.md` | Golden rules (ALWAYS/NEVER do) |
| `SESSION_HANDOFF.md` | Document session state for continuity |
| `AGENT_STATUS.md` | Track multiple parallel agents |
| `TRACER_BULLET.md` | Minimal implementation before full build |

### Outer Loop (Chapter 16)

Strategic practices for long-term AI collaboration:

```bash
# Branch hygiene
branch-audit.sh list            # Show all branches
branch-audit.sh orphan          # Find abandoned branches

# API protection
api-diff-check.sh               # Detect breaking changes

# Architecture
architecture-report.sh          # Codebase health report
```

## Multi-Agent Scaling

| Agents | Overhead | Recommendation |
|--------|----------|----------------|
| 1 | None | Standard workflow |
| 2 | 2x mental load | Use AGENT_STATUS.md |
| 4+ | 10x+ organizational work | Full fleet management |

Requirements for multi-agent work:
- Separate branches per agent
- Non-overlapping file ownership
- Dedicated port ranges
- Clear merge scheduling

## Context Window Management

| Usage | Status | Action |
|-------|--------|--------|
| 0-50% | Safe | Work normally |
| 50-70% | Caution | Prepare to compact |
| 70-90% | Danger | Compact soon |
| 90%+ | Critical | Stop and compact |

## Supported Languages

All scripts auto-detect project type:

- **Node.js** — npm, Jest, Vitest, ESLint, Prettier
- **Python** — pytest, ruff, black, mypy
- **Rust** — cargo, clippy, rustfmt
- **Go** — go test, go vet, gofmt
- **Java** — Gradle, Maven, Checkstyle
- **Ruby** — RSpec, Minitest

## Repository Structure

```
vibe-coding-toolkit/
├── inner-developer-loop-toolkit/
│   ├── scripts/          # checkpoint.sh, test-runner.sh, etc.
│   ├── checklists/       # task-decomposition, verification, tdd-workflow
│   ├── prompts/          # specification, tdd, rubber-duck
│   └── templates/        # TASK_SPEC.md
│
├── middle-developer-loop-toolkit/
│   ├── templates/        # AGENTS.md, SESSION_HANDOFF.md, etc.
│   ├── templates-lite/   # Minimal versions
│   ├── checklists/       # session-transitions, multi-agent-coord
│   ├── prompts/          # keep-busy, agent-handoff
│   └── docs/             # QUICK_START.md, integrations/
│
└── outer-developer-loop-toolkit/
    ├── templates/        # API_CONTRACT.md, ARCHITECTURE_DECISION.md
    ├── checklists/       # api-preservation, git-discipline
    ├── prompts/          # architecture-review, disaster-recovery
    └── scripts/          # branch-audit.sh, api-diff-check.sh
```

## Key Quotes

> "Keep your prep work (tasks) small and laser-focused: Decompose ruthlessly."

> "Trust, but verify: Never assume 'it worked' or 'tests pass' without seeing the evidence."

> "Unlike a human teammate who remembers yesterday's progress, your AI assistant effectively walks into a closet and forgets everything at the end of each session."

> "You cannot break any existing functionality." — The One Rule of API preservation

> "All software project tasks have a last mile that requires human insight and oversight."

## License

MIT

## Attribution

Based on "Vibe Coding" by Gene Kim and Steve Yegge:
- Chapter 14: The Inner Developer Loop
- Chapter 15: The Middle Developer Loop
- Chapter 16: The Outer Developer Loop
