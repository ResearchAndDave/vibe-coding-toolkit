# Audit Strategy Checklist
<!-- Matching verification rigor to risk and expertise -->

## The Framework

> "The depth of your review should be proportional to both the project's 
> risk level and your familiarity with the programming language."
> — Chapter 16, Vibe Coding

---

## The Four Quadrants

```
                    KNOW TECH WELL          KNOW TECH POORLY
                ┌─────────────────────┬─────────────────────┐
                │                     │                     │
   HIGH RISK    │   Deep White-Box    │   Multi-Layered     │
                │   + Black-Box       │   Verification      │
                │                     │                     │
                │   "Dissect every    │   "Calculated risk, │
                │    layer"           │    extra checks"    │
                ├─────────────────────┼─────────────────────┤
                │                     │                     │
   LOW RISK     │   Light Review      │   Pure Black-Box    │
                │                     │                     │
                │   "Quick glance,    │   "Classic vibe     │
                │    smoke tests"     │    coding"          │
                │                     │                     │
                └─────────────────────┴─────────────────────┘
```

---

## Quadrant 1: High Risk, Know Tech Well

**Examples**: 
- Gene's writer's workbench (Clojure)
- Steve's Wyvern production server (Kotlin)

### What to Do

**White-Box Audit**:
- [ ] Read all generated code line by line
- [ ] Look for subtle issues: race conditions, edge cases
- [ ] Trace execution paths
- [ ] Review data structures
- [ ] Check error handling
- [ ] Look for security issues

**Black-Box Testing**:
- [ ] Unit tests for all paths
- [ ] Integration tests
- [ ] Edge case testing
- [ ] Performance testing
- [ ] Load testing (if applicable)

**Checklist**:
- [ ] Every function reviewed
- [ ] All edge cases tested
- [ ] Error paths verified
- [ ] Security review complete
- [ ] Performance acceptable
- [ ] No regressions

---

## Quadrant 2: High Risk, Know Tech Poorly

**Examples**:
- Steve's TypeScript client (unfamiliar tech, replaces 4 codebases)
- Any mission-critical work in new language

### What to Do

**Heavy Black-Box Testing**:
- [ ] Comprehensive test suites
- [ ] Specification-based testing
- [ ] Behavioral verification
- [ ] Integration tests

**Lighter White-Box**:
- [ ] Scan for obvious red flags
- [ ] Look for `deleteAllData()` type issues
- [ ] Check for unreasonable file counts
- [ ] Spot obviously wrong patterns

**AI as Reviewer**:
```
Please review this code you generated:
1. Explain your implementation choices
2. Identify potential edge cases
3. Critique your own work
4. What could go wrong?
5. What would you do differently?
```

**Checklist**:
- [ ] Extensive black-box tests pass
- [ ] No obvious red flags in code
- [ ] AI self-review complete
- [ ] Behavior matches spec
- [ ] Integration verified
- [ ] Risk acknowledged and documented

---

## Quadrant 3: Low Risk, Know Tech Well

**Examples**:
- Gene's Trello research automation
- Side projects in your comfort zone
- Internal tools

### What to Do

**Light Review**:
- [ ] Quick visual inspection
- [ ] Smoke tests
- [ ] "LGTM" approach is OK

**Checklist**:
- [ ] Basic functionality works
- [ ] No obvious bugs
- [ ] Doesn't break existing things
- [ ] Good enough for purpose

**Warning**: If project grows rapidly, reassess quadrant.

---

## Quadrant 4: Low Risk, Know Tech Poorly

**Examples**:
- One-off data analysis scripts
- Steve's test migration (low risk, learning framework)
- Gene's Python notebook cluster analysis

### What to Do

**Pure Black-Box**:
- [ ] Check inputs
- [ ] Verify outputs look reasonable
- [ ] Don't worry about internals

> "You weigh the coffee beans before and after they pass through the 
> grinder, and if the numbers match, you serve the espresso without 
> ever having to open up the machine."

**Checklist**:
- [ ] Input data is correct
- [ ] Output looks reasonable
- [ ] Results match expectations
- [ ] Good enough for use case

**Classic Vibe Coding**:
- Stay ignorant of internals (intentionally)
- Embrace exponentials
- Let AI handle details
- Accept calculated risk

---

## Determining Your Quadrant

### Risk Assessment

| Factor | Low Risk | High Risk |
|--------|----------|-----------|
| Users affected | Just me | Many/public |
| Data sensitivity | None | PII, financial |
| Failure impact | Inconvenience | Outage, loss |
| Reversibility | Easy rollback | Hard to undo |
| Compliance | None | Regulated |

### Tech Familiarity Assessment

| Factor | Know Well | Know Poorly |
|--------|-----------|-------------|
| Years experience | 2+ | < 1 |
| Production use | Extensive | Limited |
| Idiomatic patterns | Fluent | Learning |
| Debug ability | Can trace | Struggle |
| Can spot bad code | Easily | Not really |

---

## Audit Depth by Quadrant

| Quadrant | Code Review | Testing | Time Investment |
|----------|-------------|---------|-----------------|
| Q1: High/Know | Every line | Extensive | Hours |
| Q2: High/Don't Know | Red flags | Heavy black-box | Hours |
| Q3: Low/Know | Glance | Smoke tests | Minutes |
| Q4: Low/Don't Know | Skip | Check I/O | Minutes |

---

## When to Upgrade Quadrant

### Low Risk → High Risk
- Project gains users
- Stakes increase
- Moving toward production
- Handling sensitive data

### Know Poorly → Know Well
- After significant experience
- After studying the codebase
- After debugging sessions
- When patterns become familiar

---

## Audit Prompts by Quadrant

### Q1: Deep Audit
```
I need a thorough review of this code. For each function:
1. What could go wrong?
2. Are there race conditions?
3. Are edge cases handled?
4. Is error handling robust?
5. Any security concerns?
6. Performance issues?
```

### Q2: Multi-Layer Check
```
Review this code at multiple levels:

Black-box: Does it behave correctly for these inputs?
[List test cases]

Red flags: Anything obviously wrong or suspicious?

Self-critique: What would you do differently?
```

### Q3: Quick Sanity
```
Quick review - any obvious issues?
- Syntax errors?
- Logic bugs?
- Missing error handling?
```

### Q4: Output Verification
```
I'm checking the output only:
- Input: [description]
- Expected: [description]
- Actual: [what AI produced]

Does this look reasonable?
```

---

## Documentation Template

For each significant piece of AI-generated code:

```markdown
## Audit Record

**Date**: 
**Code**: [file/module]
**Quadrant**: Q[1-4] - [Risk]/[Familiarity]

### Risk Assessment
- Users: 
- Data sensitivity: 
- Failure impact: 
- Reversibility: 

### Tech Familiarity
- Experience level: 
- Can I debug this?: 

### Audit Performed
- [ ] Code review (depth: __)
- [ ] Tests (coverage: __%)
- [ ] AI self-review
- [ ] Manual testing

### Findings
- 

### Sign-off
- Reviewed by: 
- Decision: Ship / Revise / Reject
```

---

## Quick Reference

| Your Situation | Do This |
|----------------|---------|
| Production + Your Language | Full audit |
| Production + New Language | Heavy testing + red flag scan |
| Side Project + Your Language | Quick look + smoke test |
| Side Project + New Language | Check inputs/outputs |
| Stakes increasing | Move up a quadrant |
| Unfamiliar becoming familiar | May move right over time |

---

*"AI wrote the code for you, but you still own it."*
