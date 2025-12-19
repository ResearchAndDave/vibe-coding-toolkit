# Workspace AI-Friendliness Audit
<!-- Is your project designed for AI collaboration? -->

## Overview

This audit evaluates how well your codebase is structured for AI assistance. Score each section, then prioritize improvements based on impact.

> "You shouldn't code against the grain of your AI assistants."
> — Chapter 15, Vibe Coding

---

## Scoring Guide

| Score | Meaning |
|-------|---------|
| ✅ 2 | Excellent - AI-optimized |
| 🟡 1 | Acceptable - Room for improvement |
| ❌ 0 | Problematic - Actively hinders AI |

---

## Audit Sections

### 1. Project Structure

| Criterion | Score | Notes |
|-----------|-------|-------|
| Standard layout for language/framework | /2 | |
| Clear directory organization | /2 | |
| Logical module boundaries | /2 | |
| Maximum 3 levels of nesting | /2 | |
| Separation of concerns | /2 | |

**Section Score**: /10

**Issues Found**:
- 

**Recommended Actions**:
- 

---

### 2. File Sizes

| Criterion | Score | Notes |
|-----------|-------|-------|
| No files > 1000 lines | /2 | |
| Most files < 500 lines | /2 | |
| No "god classes/modules" | /2 | |
| Logical file splitting | /2 | |
| One concept per file | /2 | |

**Section Score**: /10

**Largest Files**:
1. [filename] - [lines]
2. [filename] - [lines]
3. [filename] - [lines]

**Recommended Actions**:
- 

---

### 3. Naming Conventions

| Criterion | Score | Notes |
|-----------|-------|-------|
| Consistent casing throughout | /2 | |
| Meaningful names (no abbreviations) | /2 | |
| Predictable file naming | /2 | |
| Matches community conventions | /2 | |
| No naming conflicts | /2 | |

**Section Score**: /10

**Inconsistencies Found**:
- 

**Recommended Actions**:
- 

---

### 4. Module Boundaries

| Criterion | Score | Notes |
|-----------|-------|-------|
| Clear public interfaces | /2 | |
| Explicit exports | /2 | |
| No circular dependencies | /2 | |
| Minimal cross-module coupling | /2 | |
| Well-defined responsibilities | /2 | |

**Section Score**: /10

**Coupling Issues**:
- 

**Recommended Actions**:
- 

---

### 5. Documentation

| Criterion | Score | Notes |
|-----------|-------|-------|
| README.md in project root | /2 | |
| Module-level documentation | /2 | |
| API documentation | /2 | |
| Architecture overview | /2 | |
| AGENTS.md for AI rules | /2 | |

**Section Score**: /10

**Missing Documentation**:
- 

**Recommended Actions**:
- 

---

### 6. Code Patterns

| Criterion | Score | Notes |
|-----------|-------|-------|
| Explicit over magic | /2 | |
| Clear dependency injection | /2 | |
| Consistent error handling | /2 | |
| Standard patterns used | /2 | |
| Minimal global state | /2 | |

**Section Score**: /10

**Magic/Implicit Patterns Found**:
- 

**Recommended Actions**:
- 

---

### 7. Testing

| Criterion | Score | Notes |
|-----------|-------|-------|
| Tests co-located with source | /2 | |
| Clear test file naming | /2 | |
| Tests runnable with one command | /2 | |
| Good test coverage | /2 | |
| Tests are reliable (not flaky) | /2 | |

**Section Score**: /10

**Testing Issues**:
- 

**Recommended Actions**:
- 

---

### 8. Technology Choices

| Criterion | Score | Notes |
|-----------|-------|-------|
| Popular language/framework | /2 | |
| Standard build system | /2 | |
| Mainstream dependencies | /2 | |
| Conventional tooling | /2 | |
| Good AI training coverage | /2 | |

**Section Score**: /10

**Exotic Choices**:
- 

**Recommended Actions**:
- 

---

## Summary

### Total Score

| Section | Score | Max |
|---------|-------|-----|
| Project Structure | | 10 |
| File Sizes | | 10 |
| Naming Conventions | | 10 |
| Module Boundaries | | 10 |
| Documentation | | 10 |
| Code Patterns | | 10 |
| Testing | | 10 |
| Technology Choices | | 10 |
| **TOTAL** | | **80** |

### AI-Friendliness Rating

| Score | Rating | Assessment |
|-------|--------|------------|
| 70-80 | ⭐⭐⭐⭐⭐ | Excellent - AI-optimized |
| 55-69 | ⭐⭐⭐⭐ | Good - Minor improvements |
| 40-54 | ⭐⭐⭐ | Fair - Notable friction |
| 25-39 | ⭐⭐ | Poor - Significant barriers |
| 0-24 | ⭐ | Critical - Major restructuring needed |

**Your Rating**: ⭐

---

## Priority Actions

### High Impact (Do First)
1. 
2. 
3. 

### Medium Impact
1. 
2. 
3. 

### Low Impact (Nice to Have)
1. 
2. 
3. 

---

## Quick Fixes (< 1 hour)

- [ ] Add AGENTS.md
- [ ] Update README.md
- [ ] Fix inconsistent naming (most egregious)
- [ ] Add module index files
- [ ] Document public APIs

## Medium Effort (1-4 hours)

- [ ] Split largest file
- [ ] Add missing documentation
- [ ] Fix circular dependencies
- [ ] Co-locate tests with source
- [ ] Standardize error handling

## Major Refactoring (Days)

- [ ] Restructure project layout
- [ ] Split monolithic modules
- [ ] Migrate to mainstream framework
- [ ] Comprehensive documentation
- [ ] Full test coverage

---

## Re-Audit Schedule

- [ ] After major changes
- [ ] Monthly review
- [ ] After AI friction incidents

---

## Commands for Audit

```bash
# Count lines per file
find . -name "*.ts" -o -name "*.py" | xargs wc -l | sort -n

# Find largest files
find . -name "*.ts" -exec wc -l {} + | sort -rn | head -20

# Check for circular dependencies (Node)
npx madge --circular src/

# Find inconsistent naming
ls -la src/ | grep -v "^d"

# Check for TODO/FIXME
grep -rn "TODO\|FIXME\|XXX" --include="*.ts" src/
```

---

*Based on "Design for AI Manufacturing" from Chapter 15, Vibe Coding*
