# Inner Developer Loop Toolkit
## A Reusable Implementation of "Vibe Coding" Chapter 14

---

## Executive Summary

This toolkit provides reusable implementations of the Inner Developer Loop practices from the Vibe Coding book. The Inner Loop focuses on the **fast-paced (seconds to minutes)** immediate work where developers and AI assistants rapidly exchange ideas and code.

**Scope**: Moment-to-moment coding activities within a single session.

**See Also**: The [Middle Developer Loop Toolkit](../middle-developer-loop-toolkit/) for session transitions, multi-agent coordination, and golden rules.

---

## What's in the Inner Loop?

The Inner Loop is your rapid-fire coding cycle:

```
┌─────────────────────────────────────────┐
│           INNER LOOP                    │
│         (seconds to minutes)            │
│                                         │
│   Task → Code → Test → Verify → Commit  │
│     ↑                            │      │
│     └────────────────────────────┘      │
└─────────────────────────────────────────┘
```

**Key Activities**:
- Breaking down tasks
- Writing and testing code
- Checkpointing progress
- Verifying AI's claims
- Fixing issues (forward or back)
- Problem-solving conversations

**NOT in Inner Loop** (see Middle Loop):
- Session handoffs
- Multi-agent coordination
- Golden rules (AGENTS.md)
- Workspace organization

---

## Implementation Architecture

```
inner-developer-loop-toolkit/
├── IMPLEMENTATION_PLAN.md          # This document
├── templates/
│   └── TASK_SPEC.md               # Task specification template
├── scripts/
│   ├── checkpoint.sh              # Git checkpointing automation
│   ├── verify-ai-claims.sh        # AI claim verification
│   ├── lint-and-correct.sh        # Multi-phase linting
│   └── test-runner.sh             # TDD test automation
├── checklists/
│   ├── task-decomposition.md      # Breaking down work
│   ├── verification.md            # Trust-but-verify checklist
│   ├── recovery-playbook.md       # Fix forward vs rollback
│   ├── tdd-workflow.md            # Test-driven development workflow
│   ├── take-back-wheel.md         # When to take manual control
│   └── ai-collaboration-tips.md   # Learn while watching + help AI navigate
└── prompts/
    ├── specification.md           # Spec generation prompts
    ├── rubber-duck.md             # Problem-solving prompts
    └── tdd.md                     # TDD prompts for AI
```

---

## The Three Controls

The framework is organized around three control types:

### PREVENT — Stop problems before they occur
- Task decomposition into AI-manageable pieces
- Specification generation before coding
- Checkpointing for safe exploration
- Help AI navigate your codebase

### DETECT — Catch problems as early as possible
- Verify AI's claims ("trust but verify")
- TDD for immediate feedback
- Monitor for AI going off track
- Watch for context saturation and reward hijacking
- Learn while watching (become a better developer)

### CORRECT — Fix problems quickly and systematically
- Recovery playbook (fix forward vs rollback)
- Linting and correction automation
- Take back the wheel when needed (the last mile)
- Debugger and start-over strategies
- Rubber duck problem-solving

---

## Component Details

### 1. Task Decomposition

**Purpose**: Break work into small, focused pieces AI can handle reliably.

**Files**:
- `checklists/task-decomposition.md` — Step-by-step decomposition guide
- `templates/TASK_SPEC.md` — Task specification format

**Key Principles**:
- Each task completable in one sitting
- Clear success criteria
- Defined dependencies
- Small enough to fit in context

### 2. Specification Generation

**Purpose**: Have AI generate detailed specs before coding.

**Files**:
- `prompts/specification.md` — Prompts for spec generation

**Workflow**:
1. Describe what you want
2. AI generates detailed spec
3. Review and refine spec
4. ONLY THEN proceed to implementation

### 3. Checkpointing

**Purpose**: Frequent saves so you can always roll back.

**Files**:
- `scripts/checkpoint.sh` — Git automation

**Commands**:
```bash
checkpoint save "message"   # Quick commit
checkpoint explore "name"   # Create exploration branch
checkpoint abandon          # Discard exploration
checkpoint recover <commit> # Roll back
checkpoint list             # Recent commits
checkpoint bisect           # Find where things broke
```

### 4. Test-Driven Development (TDD)

**Purpose**: Catch bugs instantly through test-first development.

**Files**:
- `checklists/tdd-workflow.md` — Complete TDD process with AI
- `scripts/test-runner.sh` — Automated test runner
- `prompts/tdd.md` — TDD prompts for AI assistance

**Why TDD Matters More with AI** (from Chapter 14):
> "The case for test-driven development (TDD), where you write tests before the code, has never been stronger... With AI, we're generating code at unprecedented speeds—which means bugs can multiply just as rapidly."

**TDD Cycle with AI**:
```
1. Write Test (with AI help)
2. Watch it FAIL (verify test works)
3. Have AI write minimal code
4. Watch it PASS (verify yourself!)
5. Refactor (use lint-and-correct)
6. Checkpoint (commit working code)
```

**Commands**:
```bash
test-runner.sh watch    # Continuous testing
test-runner.sh verify   # Verify AI's "tests pass" claim
test-runner.sh coverage # Check coverage
test-runner.sh quick    # Fast tests only
```

**Key Practices**:
- Quality over quantity (one thorough test beats ten shallow ones)
- Have AI fix flaky tests immediately
- Shift toward higher-level integration tests
- Run full test suite, not just new tests

### 5. Verification

**Purpose**: Never trust AI's "all tests pass" without checking.

**Files**:
- `scripts/verify-ai-claims.sh` — Automated verification
- `checklists/verification.md` — Manual checklist

**Key Checks**:
- Tests actually compile
- Tests actually run (not skipped)
- Tests actually pass
- You ran them (not just AI's claim)
- Nothing else broke

### 6. Recovery

**Purpose**: Systematic approach to fixing problems.

**Files**:
- `checklists/recovery-playbook.md` — Decision framework

**Decision Matrix**:
| Understand issue? | Tests pass? | Action |
|-------------------|-------------|--------|
| Yes | Mostly | Fix forward |
| Yes | No | Assess scope |
| No | - | Roll back |

### 7. Linting & Correction

**Purpose**: Systematically clean AI-generated code.

**Files**:
- `scripts/lint-and-correct.sh` — Multi-phase cleanup

**Phases** (run sequentially):
1. Code style and elegance
2. Algorithmic appropriateness
3. Error/warning cleanup
4. Robust error handling
5. Debug cruft removal
6. Consistent formatting

### 8. Rubber Duck Problem-Solving

**Purpose**: Use AI as a thinking partner, not just code generator.

**Files**:
- `prompts/rubber-duck.md` — Conversation starters

**Key Approach**:
```
"Let's think through this together..."
NOT
"Fix this for me."
```

### 9. Taking Back the Wheel

**Purpose**: Know when and how to take manual control.

**Files**:
- `checklists/take-back-wheel.md` — Decision framework and strategies

**The Last Mile** (from Chapter 14):
> "All software project tasks have a last mile that requires human insight and oversight. Every software task handled by AI must be 'completed' by a human in that last mile."

**Three Strategies**:
1. **Methodical Debugging** (Gene's approach): Document scenarios, direct AI precisely
2. **Use the Debugger** (Steve's approach): Step through code execution
3. **Start Fresh**: Clear context, try completely different approaches

**Warning Signs**:
- AI repeating same failing approach
- Complexity increasing without progress
- Context window filling with logging noise
- 20+ minutes without forward motion

### 10. AI Collaboration Optimization

**Purpose**: Maximize benefit from AI partnership.

**Files**:
- `checklists/ai-collaboration-tips.md` — Learn while watching + help AI navigate

**Learn While Watching** (from Chapter 14):
> "You learn a ton of interesting things that make you a better developer, without having to try."

**Tell AI Where the Freezer Is** (from Chapter 14):
> "When you see [AI fumbling], hit ESC and tell it where the file is... Maybe put it in your AGENTS.md file."

**Key Practices**:
- Pay attention to AI's commands and techniques
- Keep a learning log of discoveries
- Proactively provide project navigation info
- Delegate cleanup tasks immediately

---

## Typical Inner Loop Workflow

```
1. PREPARE
   ├── Define task (use TASK_SPEC.md template)
   ├── Generate specification with AI
   ├── Write tests FIRST (TDD)
   └── Review and refine spec + tests

2. EXECUTE (TDD Cycle)
   ├── Verify tests FAIL initially
   ├── Have AI implement minimal code
   ├── Run tests continuously (test-runner.sh watch)
   ├── Verify claims as you go
   └── Checkpoint after each green

3. VERIFY
   ├── Run test-runner.sh verify
   ├── Run verify-ai-claims.sh
   ├── Test manually if needed
   └── Check nothing else broke

4. CORRECT (if needed)
   ├── Consult recovery-playbook.md
   ├── Fix forward or roll back
   └── Run lint-and-correct.sh

5. COMPLETE
   ├── Final checkpoint
   ├── Clean up
   └── Ready for next task
```

---

## Quick Reference

### Before Each Task
- [ ] Task is small and focused
- [ ] Success criteria defined
- [ ] Spec generated and reviewed
- [ ] **Tests written FIRST** (TDD)
- [ ] Starting from clean state

### During Each Task
- [ ] **Tests running in watch mode**
- [ ] Checkpoint frequently (every 5-10 min)
- [ ] Verify AI claims as you go
- [ ] Watch for AI going off track
- [ ] Keep tasks focused

### After Each Task
- [ ] Run full verification
- [ ] **All tests passing (verified by you)**
- [ ] Clean up code
- [ ] Final checkpoint
- [ ] Nothing broken

---

## Success Metrics

| Metric | Target |
|--------|--------|
| Time to detect broken code | < 2 minutes |
| Checkpoint frequency | Every 5-10 minutes |
| AI claim verification rate | 100% |
| Rollback recovery time | < 15 minutes |
| Tasks completed per session | Varies by size |

---

## Relationship to Middle Loop

| Inner Loop (This Toolkit) | Middle Loop |
|---------------------------|-------------|
| Single session | Across sessions |
| Minutes | Hours to days |
| Task execution | Context management |
| Immediate verification | Golden rules |
| Single agent focus | Multi-agent coordination |

**Use Together**: Inner Loop for moment-to-moment work, Middle Loop for continuity across time and agents.

---

## Getting Started

### 1. Copy templates to your project
```bash
cp templates/TASK_SPEC.md your-project/
```

### 2. Make scripts executable
```bash
chmod +x scripts/*.sh
```

### 3. Start with task decomposition
Use `checklists/task-decomposition.md` to break down your first task.

### 4. Generate a spec
Use `prompts/specification.md` before coding.

### 5. Work with frequent checkpoints
Use `scripts/checkpoint.sh` throughout.

### 6. Always verify
Run `scripts/verify-ai-claims.sh` before considering work done.

---

## Key Quotes from Chapter 14

> "Keep your prep work (tasks) small and laser-focused: Decompose ruthlessly."

> "Save your game more often: Use version control for every incremental success."

> "Trust, but verify: Never assume 'it worked' or 'tests pass' without seeing the evidence."

> "Know when to take the whisk back: If AI is fumbling or stuck in a loop, step in."

> "The case for test-driven development (TDD), where you write tests before the code, has never been stronger."

> "With AI, we're generating code at unprecedented speeds—which means bugs can multiply just as rapidly if we're not careful. This is where TDD shines."

> "All software project tasks have a last mile that requires human insight and oversight."

> "You learn a ton of interesting things that make you a better developer, without having to try." (on watching AI work)

> "When you see [AI fumbling], hit ESC and tell it where the file is." (on helping AI navigate)

> "AI can be like a slot machine with infinite upsides and nearly infinite downsides."

> "Don't let your bugs age like milk. In vibe coding, fresh bugs are the only acceptable bugs."

---

*Based on Chapter 14: The Inner Developer Loop from "Vibe Coding" by Gene Kim and Steve Yegge*
