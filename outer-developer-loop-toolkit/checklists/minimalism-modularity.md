# Minimalism & Modularity Checklist
<!-- Preventing code bloat and architectural decay -->

## The Problem

> "You ask for a simple UI spinner, and you get a solution that employs a 
> baffling array of methods when a handful would suffice. Request a test, 
> and it might try to emulate your production environment, generating 
> thousands of lines of mock infrastructure."
> — Chapter 16, Vibe Coding

AI tends to create verbose, over-engineered code that fuses modules together.

---

## Why It Matters

**Bloat Spiral**:
```
More code → Harder for AI to understand → AI creates more code → ...
```

**Fusion Problem**:
```
Module A + Module B → Tangled Mass → Can't test independently → 
Can't change independently → Lost optionality → Lost FAAFO
```

---

## Minimalism Practices

### 1. Question Every Addition

Before accepting AI-generated code, ask:

- [ ] Does this need a new library?
- [ ] Does this need a new file?
- [ ] Can existing structures handle this?
- [ ] Is this the simplest solution?

**Prompt Addition**:
```
Before adding any new files, libraries, or abstractions, explain why 
existing structures cannot accommodate this functionality.
```

---

### 2. Set Code Budgets

Constrain AI to work within limits:

- [ ] "Solve this in under 50 lines"
- [ ] "Modify at most 3 files"
- [ ] "No new dependencies"
- [ ] "Maximum 2 new functions"

**Prompt Addition**:
```
Constraint: Solve this problem with minimal changes. Maximum [N] lines 
of new code. Maximum [N] files modified.
```

---

### 3. Refactor After Pattern

Two-phase approach:

**Phase 1**: Let AI generate functional code
```
Implement [feature]. Focus on functionality, not elegance.
```

**Phase 2**: Separate cleanup pass
```
Now refactor this code for:
- Conciseness (fewer lines)
- Readability (clear naming)
- Elegance (idiomatic patterns)

Do not add any new functionality.
```

---

### 4. Ban Unnecessary Dependencies

- [ ] No new libraries without approval
- [ ] Prefer standard library solutions
- [ ] Justify every new import

**Prompt Addition**:
```
Do not add any new external dependencies. Use only existing libraries 
and standard library functions. If you believe a new dependency is 
essential, explain why before adding it.
```

---

### 5. Surgical Commits

- [ ] Smallest possible changes
- [ ] Single concern per commit
- [ ] Reject sprawling diffs

**Review Checklist**:
- Does this touch unrelated files?
- Could this be split into smaller changes?
- Is any of this code unused?

---

## Modularity Practices

### 1. Define Clear Boundaries

Before AI works on code:

- [ ] List modules in scope
- [ ] List modules explicitly OUT of scope
- [ ] Document interfaces between modules

**Prompt Addition**:
```
You may modify: [module A], [module B]
You may NOT modify: [module C], [module D]
You may NOT create new connections between modules without approval.
```

---

### 2. Enforce Interface Immutability

**Golden Rule for AGENTS.md**:
```markdown
## Module Rules

Existing module interfaces are SACROSANCT. You may NOT:
- Change function signatures in index.ts / __init__.py
- Add new exports without approval
- Create dependencies between previously independent modules
- Bypass interfaces to access internals
```

---

### 3. Mandate Diff Reviews for Sprawl

When reviewing AI changes:

- [ ] How many files were touched?
- [ ] Should this logically be localized?
- [ ] Are changes spreading unexpectedly?

**Warning Signs**:
- Simple feature touches 10+ files
- Changes span multiple modules
- New imports across module boundaries

---

### 4. Regular Architecture Audits

Weekly or per-release:

- [ ] Check for coupling violations
- [ ] Identify modules that grew too large
- [ ] Find opportunities to split
- [ ] Detect circular dependencies

**Audit Prompt**:
```
Analyze this codebase for architectural issues:
1. Which modules are tightly coupled?
2. Are there circular dependencies?
3. Which files are too large?
4. Are module boundaries being respected?
5. What refactoring would improve modularity?
```

---

## Code Hygiene Metrics

### Track These Over Time

| Metric | Healthy | Warning | Critical |
|--------|---------|---------|----------|
| Avg file size | < 300 lines | 300-500 | > 500 |
| Max file size | < 500 lines | 500-1000 | > 1000 |
| Dependencies per module | < 5 | 5-10 | > 10 |
| Circular dependencies | 0 | 1-2 | > 2 |
| Cross-module calls | Decreasing | Stable | Increasing |

---

## Before/After Comparison

When AI generates code, compare:

| Aspect | Before | After | Delta |
|--------|--------|-------|-------|
| Total lines | | | |
| Number of files | | | |
| Dependencies | | | |
| Public functions | | | |
| Cross-module imports | | | |

**If deltas are large, question the approach.**

---

## Review Checklist for AI Code

### Minimalism Check
- [ ] No unnecessary abstractions
- [ ] No over-engineered solutions
- [ ] No unused code
- [ ] No redundant comments
- [ ] Could this be simpler?

### Modularity Check
- [ ] Changes are localized
- [ ] No new module dependencies
- [ ] Interfaces unchanged
- [ ] No internal bypasses
- [ ] Tests are isolated

### Dependency Check
- [ ] No new libraries
- [ ] No version bumps unless needed
- [ ] Standard library preferred
- [ ] Justified if new dependency added

---

## Prompt Templates

### For New Features
```
Add [feature] with minimal code.

Rules:
- No new dependencies
- Modify as few files as possible
- No changes to module interfaces
- Prefer simple over clever
- If you need more than 100 lines, explain why first
```

### For Bug Fixes
```
Fix [bug] surgically.

Constraint: Touch only the code directly related to the bug.
Do not refactor unrelated code.
Do not "improve" anything not broken.
```

### For Cleanup
```
Reduce code in [module] by at least 20%.

Approach:
1. Remove dead code
2. Combine duplicate logic
3. Simplify over-engineered solutions
4. Use standard library instead of custom code

Do not change any public interfaces.
```

---

## Recovery: When Code Bloats

### Immediate Actions
1. Identify the bloated area
2. Create cleanup task
3. Don't let it spread further

### Cleanup Sprint
```
This module has grown unwieldy. Help me:
1. Identify code that can be deleted
2. Find duplication that can be merged
3. Simplify overly complex logic
4. Split into smaller focused modules

Constraint: Preserve all existing public APIs.
```

### Prevention
- Add module size limits to AGENTS.md
- Set up automated complexity warnings
- Regular architecture reviews

---

## Quick Reference

| Question | Minimalist Answer |
|----------|-------------------|
| Add a library for this? | Can stdlib do it? |
| Create a new abstraction? | Is the simple version sufficient? |
| Add another file? | Can it fit in existing files? |
| Make it more flexible? | Is it needed now? |
| Add configuration options? | Are defaults acceptable? |

---

*"When you take two well-defined modules that could be developed and 
maintained separately and fuse them together, you destroy the optionality 
in FAAFO, as well as fast and fun."*
