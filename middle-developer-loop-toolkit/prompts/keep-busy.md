# Keep-Busy Prompts for AI Agents
<!-- Productive tasks when you're occupied elsewhere -->

## Overview

When you're busy and can't provide new direction, these prompts keep your AI agent productively occupied instead of sitting idle. As noted in Chapter 15:

> "Asking them to revisit their work and have them rerun tests can reveal that the work is not finished at all—the 'finished build' doesn't compile, the 'running tests' are missing, or some other dodgy characterization of 'done.'"

---

## Quick Reference (Copy-Paste Ready)

### Verification Tasks
```
Run all tests again and report any failures. Show me the actual output.
```

```
Improve the test cases for [file/function]. Add edge cases and error conditions.
```

```
Review the code you just wrote for missing edge cases. What inputs haven't we handled?
```

### Iteration Tasks
```
Iterate on this first draft. Check for:
- Error handling robustness
- Code style consistency
- Potential performance issues
- Missing documentation
Make improvements and show me what you changed.
```

```
Make it better. More robust, more readable, more efficient. Show your changes.
```

### Cleanup Tasks
```
Clean up your mess:
- Remove temp files
- Delete unused branches
- Remove debug print statements
- Ensure all untracked files are added or removed
- Clean up commented-out code
```

```
Write a Markdown summary of what you've done and anything you couldn't finish.
```

### Documentation Tasks
```
Make sure documentation is up to date:
- README accurate?
- Code comments clear?
- Type definitions complete?
- Any new APIs documented?
```

### Security Tasks
```
Try writing tests designed to break your own solution. Think like an attacker.
```

```
Review for security issues:
- Input validation
- Error message information leakage  
- Authentication/authorization
- SQL injection / XSS / etc.
```

### Quality Tasks
```
Prepare a diff or code review package. Summarize what changed and why.
```

```
Summarize anything suspicious you noticed while coding. What might cause problems later?
```

---

## Detailed Prompts by Category

### 1. Test Improvement

#### Run Tests Again
```
Run all tests again from scratch and report:
1. Total tests run
2. Tests passed
3. Tests failed (with failure messages)
4. Tests skipped (and why)
5. Any warnings

Show me the actual test output, don't summarize.
```

#### Improve Test Coverage
```
Analyze the code in [file/module] and improve its test coverage:

1. Identify untested code paths
2. Add tests for edge cases:
   - Empty inputs
   - Null/undefined values
   - Boundary conditions
   - Invalid inputs
   - Concurrent operations
3. Add tests for error conditions
4. Ensure tests are meaningful, not just for coverage

Show me each new test and what it's testing.
```

#### Find Gaps
```
Review [function/class] and identify test gaps:
- What inputs haven't we tested?
- What error conditions aren't covered?
- What integration scenarios are missing?

List the gaps but don't implement yet.
```

### 2. Code Quality

#### Self-Review
```
Review the code you just wrote as if you were a senior engineer doing code review.

Check for:
- [ ] Clear, descriptive names
- [ ] Single responsibility principle
- [ ] Proper error handling
- [ ] No magic numbers/strings
- [ ] Appropriate comments (why, not what)
- [ ] Consistent style
- [ ] No dead code
- [ ] No security issues

Report issues found and fix them.
```

#### Iterate and Improve
```
Take another pass at the code. Improve it by:

1. Making it more readable
2. Making it more robust
3. Making it more efficient
4. Removing duplication
5. Improving error messages
6. Adding input validation

Show me the before and after for each improvement.
```

#### Check for Common Issues
```
Review for these common AI-generated code issues:

- [ ] Unused variables or imports
- [ ] Inconsistent naming
- [ ] Missing type annotations
- [ ] Empty catch blocks
- [ ] Hardcoded values that should be config
- [ ] Missing null checks
- [ ] Race conditions
- [ ] Memory leaks

Report and fix any found.
```

### 3. Cleanup

#### Remove Debug Code
```
Find and remove all debug artifacts:

- console.log / print statements
- debugger statements
- Commented-out code blocks
- TODO comments that were completed
- Test data that should be removed
- Temporary workarounds

Show me what you're removing before removing it.
```

#### Clean Working Directory
```
Clean up the working directory:

1. Run `git status` and show me untracked files
2. For each: should it be added, ignored, or deleted?
3. Clean up any temporary files (*.tmp, *.bak, *~)
4. Remove any unused dependencies
5. Clean build artifacts

Ask before deleting anything important.
```

#### Branch Cleanup
```
Review git branches and suggest cleanup:

1. List all local branches
2. Identify branches that have been merged
3. Identify stale branches (not updated recently)
4. Suggest which to delete

Don't delete anything without confirmation.
```

### 4. Documentation

#### Update Docs
```
Review and update documentation:

1. Is the README current?
2. Are code comments accurate?
3. Are type definitions complete?
4. Are API docs up to date?
5. Are examples still working?

Make updates where needed and show me changes.
```

#### Write Summary
```
Write a Markdown summary document of this session:

## What Was Done
- List of completed tasks

## What's Left
- List of incomplete tasks

## Key Decisions
- Important choices made and why

## Known Issues
- Problems discovered but not fixed

## Next Steps
- Recommended next actions

Save to [SESSION_SUMMARY.md].
```

### 5. Security and Robustness

#### Adversarial Testing
```
Put on your black hat. Try to break the code:

1. What malicious inputs could cause problems?
2. What unexpected states could occur?
3. What resource exhaustion attacks are possible?
4. What data could leak through errors?

Write tests for each vulnerability you identify.
```

#### Error Handling Review
```
Review error handling throughout the code:

1. Are all errors caught appropriately?
2. Are error messages helpful but not leaky?
3. Do errors propagate correctly?
4. Is there proper cleanup on error?
5. Are there any silent failures?

Fix any issues found.
```

### 6. Performance

#### Performance Review
```
Review for performance issues:

1. Any O(n²) or worse algorithms?
2. Any unnecessary iterations?
3. Any repeated expensive operations?
4. Any missing caching opportunities?
5. Any blocking operations that could be async?

Report findings with severity assessment.
```

---

## When to Use Which Prompt

| Situation | Best Prompt |
|-----------|-------------|
| Just finished feature | Run tests + Self-review |
| About to step away (short) | Iterate and improve |
| About to step away (long) | Write summary |
| Before committing | Cleanup + Prepare review |
| Low confidence in code | Adversarial testing |
| Complex logic added | Add edge case tests |
| End of session | Update docs + Summary |

---

## Prompts to Avoid

Don't ask for:
- Busy work that doesn't add value
- Tasks that require your input
- Changes that conflict with other work
- Refactoring without tests to verify

---

## Pro Tips

1. **Stack prompts**: "Run tests, then improve coverage, then clean up"

2. **Be specific**: Instead of "improve tests", say "add tests for error handling in auth module"

3. **Verify results**: When you return, check what the agent actually did

4. **Time-box**: "Spend no more than 10 minutes on improvements, then summarize"

5. **Prioritize**: "Focus on the most critical code paths first"

---

> "This self-critiquing pattern allows Steve to reclaim 15–20% more productive time 
> and spares him the tedium of reviewing half-baked outputs."
> — Chapter 15, Vibe Coding

**Tokens are cheap. Your time is not. Keep agents productive.**
