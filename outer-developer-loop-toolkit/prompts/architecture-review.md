# Architecture Review Prompts
<!-- Strategic code reviews for long-term health -->

## Overview

These prompts help you conduct architecture-level reviews, focusing on long-term health rather than line-by-line correctness.

---

## Module Coupling Analysis

### Find Coupling Issues
```
Analyze this codebase for coupling issues:

[Describe or provide file structure]

For each module, identify:
1. What other modules it depends on
2. What modules depend on it
3. Circular dependencies
4. Unexpectedly tight coupling
5. Modules that should be independent but aren't

Present as a dependency graph and highlight problems.
```

### Coupling Health Check
```
Review the coupling between [Module A] and [Module B]:

1. How many imports cross the boundary?
2. What types of dependencies exist?
3. Could these modules be developed independently?
4. Could one be swapped without affecting the other?
5. What would it take to decouple them?
```

---

## API Contract Review

### API Stability Check
```
Review this module's public API for stability:

[Module or file]

Check:
1. Are exports clearly defined?
2. Are function signatures stable?
3. Are there any breaking changes from [previous version]?
4. Could internal changes leak to consumers?
5. What's the upgrade path for consumers?
```

### Backward Compatibility
```
Compare these two versions:

[Old API]
[New API]

Identify:
1. Any removed functions/endpoints
2. Any changed signatures
3. Any changed return types
4. Any changed behavior
5. Breaking vs non-breaking changes

Rate compatibility: Fully compatible / Minor breaks / Major breaks
```

---

## Code Bloat Analysis

### Size Review
```
Analyze this codebase for bloat:

[Description or structure]

Check for:
1. Files over 500 lines
2. Functions over 50 lines
3. Classes with too many methods
4. Duplicate code
5. Dead code
6. Over-engineered abstractions

Prioritize what to address first.
```

### Dependency Audit
```
Review the dependencies in this project:

[Package file or list]

For each dependency:
1. Is it necessary?
2. Could we use a smaller alternative?
3. Could stdlib handle this?
4. Is it actively maintained?
5. Any security concerns?

Recommend which to keep, replace, or remove.
```

---

## Architecture Pattern Review

### Pattern Consistency
```
Review this codebase for pattern consistency:

[Description]

Check if:
1. Similar problems are solved similarly
2. Naming conventions are consistent
3. File organization is predictable
4. Error handling is consistent
5. Logging/telemetry is consistent

List inconsistencies and recommend standardization.
```

### Architecture Fitness
```
Evaluate if this architecture fits the requirements:

Requirements:
[List requirements]

Current architecture:
[Description]

Assess:
1. Does it meet functional requirements?
2. Does it meet non-functional requirements?
3. Is it over-engineered for the need?
4. Is it under-engineered?
5. What would you change?
```

---

## Security Architecture Review

### Security Posture
```
Review this architecture for security:

[Description]

Check:
1. Authentication approach
2. Authorization boundaries
3. Data protection (at rest, in transit)
4. Input validation points
5. Secrets management
6. Attack surface

Rate overall security posture and recommend improvements.
```

### Threat Model
```
Create a threat model for this system:

[System description]

Identify:
1. Assets (what needs protecting)
2. Threats (what could go wrong)
3. Vulnerabilities (how they'd be exploited)
4. Mitigations (current and recommended)

Prioritize by risk = likelihood × impact.
```

---

## Scalability Review

### Scaling Assessment
```
Assess this architecture's scalability:

[Description]
Current load: [metrics]
Target load: [metrics]

Evaluate:
1. Horizontal scaling capability
2. Bottleneck identification
3. Database scaling
4. Caching strategy
5. Async processing capability

What changes needed for target load?
```

---

## Modularity Assessment

### Module Boundaries
```
Evaluate the module boundaries in this codebase:

[Structure]

For each boundary:
1. Is responsibility clear?
2. Is the interface minimal?
3. Are internals hidden?
4. Could it be tested in isolation?
5. Could it be replaced?

Score: Well-defined / Fuzzy / Tangled
```

### Extraction Candidates
```
Identify candidates for extraction into separate modules:

[Codebase description]

Look for:
1. Cohesive groups of functionality
2. Code with different change rates
3. Code with different owners
4. Potential reusable libraries
5. Clear separation opportunities

For each candidate, describe the extraction plan.
```

---

## Technical Debt Assessment

### Debt Inventory
```
Catalog the technical debt in this codebase:

[Description]

For each item:
1. What is it?
2. Why is it debt?
3. What's the impact?
4. What would fix it?
5. Effort estimate

Prioritize by: impact / effort ratio
```

### Refactoring Priority
```
Given these technical debt items:

[List items]

Recommend a prioritized refactoring plan:
1. What to tackle first and why
2. What can wait
3. What to accept as permanent
4. Dependencies between items
5. Time estimates
```

---

## AI Manufacturing Readiness

### AI-Friendly Assessment
```
Assess how well this codebase works with AI assistants:

[Structure]

Check:
1. File sizes (AI context limits)
2. Conventional structure
3. Clear documentation
4. Explicit over magic
5. Standard patterns
6. Technology choices

Score each dimension and recommend improvements.
```

---

## Review Templates

### Weekly Architecture Check
```
Quick architecture health check:

1. Any new coupling introduced this week?
2. Any module boundaries violated?
3. Any unexpected file growth?
4. Any new dependencies added?
5. Any API changes?

Flag anything concerning.
```

### Pre-Release Review
```
Architecture review before release:

1. All API contracts honored?
2. No regression in modularity?
3. Performance acceptable?
4. Security posture maintained?
5. Documentation current?

Go / No-Go recommendation.
```

---

## Follow-Up Actions

After architecture review, create actionable items:

```markdown
## Architecture Review Actions

### Critical (Do Now)
- [ ] [Issue]: [Fix]

### Important (This Sprint)
- [ ] [Issue]: [Fix]

### Improve (Backlog)
- [ ] [Issue]: [Fix]

### Accept (Document as Known Debt)
- [ ] [Issue]: [Reason to accept]
```

---

*"Effective outer-loop management is about building resilient systems, 
championing smarter processes, and leveraging AI to achieve FAAFO."*
