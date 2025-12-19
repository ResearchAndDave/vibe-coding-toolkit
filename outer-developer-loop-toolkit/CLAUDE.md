# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is the **Outer Developer Loop Toolkit** — a documentation and tooling repository implementing Chapter 16 of "Vibe Coding" by Gene Kim and Steve Yegge. It focuses on strategic, long-term practices (weeks to months) for managing AI coding agents at scale.

**Scope**: Architecture decisions, API preservation, fleet management (4+ agents), CI/CD enhancement, and disaster recovery.

## Repository Structure

```
outer-developer-loop-toolkit/
├── templates/          # Fill-in documentation templates
│   ├── API_CONTRACT.md          # Register and protect API contracts
│   ├── ARCHITECTURE_DECISION.md # ADR template with AI implications
│   ├── FLEET_STATUS.md          # Dashboard for 4+ agent coordination
│   └── WORKSPACE_PARTITION.md   # Agent workspace isolation plans
├── checklists/         # Operational checklists
│   ├── api-preservation.md      # Rules preventing API breakage
│   ├── workspace-isolation.md   # Prevent "stewnamis"
│   ├── minimalism-modularity.md # Code hygiene enforcement
│   ├── audit-strategy.md        # Review depth by risk/familiarity
│   ├── git-discipline.md        # Branch hygiene, backup practices
│   └── cicd-enhancement.md      # AI-powered pipeline strategies
├── prompts/            # Ready-to-use prompt templates
│   ├── architecture-review.md   # Strategic code review prompts
│   ├── product-thinking.md      # AI as PM copilot
│   ├── disaster-recovery.md     # "Captain Jack Aubrey" recovery
│   └── process-reform.md        # Fighting bureaucracy with AI
└── scripts/            # Automation utilities
    ├── branch-audit.sh          # Find and analyze branch litter
    ├── api-diff-check.sh        # Detect breaking API changes
    └── architecture-report.sh   # Generate codebase health reports
```

## Running Scripts

All scripts are bash and require a git repository context:

```bash
# Branch hygiene audit
./scripts/branch-audit.sh list          # Show all branches with status
./scripts/branch-audit.sh orphan        # Find abandoned unmerged branches
./scripts/branch-audit.sh stale -d 14   # Branches inactive >14 days
./scripts/branch-audit.sh cleanup       # Interactive cleanup of merged branches
./scripts/branch-audit.sh report        # Generate markdown audit report

# API breaking change detection
./scripts/api-diff-check.sh             # Compare to origin/main
./scripts/api-diff-check.sh HEAD~5      # Compare to 5 commits ago
./scripts/api-diff-check.sh -t node     # Force project type detection
./scripts/api-diff-check.sh -v -s       # Verbose + strict mode

# Architecture health report
./scripts/architecture-report.sh                    # Analyze current directory
./scripts/architecture-report.sh src/ -o report.md  # Analyze src/, save to file
./scripts/architecture-report.sh -f json            # JSON output
```

## Core Principles

### API Preservation (The One Rule)
> "You cannot break any existing functionality."

When modifying code that uses these templates:
- Never rename existing functions
- Never change function signatures
- Never remove public functions
- Add new functions alongside old ones (accrete, don't destroy)
- New parameters must have default values

### Fleet Management
Managing 4+ AI agents requires 10x organizational overhead vs 2 agents. The FLEET_STATUS.md template provides:
- Agent role assignments
- Workspace partitions (directories, branches, ports)
- Merge scheduling
- Color-coded terminal organization

### Disaster Recovery
The "Captain Jack Aubrey" approach: When standard procedures fail, describe the high-level goal and let AI devise the recovery strategy.

## Related Toolkits

This is part of a three-toolkit system:
- **Inner Loop** (../inner-developer-loop-toolkit/) — seconds to minutes, single tasks
- **Middle Loop** (../middle-developer-loop-toolkit/) — hours to days, session management
- **Outer Loop** (this toolkit) — weeks to months, strategic architecture
