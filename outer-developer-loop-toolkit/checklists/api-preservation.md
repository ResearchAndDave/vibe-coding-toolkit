# API Preservation Checklist
<!-- Don't let AI torch your bridges -->

## The Problem

> "If you change a contract without warning, every service, script, or mobile app 
> depending on it breaks. API breakage is culinary sabotage at cloud scale."
> — Chapter 16, Vibe Coding

AI tends to modify and delete APIs to "clean up" code, breaking consumers.

---

## Golden Rule

> **"You cannot break any existing functionality."**

Add this exact phrase to every prompt involving existing code.

---

## Pre-Work Checklist

Before AI touches existing code:

- [ ] Identify all public APIs in scope
- [ ] Document current signatures
- [ ] List known consumers
- [ ] Add API constraints to prompt
- [ ] Set up API diff checking

---

## API Change Rules

### ✅ ALLOWED Changes

| Change Type | Example | Why OK |
|-------------|---------|--------|
| Add new function | `getUserV2()` | No impact on existing |
| Add optional parameter | `getUser(id, options?)` | Backward compatible |
| Add new endpoint | `POST /v2/users` | No impact on v1 |
| Add field to response | `{id, name, newField}` | Consumers ignore unknown |
| Deprecation warning | `@deprecated` annotation | Still works |

### ❌ FORBIDDEN Changes

| Change Type | Example | Why Bad |
|-------------|---------|---------|
| Rename function | `getUser` → `fetchUser` | Breaks callers |
| Change parameter type | `id: string` → `id: number` | Type errors |
| Remove parameter | `getUser(id, name)` → `getUser(id)` | Missing args |
| Change return type | `User` → `UserDTO` | Consumer breaks |
| Remove function | Delete `getUser()` | Callers fail |
| Remove endpoint | Delete `GET /users` | 404 errors |
| Remove response field | `{id}` → `{}` | Missing data |
| Change field type | `count: number` → `count: string` | Parse errors |

---

## Prompt Templates

### For Any Code Modification
```
CRITICAL: You cannot break any existing functionality.

Do not:
- Rename existing functions
- Change function signatures
- Remove any public functions
- Change return types
- Modify API response shapes

If you need different behavior, create a NEW function/endpoint alongside 
the existing one. Do not modify the original.
```

### For Refactoring
```
Refactor this code for [goal] while preserving ALL existing APIs exactly.

Rules:
1. Public function signatures must not change
2. Return types must not change
3. Create new internal functions if needed
4. Keep deprecated functions working
5. Add new APIs alongside old, don't replace
```

### For Feature Addition
```
Add [feature] to this module.

Constraints:
1. Do not modify existing function signatures
2. Do not change existing return types
3. Add new functions rather than modifying old
4. New parameters must have default values
5. Existing tests must continue to pass
```

---

## Verification Steps

### After AI Generates Code

1. **Diff Check**
   ```bash
   git diff --name-only  # List changed files
   git diff [file]       # Review each change
   ```

2. **Signature Check**
   - [ ] No function names changed
   - [ ] No parameter types changed
   - [ ] No return types changed
   - [ ] No functions removed

3. **Consumer Check**
   - [ ] Existing tests still pass
   - [ ] No new type errors
   - [ ] No runtime failures

4. **API Contract Check**
   - [ ] Matches API_CONTRACT.md
   - [ ] No undocumented changes

---

## Detection Script

Add to CI/CD:

```bash
#!/bin/bash
# api-diff-check.sh - Detect breaking API changes

# Compare public API signatures
# Fail if breaking changes detected

# For TypeScript
npx ts-api-checker --baseline api-baseline.json

# For OpenAPI
openapi-diff previous.yaml current.yaml --fail-on-breaking

# For generic comparison
diff -u api-signatures-baseline.txt api-signatures-current.txt
```

---

## Recovery: When APIs Get Broken

### Step 1: Assess Damage
- What changed?
- Who is affected?
- Is it in production?

### Step 2: Decide Response

| Situation | Response |
|-----------|----------|
| Not yet merged | Revert and redo correctly |
| Merged, not deployed | Revert merge |
| Deployed, few consumers | Hotfix + communicate |
| Deployed, many consumers | Version bump + deprecation |

### Step 3: Fix Forward (Gene's Approach)
```
Starting from scratch with one phrase: "You cannot break any existing functionality."
And the Git commit hash of the broken version.

Result: Ten minutes later, a nearly working version with old API preserved.
```

---

## Long-Term Practices

### Weekly API Review
- [ ] Check for unauthorized API changes
- [ ] Update API_CONTRACT.md
- [ ] Review deprecation timeline
- [ ] Audit consumer health

### Per-Release
- [ ] Generate API diff report
- [ ] Review all signature changes
- [ ] Update API documentation
- [ ] Communicate changes to consumers

### Annually
- [ ] Review deprecated APIs
- [ ] Plan safe removals (if any)
- [ ] Update API versioning strategy

---

## Philosophy Reminder

From Chapter 16's code survival graphs:

**Clojure & Linux** — Conservative API philosophy
- Very little code deletion
- Programs from a decade ago still work
- Horizontal lines = stability

**Scala** — Aggressive API changes
- Significant code destruction
- Old programs don't compile
- Jagged slopes = breakage

**Goal**: Be like Clojure and Linux, not Scala.

---

## Quick Reference

| Question | Answer |
|----------|--------|
| Can I rename this function? | NO — create new one |
| Can I change this parameter? | NO — add new optional param |
| Can I remove this? | NO — deprecate but keep |
| Can I change the return type? | NO — create new function |
| Can I add a new field? | YES — if optional |
| Can I add a new function? | YES — always |

---

*"The extent to which you preserve your API contracts has a huge impact on 
whether you'll continue growing your user base or alienate them over time."*
