# Specification Generation Prompts
<!-- Have AI generate and study specs before coding -->

## Overview

One of the most powerful Inner Loop techniques is having AI generate a detailed specification *before* writing any code. This creates shared understanding and catches misalignments early.

> "Have AI generate a specification and study it: This shared understanding prevents many mistakes."
> — Chapter 14, Vibe Coding

---

## Core Principle

```
1. Describe what you want
2. Have AI generate detailed spec
3. Review and refine spec
4. ONLY THEN proceed to implementation
```

This extra step pays dividends by catching issues before code is written.

---

## Specification Request Prompts

### Basic Spec Request
```
Before writing any code, create a detailed specification for: [feature/task]

Include:
- Purpose and goals
- Inputs and outputs
- Success criteria
- Edge cases to handle
- Error conditions
- Dependencies

Don't write code yet—let's review the spec first.
```

### Detailed Technical Spec
```
I need a technical specification for: [feature]

Please include:

## Overview
- What problem this solves
- Who/what uses it

## Interface
- Function signatures / API endpoints
- Input types and validation rules
- Output types and formats
- Error responses

## Behavior
- Happy path flow
- Edge cases (list each)
- Error handling approach

## Constraints
- Performance requirements
- Security considerations
- Backwards compatibility

## Test Cases
- Key scenarios to verify
- Expected inputs → outputs

Review this spec with me before implementation.
```

### API Specification
```
Design the API specification for: [feature]

For each endpoint, specify:
- HTTP method and path
- Request body schema (with types)
- Response schema (with types)
- Status codes and when they occur
- Authentication requirements
- Rate limiting

Format as OpenAPI/Swagger if possible, or clear documentation.

Don't implement—let's review the contract first.
```

### Data Model Specification
```
Design the data model for: [feature]

Include:
- Entity definitions with fields and types
- Relationships between entities
- Indexes needed
- Constraints (unique, not null, etc.)
- Migration strategy from current state

Show me the schema before writing migrations.
```

### Algorithm Specification
```
Before implementing, specify the algorithm for: [problem]

Include:
- Input format and constraints
- Output format
- Step-by-step approach (pseudocode OK)
- Time complexity analysis
- Space complexity analysis
- Edge cases and how they're handled

Let's review the approach before coding.
```

---

## Refinement Prompts

### Challenge the Spec
```
Look at this specification critically:

[paste spec]

What's missing? What could go wrong? What edge cases aren't covered?
```

### Simplify the Spec
```
This spec feels overcomplicated:

[paste spec]

Can we simplify while still meeting the core requirements? What can we cut?
```

### Add Edge Cases
```
Review this spec and add edge cases I might have missed:

[paste spec]

For each edge case, specify expected behavior.
```

### Security Review
```
Review this specification for security concerns:

[paste spec]

What attack vectors should we consider? What validation is missing?
```

### Performance Review
```
Review this specification for performance:

[paste spec]

Where might we have bottlenecks? What should we optimize or cache?
```

---

## Spec Templates by Type

### Function Specification
```markdown
## Function: [name]

### Purpose
[What this function does and why]

### Signature
```[language]
function name(param1: Type, param2: Type): ReturnType
```

### Parameters
| Name | Type | Required | Description | Validation |
|------|------|----------|-------------|------------|
| param1 | Type | Yes | Description | Rules |

### Returns
- Type: [return type]
- Description: [what it represents]

### Errors
| Condition | Error Type | Message |
|-----------|------------|---------|
| [when] | [type] | [message] |

### Examples
```[language]
// Input
name(x, y)
// Output
result
```

### Edge Cases
- [ ] Empty input → [behavior]
- [ ] Null input → [behavior]
- [ ] [other] → [behavior]
```

### API Endpoint Specification
```markdown
## Endpoint: [METHOD /path]

### Purpose
[What this endpoint does]

### Authentication
[Required auth level]

### Request
```json
{
  "field": "type - description"
}
```

### Response (200)
```json
{
  "field": "type - description"
}
```

### Errors
| Status | Code | When |
|--------|------|------|
| 400 | INVALID_INPUT | [condition] |
| 401 | UNAUTHORIZED | [condition] |
| 404 | NOT_FOUND | [condition] |

### Example
```bash
curl -X POST /path -d '{"field": "value"}'
```
```

### Component Specification
```markdown
## Component: [Name]

### Purpose
[What this component does in the system]

### Props/Inputs
| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|

### State
| Name | Type | Initial | Description |
|------|------|---------|-------------|

### Events/Outputs
| Name | Payload | When Emitted |
|------|---------|--------------|

### Behavior
- On mount: [what happens]
- On [event]: [what happens]
- On unmount: [cleanup]

### Dependencies
- [List external dependencies]

### Test Scenarios
- [ ] [Scenario 1]
- [ ] [Scenario 2]
```

---

## Workflow: Spec → Implementation

### Step 1: Initial Spec Request
```
I want to build [feature]. Before coding, write a specification covering:
- What it does
- How it works
- Edge cases
- Error handling
```

### Step 2: Review and Refine
```
Looking at this spec:
- [Question about unclear part]
- [Suggestion for improvement]
- What about [edge case]?

Update the spec to address these.
```

### Step 3: Confirm Understanding
```
Let me summarize my understanding:
[Your summary]

Is this correct? Anything I'm missing?
```

### Step 4: Approve and Proceed
```
The spec looks good. Now implement it, following the specification exactly.
Start with [specific part] and checkpoint before moving on.
```

### Step 5: Verify Against Spec
```
Compare your implementation to the spec:
- Does it handle all specified edge cases?
- Does it match the interface exactly?
- Are error conditions handled as specified?
```

---

## When to Use Specifications

### Always Use Specs For:
- New features
- API design
- Data model changes
- Complex algorithms
- Anything with multiple edge cases

### Skip Specs For:
- Simple bug fixes
- Trivial changes
- Well-understood patterns
- Quick experiments (tracer bullets)

---

## Anti-Patterns

### ❌ Don't: Skip Straight to Code
```
"Build me a user authentication system"
→ AI writes code immediately
→ Misses requirements
→ Rework required
```

### ✅ Do: Spec First
```
"Before building user auth, spec out:
- Registration flow
- Login flow  
- Password reset
- Session management
- Security requirements"
→ Review spec
→ Refine spec
→ Then implement
```

### ❌ Don't: Accept Vague Specs
```
"Handles errors appropriately"
"Validates input"
"Returns the result"
```

### ✅ Do: Demand Precision
```
"Throws InvalidEmailError if email doesn't match /^[...regex]/"
"Returns 400 with body {error: 'INVALID_EMAIL', message: '...'}"
"Returns {user: User, token: string} on success"
```

---

## Quick Reference

| Situation | Prompt Starter |
|-----------|----------------|
| New feature | "Spec this before coding..." |
| API design | "Design the API contract for..." |
| Algorithm | "Specify the algorithm for..." |
| Refactoring | "Spec the target state for..." |
| Review | "What's missing from this spec?" |

---

> "The longer you let AI add upon its code without inspecting it and ensuring 
> its modularity, the bigger the effort will be to reinstitute some sort of 
> modular sanity."
> — Chapter 14, Vibe Coding

**A good spec now prevents "eldritch horrors" later.**
