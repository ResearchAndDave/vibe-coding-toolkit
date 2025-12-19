# Task Decomposition Checklist
<!-- Breaking work into AI-manageable pieces -->

## Core Principle

> "Keep your prep work (tasks) small and laser-focused: Decompose ruthlessly."
> — Chapter 14, Vibe Coding

AI assistants work best with small, well-defined tasks. Large, ambiguous tasks lead to context saturation, scope creep, and poor results.

---

## Before Starting: Is This Task Ready?

### Size Check
- [ ] Can be completed in one session (< 2 hours)
- [ ] Fits in context window with room to spare
- [ ] Doesn't require major architectural decisions
- [ ] Has clear start and end points

### Clarity Check
- [ ] Success criteria are defined
- [ ] Input and output are clear
- [ ] Edge cases are identified
- [ ] Dependencies are understood

### Independence Check
- [ ] Can be worked on without blocking others
- [ ] Doesn't require coordination with other tasks
- [ ] Tests can be written independently
- [ ] Can be committed as a standalone change

**If any box is unchecked → Task needs further decomposition**

---

## Decomposition Strategies

### Strategy 1: Vertical Slice
Break by complete features through all layers:

```
Large Task: "Build user authentication"

Decomposed:
1. User can register with email/password
2. User can log in
3. User can log out
4. User can reset password
5. User can change password

Each slice is independently testable and deployable.
```

### Strategy 2: Horizontal Layer
Break by technical layer:

```
Large Task: "Add new API endpoint"

Decomposed:
1. Define API contract/types
2. Create database schema/migration
3. Implement data access layer
4. Implement business logic
5. Implement API handler
6. Add validation
7. Add tests

Each layer builds on the previous.
```

### Strategy 3: Component Isolation
Break by independent components:

```
Large Task: "Refactor payment system"

Decomposed:
1. Extract payment gateway interface
2. Implement Stripe adapter
3. Implement PayPal adapter
4. Add retry logic
5. Add logging/monitoring
6. Update existing callers

Each component can be tested in isolation.
```

### Strategy 4: Risk Reduction
Break by risk level, do risky parts first:

```
Large Task: "Migrate database"

Decomposed:
1. [TRACER] Verify we can read from both DBs
2. [TRACER] Verify we can write to new DB
3. Create migration scripts
4. Implement dual-write
5. Verify data consistency
6. Switch reads to new DB
7. Disable old DB

Fail fast on risky items before investing time.
```

---

## Decomposition Template

For each large task, fill out:

### Original Task
**Description**: [What needs to be done]
**Estimated Size**: [Small/Medium/Large/XL]
**Why It's Too Big**: [Context limits / unclear scope / multiple concerns]

### Subtasks

| # | Subtask | Est. Time | Dependencies | Success Criteria |
|---|---------|-----------|--------------|------------------|
| 1 | | | None | |
| 2 | | | #1 | |
| 3 | | | #1, #2 | |

### Order of Execution
```
Recommended sequence:
1 → 2 → 3 (linear)
OR
1 → (2, 3 in parallel) → 4
```

### Checkpoints
- [ ] After subtask 1: [What should be true]
- [ ] After subtask 2: [What should be true]
- [ ] After all subtasks: [Final verification]

---

## Red Flags: Task Too Big

### Time Indicators
- ⚠️ "This will take a few hours"
- ⚠️ "Let me work through this complex logic"
- ⚠️ "I need to make changes across multiple files"

### Complexity Indicators
- ⚠️ Multiple responsibilities in one task
- ⚠️ Unclear success criteria
- ⚠️ "It depends on how we handle..."
- ⚠️ Requires significant context loading

### Risk Indicators
- ⚠️ "I'll need to refactor this first"
- ⚠️ Multiple integration points
- ⚠️ Unfamiliar technology involved
- ⚠️ No clear rollback path

---

## Good vs Bad Task Definitions

### ❌ Bad: Too Vague
```
"Implement the user dashboard"
```

### ✅ Good: Specific and Bounded
```
"Create a dashboard component that displays:
- User's name and email
- Account creation date
- Number of active projects
Data comes from /api/user/profile endpoint (already exists)"
```

---

### ❌ Bad: Multiple Concerns
```
"Add authentication and authorization"
```

### ✅ Good: Single Concern
```
"Add JWT token validation middleware that:
- Extracts token from Authorization header
- Validates token signature
- Attaches user to request context
- Returns 401 if invalid"
```

---

### ❌ Bad: Unclear Success
```
"Improve the performance"
```

### ✅ Good: Measurable Success
```
"Optimize getUserPosts query to run in <100ms:
- Current: ~500ms
- Target: <100ms
- Approach: Add database index on user_id
- Verify: Run query with EXPLAIN ANALYZE"
```

---

### ❌ Bad: Too Many Files
```
"Refactor the entire codebase to use TypeScript"
```

### ✅ Good: One File at a Time
```
"Convert src/utils/format.js to TypeScript:
- Add type annotations
- No logic changes
- Ensure all imports/exports typed
- Tests still pass"
```

---

## Quick Decomposition Questions

Ask yourself:

1. **Can I explain this in one sentence?**
   - No → Break it down

2. **Can I write the test first?**
   - No → Clarify requirements

3. **Will this fit in one commit message?**
   - No → Multiple tasks

4. **Can I verify success immediately?**
   - No → Define success criteria

5. **Does this touch more than 3 files?**
   - Yes → Consider splitting

6. **Am I anxious about this task?**
   - Yes → It's too big

---

## The "What's the Smallest Thing" Test

For any task, ask:
> "What's the smallest thing I could do that would still provide value?"

Examples:
- Full feature → Just the happy path
- Complete API → Just one endpoint
- All validations → Just required fields
- Full test suite → Just the critical path
- Perfect solution → Working solution

Start with the smallest thing, then iterate.

---

## Tracking Decomposition

### Simple Markdown Checklist
```markdown
## Task: [Name]

### Subtasks
- [ ] Subtask 1 - Description
  - [ ] Sub-subtask 1a
- [ ] Subtask 2 - Description
- [ ] Subtask 3 - Description

### Progress
- [x] Completed items
- [ ] Remaining items
```

### Session Tracking
```markdown
## Session: [Date]
- [x] Subtask 1 ✓ (15 min)
- [x] Subtask 2 ✓ (20 min)
- [ ] Subtask 3 - paused, needs clarification

## Next Session
- [ ] Clarify subtask 3 requirements
- [ ] Complete subtask 3
- [ ] Subtask 4
```

---

## Remember

> "Decompose ruthlessly. The more frequently you checkpoint, the more options you have."

**Small tasks = Fast feedback = Higher quality = More fun**
