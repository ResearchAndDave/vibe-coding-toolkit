# Task Specification Template
<!-- Use this to define tasks before AI implementation -->

## Task: [TASK_NAME]

### Overview
**One-sentence description**: 
<!-- What are we building/fixing/changing? -->

**Why this matters**:
<!-- Business/technical justification -->

**Success looks like**:
<!-- How will we know we're done? -->

---

## Scope Definition

### In Scope ✅
<!-- What this task WILL accomplish -->
- 
- 
- 

### Out of Scope ❌
<!-- What this task will NOT touch -->
- 
- 
- 

### Assumptions
<!-- What we're assuming to be true -->
- 
- 

---

## Technical Specification

### Current State
<!-- How does it work now? -->
```
Describe current behavior or state
```

### Desired State
<!-- How should it work after? -->
```
Describe target behavior or state
```

### Files Likely to Change
<!-- Help AI know where to look -->
| File | Purpose | Type of Change |
|------|---------|----------------|
| | | Add/Modify/Delete |
| | | |

### Dependencies
<!-- What must exist/work for this task -->
- External: 
- Internal: 

---

## Acceptance Criteria

### Functional Requirements
- [ ] 
- [ ] 
- [ ] 

### Non-Functional Requirements
- [ ] Performance: 
- [ ] Security: 
- [ ] Backwards compatibility: 

### Test Cases
<!-- Specific scenarios to verify -->

**Happy Path**:
```
Given: 
When: 
Then: 
```

**Edge Cases**:
```
Given: 
When: 
Then: 
```

**Error Cases**:
```
Given: 
When: 
Then: 
```

---

## Implementation Plan

### Subtasks
<!-- Break into small, focused pieces -->

1. **[Subtask 1]** - _estimated: X minutes_
   - Description:
   - Verification:

2. **[Subtask 2]** - _estimated: X minutes_
   - Description:
   - Verification:

3. **[Subtask 3]** - _estimated: X minutes_
   - Description:
   - Verification:

### Order of Operations
<!-- What sequence should subtasks be done? -->
```
1 → 2 → 3 (linear)
OR
1 → (2, 3 parallel)
```

### Checkpoints
<!-- When to commit -->
- [ ] After subtask 1 (checkpoint: )
- [ ] After subtask 2 (checkpoint: )
- [ ] After all tests pass (final checkpoint)

---

## Risk Assessment

### What Could Go Wrong
| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| | Low/Med/High | Low/Med/High | |
| | | | |

### Rollback Plan
<!-- If this goes badly, how do we recover? -->
```
1. 
2. 
3. 
```

---

## Constraints & Guidelines

### Must Follow
<!-- From AGENTS.md or this task specifically -->
- 
- 

### Avoid
<!-- Known pitfalls -->
- 
- 

### Reference Materials
<!-- Helpful links, docs, examples -->
- 
- 

---

## Session Notes

### Questions for Clarification
<!-- AI should fill this in if unclear -->
- 

### Decisions Made
<!-- Document choices as you go -->
| Decision | Rationale | Date |
|----------|-----------|------|
| | | |

### Blockers Encountered
<!-- What got in the way? -->
- 

---

## Completion Checklist

### Before Marking Done
- [ ] All acceptance criteria met
- [ ] All tests passing
- [ ] Code reviewed/self-reviewed
- [ ] Documentation updated
- [ ] No debug code remaining
- [ ] Commit message written
- [ ] Edge cases handled
- [ ] Error handling in place

### Verification Command
```bash
# Command to verify everything works
npm test && npm run lint && npm run typecheck
```

---

*Created: [DATE]*
*Last Modified: [DATE]*
*Status: Draft | In Progress | Complete | Blocked*
