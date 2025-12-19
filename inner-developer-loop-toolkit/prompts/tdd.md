# TDD Prompts for AI-Assisted Development
## Test-Driven Development with AI Partners

---

## Starting a TDD Session

### Initialize Test-First Development
```
We're going to use TDD for this feature. Here's what I want:

[FEATURE DESCRIPTION]

Before writing ANY implementation code:
1. Write comprehensive tests that define the expected behavior
2. Include tests for: happy path, edge cases, error conditions
3. Make sure tests will FAIL initially (no implementation yet)
4. Use descriptive test names that document the behavior

Show me the tests first. Do NOT implement the feature yet.
```

### Generate Test Specification
```
I need tests for [COMPONENT/FUNCTION]. 

It should:
- [Behavior 1]
- [Behavior 2]
- [Behavior 3]

Generate a complete test file covering:
1. Normal operation cases
2. Edge cases (empty input, boundary values, etc.)
3. Error handling (invalid input, exceptions, etc.)
4. Integration points (if any)

Write ONLY the tests. Implementation comes after I approve these.
```

---

## During TDD Cycle

### After Tests Are Written
```
Good tests. Now implement the minimum code to make these tests pass.

Requirements:
- Only write enough code to pass the tests
- Don't add extra functionality not covered by tests
- Keep it simple - we'll refactor after tests pass
```

### After Implementation Passes
```
Tests pass. Now let's refactor for quality:
1. Check code style and elegance
2. Look for duplication
3. Improve naming
4. Add any missing error handling

Important: Run tests after each change to ensure nothing breaks.
```

### Adding More Tests
```
The basic functionality works. Now let's harden it.

Add tests for:
- [Additional edge case 1]
- [Additional edge case 2]
- [Performance under load]
- [Concurrent access]

Write the tests, then we'll update the implementation.
```

---

## Test Quality Prompts

### Review Test Quality
```
Review the tests we've written for [COMPONENT].

Check:
1. Do test names clearly describe behavior?
2. Is each test focused on ONE thing?
3. Are tests independent (can run in any order)?
4. Do we have false positives (tests that pass when they shouldn't)?
5. Are assertions meaningful?

Suggest improvements.
```

### Find Missing Test Cases
```
Look at [COMPONENT/FILE] and identify test cases we're missing.

Consider:
- Boundary conditions
- Null/empty handling
- Error paths
- Race conditions (if applicable)
- Integration edge cases

List the missing tests with brief descriptions.
```

### Improve Test Readability
```
Refactor these tests for better readability:

[TEST CODE]

Apply:
- Arrange-Act-Assert pattern
- Descriptive variable names
- Helper functions for common setup
- Clear assertion messages
- Remove duplication
```

---

## Fixing Test Issues

### Fix Flaky Test
```
This test is flaky (passes sometimes, fails sometimes):

[TEST CODE]

Diagnose the flakiness:
1. Is there a timing/race condition?
2. Is there hidden shared state?
3. Is the test order-dependent?
4. Is there external dependency?

Fix the root cause without just increasing timeouts.
```

### Test Won't Compile
```
This test won't compile:

[ERROR MESSAGE]

Fix the compilation error. 
Important: Don't change the test's intent - it should still verify [BEHAVIOR].
```

### Test Runs But Doesn't Test Anything
```
This test passes but I don't think it's actually testing anything:

[TEST CODE]

Review it:
1. Is it testing the right thing?
2. Would it catch bugs in the implementation?
3. Is it just testing the framework/mock setup?

Fix it to test real behavior.
```

---

## Integration with AI Workflow

### Verify Before Moving On
```
Before we continue, let's verify:

1. Run all tests and show me the output
2. Confirm how many tests ran (not skipped)
3. Confirm all passed
4. Show current test coverage

Do NOT proceed until I see this output myself.
```

### After AI Claims "Tests Pass"
```
You said tests pass. Let me verify:

1. Run tests again right now
2. Show me the actual output
3. Show me the test count
4. Confirm nothing was skipped or disabled

I need to see this with my own eyes.
```

### Catch AI Test Sabotage
```
I'm suspicious about the tests. Check for:

1. Tests that were disabled/skipped
2. Tests that were deleted
3. Tests with weakened assertions
4. Timeouts that were increased
5. Error handling that was loosened

Report any changes to tests since [CHECKPOINT].
```

---

## Test Coverage Prompts

### Check Coverage Gaps
```
Run tests with coverage and identify:
1. Lines not covered
2. Branches not covered
3. Functions not tested

For the most critical gaps, suggest tests to add.
```

### Critical Path Coverage
```
These are the critical paths in [COMPONENT]:
- [Path 1]
- [Path 2]
- [Path 3]

Verify we have tests for each. If any are missing, write them now.
```

---

## TDD Anti-Pattern Detection

### Detect Implementation-First Creep
```
I want to verify we're still doing TDD properly.

For [RECENT CHANGES], confirm:
1. Tests were written before implementation
2. Tests failed initially (no false green)
3. Implementation was minimal to pass tests
4. Refactoring happened after green

Flag any deviations from TDD.
```

### Detect Over-Mocking
```
Review the mocks/stubs in our tests:

1. Are we mocking too much?
2. Are tests testing mocks instead of real behavior?
3. Should any mocks be replaced with real implementations?
4. Are mock setups more complex than the code being tested?
```

---

## Quick Reference

### TDD Mantras
- "Red, Green, Refactor"
- "Write the test you wish you had"
- "Tests are executable documentation"
- "If it's not tested, it's broken"
- "Trust but verify (AI especially)"

### Common Commands
```bash
# Before starting work
./test-runner.sh once           # Verify clean state

# During development  
./test-runner.sh watch          # Continuous testing

# After AI says "done"
./test-runner.sh verify         # Independent verification

# Before committing
./test-runner.sh coverage       # Check coverage
```

---

*Based on Chapter 14: The Inner Developer Loop from "Vibe Coding" by Gene Kim and Steve Yegge*
