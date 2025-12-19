# TDD Workflow Checklist
## Test-Driven Development for AI-Assisted Coding

---

## Why TDD Matters More with AI

From Chapter 14:
> "The case for test-driven development (TDD), where you write tests before the code, has never been stronger... With AI, we're generating code at unprecedented speeds—which means bugs can multiply just as rapidly if we're not careful."

**Key insight**: Google's TAP team found bugs have an "emotional half-life"—the longer they exist, the less urgently we fix them. TDD catches bugs instantly.

---

## The TDD Cycle with AI

```
┌─────────────────────────────────────────┐
│           TDD + AI CYCLE                │
│                                         │
│   1. Write Test (with AI help)          │
│            ↓                            │
│   2. Watch it FAIL (verify test works)  │
│            ↓                            │
│   3. Have AI write minimal code         │
│            ↓                            │
│   4. Watch it PASS (verify yourself!)   │
│            ↓                            │
│   5. Refactor (use lint-and-correct)    │
│            ↓                            │
│   6. Checkpoint (commit working code)   │
│            └──────────────┐             │
│                           ↓             │
│              Next Test ───┘             │
└─────────────────────────────────────────┘
```

---

## Pre-Coding Checklist

Before writing any implementation code:

- [ ] **Test file exists** for the feature/module
- [ ] **Test describes behavior**, not implementation
- [ ] **Success criteria** are clear and testable
- [ ] **Edge cases** identified upfront
- [ ] **AI understands** what the test should verify

### Prompt for Test Generation
```
Before implementing [FEATURE], let's write tests first.

I want tests that verify:
1. [Expected behavior 1]
2. [Expected behavior 2]
3. [Edge case 1]
4. [Error condition 1]

Write comprehensive tests. Don't implement the feature yet.
```

---

## During-Development Checklist

While AI is generating code:

- [ ] **Run tests frequently** (every few minutes)
- [ ] **Watch tests in separate terminal** for instant feedback
- [ ] **Verify tests actually execute** (not skipped)
- [ ] **Check test output yourself** (don't trust AI's claims)
- [ ] **Stop AI immediately** if tests start failing

### Test Monitoring Setup
```bash
# Terminal 1: AI coding session
# Terminal 2: Continuous test runner

# For JavaScript/Node
npm test -- --watch

# For Python
pytest --watch  # or: ptw

# For Java/Kotlin
./gradlew test --continuous

# For Go
gotestsum --watch
```

---

## Test Quality Checklist

Ensure tests are meaningful, not just present:

### Test Coverage
- [ ] **Happy path** tested
- [ ] **Error conditions** tested
- [ ] **Boundary values** tested
- [ ] **Empty/null inputs** tested
- [ ] **Integration points** tested

### Test Independence
- [ ] Each test can run **in isolation**
- [ ] Tests don't depend on **execution order**
- [ ] Tests clean up **after themselves**
- [ ] No **shared mutable state** between tests

### Test Readability
- [ ] Test names **describe behavior**
- [ ] **Arrange-Act-Assert** pattern used
- [ ] **One assertion concept** per test
- [ ] Failed test clearly shows **what went wrong**

---

## AI-Specific TDD Practices

### Quality Over Quantity
From Chapter 14:
> "Start with quality over quantity: Collaborate with your assistant on one thorough test before generating ten more."

- [ ] First test is **comprehensive and correct**
- [ ] Review AI-generated tests **before trusting them**
- [ ] Tests actually **test what they claim**

### Fixing Flaky Tests
From Chapter 14:
> "Have AI fix flaky tests: Tests that spuriously fail contribute to the 'broken windows' problem."

- [ ] **No flaky tests** in suite (fix immediately)
- [ ] Flakiness indicates **loss of control**
- [ ] Use AI to **diagnose and fix** test instability

### Higher-Level Testing
From Chapter 14:
> "Shift toward higher-level testing: As AI generates more granular functions, your tests should verify how components work together."

- [ ] **Integration tests** for component interactions
- [ ] **End-to-end tests** for critical paths
- [ ] Unit tests for **complex logic only**

---

## Verification Checklist

After AI claims "all tests pass":

### Immediate Verification
- [ ] **Run tests yourself** in terminal
- [ ] Verify tests **actually compiled**
- [ ] Verify tests **actually ran** (check count)
- [ ] Verify tests **actually passed** (no skips)
- [ ] Check for **new warnings**

### Deeper Verification
- [ ] **Read the test code** - does it test what it should?
- [ ] **Mutation test** - does changing code break tests?
- [ ] **Coverage check** - is critical code covered?
- [ ] **Manual smoke test** - does feature actually work?

---

## Test Automation Setup

### Recommended Test Runner Configuration

```yaml
# Example: package.json test config
{
  "scripts": {
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "test:ci": "jest --ci --coverage --watchAll=false"
  }
}
```

```yaml
# Example: pytest.ini
[pytest]
testpaths = tests
addopts = -v --tb=short
python_files = test_*.py
python_functions = test_*
```

### IDE Integration
- [ ] Tests run on **file save**
- [ ] Test results visible **in editor**
- [ ] Failed tests **highlight source location**
- [ ] Coverage **displayed inline**

---

## Recovery When Tests Break

### Test Started Failing

| Situation | Action |
|-----------|--------|
| Just changed code | Revert last change |
| Multiple changes since pass | Use git bisect |
| Test was always wrong | Fix test, then code |
| Flaky test | Fix flakiness first |

### Test Won't Compile

1. **Stop AI** immediately
2. Review AI's changes
3. Revert to last working state
4. Have AI try smaller change

### Lost Track of Test State

```bash
# Find last commit where tests passed
git log --oneline | head -20
git stash
git checkout <commit>
./run-tests.sh  # Verify it passes
git checkout -
git stash pop
```

---

## Simon Willison Case Study

From Chapter 14:
> "Simon Willison is running production code written in Go, complete with tests and continuous integration (CI/CD), despite 'not being a Go programmer.'"

Key takeaways:
- **TDD enabled confidence** without language fluency
- **Tests proved code worked** despite unfamiliar syntax
- **CI/CD automated verification** beyond local testing
- **6 months in production** with zero major issues

---

## Quick Reference Commands

```bash
# Start TDD session
checkpoint save "Starting TDD for [feature]"

# After writing test
checkpoint save "Added test for [behavior]"

# After implementation passes
checkpoint save "Implemented [feature] - tests pass"

# After refactoring
checkpoint save "Refactored [area] - tests still pass"
```

---

## Red Flags to Watch For

🚩 AI says "tests pass" but you didn't see them run
🚩 Test count decreased (AI deleted tests!)
🚩 Tests pass but feature doesn't work manually
🚩 AI "standardizes" or "improves" failing tests instead of fixing code
🚩 AI increases timeout instead of fixing slow test
🚩 AI disables/skips tests instead of fixing them

---

*Based on Chapter 14: The Inner Developer Loop from "Vibe Coding" by Gene Kim and Steve Yegge*
