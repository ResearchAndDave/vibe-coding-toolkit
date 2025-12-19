# Inner Developer Loop Toolkit

Reusable scripts, checklists, and prompts for AI-assisted development. Based on Chapter 14 of "Vibe Coding" by Gene Kim and Steve Yegge.

## Quick Start

```bash
# Install (makes scripts executable and optionally adds to PATH)
./install.sh

# Or manually
chmod +x scripts/*.sh
```

## Scripts

### checkpoint.sh - Git Checkpointing
Save your work frequently so you can always roll back.

```bash
checkpoint.sh save "message"    # Commit all changes
checkpoint.sh explore "name"    # Create exploration branch
checkpoint.sh abandon           # Discard exploration, return to main
checkpoint.sh recover <commit>  # Roll back to a checkpoint
checkpoint.sh list              # Show recent commits
checkpoint.sh bisect            # Find where things broke
checkpoint.sh status            # Show current state
```

### test-runner.sh - TDD Automation
Run tests continuously and verify AI claims.

```bash
test-runner.sh watch     # Continuous testing on file changes
test-runner.sh once      # Run tests once (default)
test-runner.sh verify    # Verify AI's "tests pass" claim
test-runner.sh coverage  # Run with coverage report
test-runner.sh quick     # Fast/changed tests only
test-runner.sh failed    # Re-run only failed tests
```

### verify-ai-claims.sh - Trust But Verify
Never accept "all tests pass" without verification.

```bash
verify-ai-claims.sh      # Full verification suite
```

Checks: tests exist, tests run, tests pass, build succeeds, lint passes, type checking.

### lint-and-correct.sh - Multi-Phase Cleanup
Clean up AI-generated code systematically.

```bash
lint-and-correct.sh all              # Run all 6 phases
lint-and-correct.sh style            # Phase 1: Code style
lint-and-correct.sh efficiency       # Phase 2: Algorithmic issues
lint-and-correct.sh warnings         # Phase 3: Compiler warnings
lint-and-correct.sh errors           # Phase 4: Error handling
lint-and-correct.sh debug            # Phase 5: Debug cruft
lint-and-correct.sh format           # Phase 6: Formatting
lint-and-correct.sh -d all           # Dry run (no changes)
```

## Checklists

| File | Purpose |
|------|---------|
| `checklists/task-decomposition.md` | Breaking work into AI-manageable pieces |
| `checklists/verification.md` | Trust-but-verify checklist |
| `checklists/recovery-playbook.md` | Fix forward vs rollback decisions |
| `checklists/tdd-workflow.md` | Test-driven development with AI |
| `checklists/take-back-wheel.md` | When to take manual control |
| `checklists/ai-collaboration-tips.md` | Maximizing AI partnership |

## Prompts

| File | Purpose |
|------|---------|
| `prompts/specification.md` | Generate specs before coding |
| `prompts/tdd.md` | TDD prompts for AI |
| `prompts/rubber-duck.md` | Problem-solving conversations |

## Templates

| File | Purpose |
|------|---------|
| `templates/TASK_SPEC.md` | Define tasks before implementation |

## Supported Languages

All scripts auto-detect project type and use appropriate tooling:

- **Node.js** - npm, Jest, Vitest, Mocha, ESLint, Prettier
- **Python** - pytest, unittest, ruff, black, mypy
- **Java** - Gradle, Maven, Checkstyle, Spotless, google-java-format
- **Rust** - cargo, clippy, rustfmt
- **Go** - go test, go vet, gofmt
- **Ruby** - RSpec, Minitest

## Key Principles

1. **Decompose ruthlessly** - Keep tasks small and focused
2. **Checkpoint frequently** - Save every 5-10 minutes
3. **Trust but verify** - Always run tests yourself
4. **TDD is essential** - Write tests first
5. **Know when to take the wheel** - Step in when AI is stuck

## Learn More

See `IMPLEMENTATION_PLAN.md` for detailed documentation and quotes from Chapter 14.
