# AI Verification Checklist
<!-- Trust, but verify - Use this before accepting AI's claims -->

## Quick Verification (Every Time)

### 1. Tests Actually Work
- [ ] Tests **compile** (not just "defined")
- [ ] Tests **execute** (actually run, not skipped)
- [ ] Tests **pass** (green, not pending/skipped)
- [ ] Ran the **full suite** (not just new tests)
- [ ] **You ran them** (not just AI's claim)

### 2. Code Actually Works
- [ ] Build succeeds without errors
- [ ] Application starts/runs
- [ ] Feature works as expected (manual test)
- [ ] Edge cases handled

### 3. Nothing Else Broke
- [ ] Other tests still pass
- [ ] Related features still work
- [ ] No new warnings introduced
- [ ] No degraded performance

---

## Warning Signs (When AI Might Be Lying)

### "All Tests Pass" Red Flags
| AI Says | Reality Check |
|---------|---------------|
| "Tests are passing" | Did it actually RUN them? |
| "Fixed the failing test" | Did it delete or skip the test instead? |
| "All green" | Any tests marked as pending/skipped? |
| "Tests complete" | Any tests that don't compile? |

### Reward Hijacking Patterns
AI may appear successful without actual success:

**Watch for:**
- ☑ checkboxes in Markdown without actual completion
- Enthusiastic summaries that hide partial work
- "Standardized" or "improved" (code for "didn't fix")
- Lengthening timeouts instead of fixing timing issues
- Disabling features instead of fixing them

### Context Saturation Signs
- Forgetting recent instructions
- Repeating work already done
- Contradicting earlier statements
- Missing obvious patterns

---

## Verification Commands

### Node.js/TypeScript
```bash
# Full verification
npm test
npm run lint
npm run typecheck  # or: npx tsc --noEmit
npm run build

# Quick check
npm test -- --coverage
```

### Python
```bash
# Full verification
pytest -v
mypy .
ruff check .
python -m py_compile *.py

# Quick check
pytest --tb=short
```

### Rust
```bash
# Full verification
cargo test
cargo clippy -- -D warnings
cargo build --release

# Quick check
cargo test --quiet
```

### Go
```bash
# Full verification
go test -v ./...
go vet ./...
go build ./...

# Quick check
go test ./...
```

### Java (Gradle)
```bash
# Full verification
./gradlew test
./gradlew check
./gradlew build

# Quick check
./gradlew test --quiet
```

---

## Deep Verification (When Suspicious)

### 1. Check Test Coverage
```bash
# Node
npm test -- --coverage

# Python
pytest --cov=. --cov-report=html

# Go
go test -cover ./...
```

**Questions:**
- Did coverage increase or decrease?
- Are new functions tested?
- Are edge cases covered?

### 2. Review Actual Changes
```bash
git diff --stat
git diff [files]
```

**Check:**
- [ ] Changes make sense
- [ ] No unrelated changes snuck in
- [ ] No removed code that shouldn't be
- [ ] No added debug code

### 3. Inspect Skipped/Disabled Tests
```bash
# Find skipped tests
grep -r "@Disabled\|@Ignore\|skip\|xtest\|xit" --include="*.ts" --include="*.js" --include="*.py" --include="*.java"
```

**Questions:**
- Why are these skipped?
- Were they working before?
- Did AI skip them to "fix" the build?

### 4. Check for Sneaky Changes
```bash
# Did AI commit without asking?
git log --oneline -5

# Any unexpected files?
git status

# Anything in .gitignore that shouldn't be?
cat .gitignore
```

---

## Verification Levels

### Level 1: Quick (30 seconds)
When: Minor changes, high trust
- [ ] Tests pass
- [ ] Build succeeds

### Level 2: Standard (2 minutes)
When: Most changes
- [ ] All Level 1
- [ ] Lint passes
- [ ] Type check passes
- [ ] Manual feature test

### Level 3: Thorough (5 minutes)
When: Complex changes, low trust
- [ ] All Level 2
- [ ] Review git diff
- [ ] Check test coverage
- [ ] Look for skipped tests
- [ ] Performance check

### Level 4: Paranoid (10+ minutes)
When: Critical code, repeated issues
- [ ] All Level 3
- [ ] Step through in debugger
- [ ] Check every changed file
- [ ] Run integration tests
- [ ] Test in production-like environment

---

## Response Patterns

### When Verification Passes ✅
```
1. Commit the changes
2. Document what was verified
3. Move to next task
```

### When Verification Fails ❌
```
1. STOP - Don't accept the changes
2. Identify what specifically failed
3. Show AI the actual failure output
4. Ask for correction with evidence
5. Re-verify after fix
```

### When Suspicious 🟡
```
1. Ask AI: "Show me the test output"
2. Ask AI: "Run the tests again and show full output"
3. Run tests yourself
4. Compare AI's claims vs actual results
5. If discrepancy: start over or take control
```

---

## Verification Scripts

### One-liner: Trust but verify
```bash
# Node
npm test && npm run lint && npm run build && echo "✅ VERIFIED"

# Python
pytest && ruff check . && echo "✅ VERIFIED"

# Rust
cargo test && cargo clippy && echo "✅ VERIFIED"

# Go
go test ./... && go vet ./... && echo "✅ VERIFIED"
```

### Use the toolkit script
```bash
./scripts/verify-ai-claims.sh
```

---

## Remember

> "AI coding assistants now have their own twist on 'it worked for me.' 
> They'll tell you 'All the tests are now passing' while missing glaringly 
> obvious issues."
> — Chapter 14, Vibe Coding

**The only verified claim is one you verified yourself.**
