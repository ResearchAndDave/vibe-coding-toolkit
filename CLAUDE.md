# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

The Vibe Coding Toolkit is a collection of templates, checklists, prompts, and scripts for AI-assisted software development. Based on "Vibe Coding" by Gene Kim and Steve Yegge.

This is a **documentation-first toolkit repository**—files are meant to be copied to target projects and customized, not executed directly from here.

## Repository Structure

Three toolkits organized by developer loop timescale:

```
vibe-coding-toolkit/
├── inner-developer-loop-toolkit/   # Seconds to minutes
│   ├── scripts/                    # checkpoint.sh, test-runner.sh, lint-and-correct.sh, verify-ai-claims.sh
│   ├── checklists/                 # task-decomposition, verification, tdd-workflow, recovery-playbook
│   ├── prompts/                    # specification, tdd, rubber-duck
│   └── templates/                  # TASK_SPEC.md
│
├── middle-developer-loop-toolkit/  # Hours to days
│   ├── templates/                  # AGENTS.md, SESSION_HANDOFF.md, AGENT_STATUS.md, TRACER_BULLET.md
│   ├── templates-lite/             # Minimal versions for simple projects
│   ├── checklists/                 # session-transitions, multi-agent-coord, context-management
│   ├── prompts/                    # keep-busy, agent-handoff, workspace-optimization
│   ├── docs/                       # QUICK_START.md, integrations/
│   └── scripts/                    # init-middle-loop.sh
│
└── outer-developer-loop-toolkit/   # Days to weeks
    ├── templates/                  # API_CONTRACT.md, ARCHITECTURE_DECISION.md, FLEET_STATUS.md
    ├── checklists/                 # api-preservation, workspace-isolation, git-discipline, audit-strategy
    ├── prompts/                    # architecture-review, product-thinking, disaster-recovery
    └── scripts/                    # branch-audit.sh, api-diff-check.sh, architecture-report.sh
```

## Toolkit Purposes

| Toolkit | Timescale | Focus |
|---------|-----------|-------|
| Inner Loop | Seconds–minutes | Task execution, checkpointing, TDD, verification |
| Middle Loop | Hours–days | Session continuity, multi-agent coordination, context management |
| Outer Loop | Days–weeks | Architecture decisions, API preservation, fleet management (4+ agents) |

## Script Commands

### Inner Loop (checkpoint.sh)
```bash
checkpoint.sh save "message"    # Quick commit
checkpoint.sh explore "name"    # Create exploration branch
checkpoint.sh abandon           # Discard exploration
checkpoint.sh recover <commit>  # Roll back
checkpoint.sh bisect            # Find where things broke
```

### Inner Loop (test-runner.sh)
```bash
test-runner.sh watch     # Continuous testing
test-runner.sh verify    # Verify AI's "tests pass" claim
test-runner.sh coverage  # Run with coverage
```

### Outer Loop (branch-audit.sh)
```bash
branch-audit.sh list      # Show all branches
branch-audit.sh orphan    # Find abandoned branches
branch-audit.sh cleanup   # Interactive cleanup
```

### Outer Loop (api-diff-check.sh)
```bash
api-diff-check.sh              # Compare to origin/main
api-diff-check.sh HEAD~5       # Compare to 5 commits ago
api-diff-check.sh -v -s        # Verbose + strict mode
```

## Core Principles

1. **Decompose ruthlessly** — Keep tasks small and laser-focused
2. **Checkpoint frequently** — Save every 5-10 minutes
3. **Trust but verify** — Never accept "tests pass" without running them yourself
4. **TDD is essential** — Write tests first, watch them fail, then implement
5. **API preservation** — Never break existing functionality; accrete, don't destroy
6. **Session continuity** — Document state before ending sessions (Memento Method)

## Working with Templates

When modifying templates:
- Use `[BRACKETS]` for fill-in placeholder fields
- Use `- [ ]` checkbox syntax for checklists
- Include HTML comments for user instructions
- Keep templates generic; examples go in `examples/`
- Reference the source chapter from "Vibe Coding"

## Auto-Detection

All scripts auto-detect project type from config files (package.json, requirements.txt, Cargo.toml, go.mod, build.gradle, pom.xml, Gemfile) and run appropriate tooling for Node.js, Python, Rust, Go, Java, and Ruby projects.
