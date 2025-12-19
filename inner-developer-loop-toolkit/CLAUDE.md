# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is the Inner Developer Loop Toolkit - a collection of shell scripts, checklists, prompts, and templates implementing AI-assisted development practices from "Vibe Coding" Chapter 14. It focuses on the fast-paced (seconds to minutes) coding cycle: Task → Code → Test → Verify → Commit.

## Repository Structure

```
scripts/           # Automation tools (bash)
  checkpoint.sh    # Git checkpointing (save/explore/abandon/recover/bisect)
  verify-ai-claims.sh  # Verify tests pass, code builds, nothing broke
  lint-and-correct.sh  # Multi-phase cleanup (style/efficiency/warnings/errors/debug/format)
  test-runner.sh   # TDD automation (watch/verify/coverage/quick/failed)

checklists/        # Human decision guides
templates/         # Task specification templates
prompts/           # AI prompt templates for spec generation, TDD, rubber duck debugging
```

## Script Commands

**Checkpointing** (scripts/checkpoint.sh):
```bash
checkpoint.sh save "message"    # Quick commit all changes
checkpoint.sh explore "name"    # Create exploration branch
checkpoint.sh abandon           # Discard exploration, return to main
checkpoint.sh recover <commit>  # Roll back to checkpoint
checkpoint.sh list              # Recent commits
checkpoint.sh bisect            # Find where things broke
```

**Test Running** (scripts/test-runner.sh):
```bash
test-runner.sh watch     # Continuous testing on file changes
test-runner.sh verify    # Verify AI's "tests pass" claim
test-runner.sh coverage  # Run with coverage
test-runner.sh quick     # Fast/changed tests only
test-runner.sh failed    # Re-run failed tests
```

**Linting** (scripts/lint-and-correct.sh):
```bash
lint-and-correct.sh all              # Run all 6 phases
lint-and-correct.sh style warnings   # Run specific phases
lint-and-correct.sh -d all           # Dry run
```

**Verification** (scripts/verify-ai-claims.sh):
```bash
verify-ai-claims.sh    # Full verification: tests exist, run, pass, build works, lint passes
```

## Key Principles (from Chapter 14)

1. **Decompose ruthlessly** - Keep tasks small and laser-focused
2. **Checkpoint frequently** - Save every 5-10 minutes
3. **Trust but verify** - Never accept "tests pass" without running them yourself
4. **TDD is essential** - Write tests first, watch them fail, then implement
5. **Know when to take the wheel** - If AI is looping or fumbling, step in

## Scripts Auto-Detect Project Type

All scripts detect project type from config files (package.json, requirements.txt, Cargo.toml, go.mod, etc.) and run appropriate tooling. Supported: Node.js, Python, Rust, Go, Java/Gradle/Maven, Ruby.
