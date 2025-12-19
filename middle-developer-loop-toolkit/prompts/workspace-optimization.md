# Workspace Optimization Prompts
<!-- Making your codebase AI-friendly through targeted refactoring -->

## Overview

These prompts help you refactor your codebase to work better with AI assistants. Use them after completing a workspace audit to address identified issues.

---

## File Size Reduction

### Split Large File
```
This file is too large ([X] lines) for effective AI collaboration.

[Paste file or path]

Please analyze this file and propose how to split it into smaller, 
focused modules. For each proposed module:
1. Name and purpose
2. What code moves there
3. Dependencies between new modules
4. Public interface

Don't implement yet - let's review the plan first.
```

### Extract Module
```
I want to extract [functionality] from [file] into its own module.

The code currently:
[Describe what it does]

Please:
1. Identify all related code to extract
2. Determine necessary interfaces
3. List dependencies
4. Propose the extraction plan

Show me the plan before implementing.
```

### Reduce God Class
```
This class/module does too much:

[Paste class or describe it]

Help me apply Single Responsibility Principle:
1. Identify distinct responsibilities
2. Propose how to split them
3. Define interfaces between new components
4. Plan the migration

Start with the analysis, not the implementation.
```

---

## Structure Improvements

### Standardize Layout
```
Our project structure doesn't follow standard conventions for [framework].

Current structure:
[Describe or show current layout]

Please:
1. Show the conventional structure for [framework]
2. Map our current files to the new structure
3. Identify files that need renaming/moving
4. Highlight any code changes needed after restructure

Provide a migration plan.
```

### Flatten Deep Nesting
```
We have deeply nested directories:

[Show problematic structure]

Help me flatten this to max 3 levels while maintaining organization:
1. Propose new structure
2. Map old paths to new paths
3. Identify import updates needed
4. Consider any breaking changes

Show the plan first.
```

### Add Module Boundaries
```
These files are loosely related but lack clear module structure:

[List files]

Help me organize them into proper modules:
1. Group by functionality
2. Create index files with public APIs
3. Make internal code private
4. Document each module's purpose

Propose the module structure.
```

---

## Naming Consistency

### Fix Naming Conventions
```
Our codebase has inconsistent naming:

Examples:
- [Example 1]
- [Example 2]
- [Example 3]

Our target convention is [camelCase/PascalCase/snake_case].

Please:
1. List all inconsistently named files
2. Provide the correct names
3. Identify code changes needed (imports, references)
4. Suggest order of changes to minimize breakage
```

### Rename for Clarity
```
These names are unclear or abbreviated:

[List problematic names]

For each, suggest a clearer name that:
- Describes purpose
- Follows our conventions
- Is not too long
- Is consistent with similar items

Provide old → new mapping.
```

---

## Module Decoupling

### Break Circular Dependencies
```
We have circular dependencies between these modules:

[Module A] ↔ [Module B]

Current dependencies:
[Describe what depends on what]

Help me break this cycle:
1. Identify what causes the cycle
2. Propose extraction to break it
3. Show the new dependency graph
4. Outline implementation steps
```

### Extract Shared Code
```
Multiple modules depend on the same internal code:

Modules: [List modules]
Shared code: [Describe shared code]

Help me extract this to a shared location:
1. What exactly should be extracted
2. Where should it live
3. What interface should it expose
4. How do existing modules update their imports
```

### Define Clear Interfaces
```
This module exposes too much of its internals:

[Module name/path]

Currently exports: [list exports]

Help me define a clean public interface:
1. What should be public
2. What should be internal
3. How to reorganize the code
4. Migration plan for existing callers
```

---

## Documentation Addition

### Generate README
```
This module needs documentation:

[Module path or paste code]

Please write a README.md covering:
1. Purpose - What does this module do?
2. Public API - What's exported and how to use it?
3. Dependencies - What does this require?
4. Examples - Show common usage patterns
5. Notes - Any gotchas or important context
```

### Document Architecture
```
Help me create an ARCHITECTURE.md for this project.

The project is: [Description]

Key components:
[List main components]

Please include:
1. System overview
2. Component descriptions
3. Data flow
4. Key design decisions
5. Module boundaries

Make it useful for AI assistants understanding the codebase.
```

### Create AGENTS.md
```
Help me create an AGENTS.md file for this project.

Project type: [Type]
Language: [Language]
Framework: [Framework]

Key conventions:
[Any known conventions]

Generate golden rules covering:
1. Things AI should ALWAYS do
2. Things AI should NEVER do
3. Project-specific conventions
4. File organization rules
5. Testing requirements
```

---

## Testing Organization

### Co-locate Tests
```
Our tests are in a separate directory from source:

Current:
src/
  user/
    service.ts
tests/
  user/
    service.test.ts

Help me co-locate tests with source:
1. Plan the file moves
2. Update any test configuration
3. Update imports
4. Ensure tests still run
```

### Add Missing Tests
```
This module lacks tests:

[Module path]

Current coverage: [X]%

Please:
1. Identify untested functions
2. Prioritize by importance/risk
3. Write tests for the top [N] items
4. Suggest additional test cases
```

---

## Explicit Dependencies

### Remove Magic
```
This code uses implicit/magic behavior:

[Describe or paste code]

Examples of magic:
- [Magic pattern 1]
- [Magic pattern 2]

Help me make this explicit:
1. Identify all implicit dependencies
2. Convert to explicit parameters/imports
3. Update all callers
4. Ensure behavior unchanged
```

### Inject Dependencies
```
This class/function has hidden dependencies:

[Paste code]

Help me convert to dependency injection:
1. Identify hidden dependencies
2. Convert to constructor/parameter injection
3. Create interfaces where appropriate
4. Update instantiation points
5. Show how to mock for tests
```

---

## Batch Operations

### Full Workspace Cleanup
```
I want to improve this codebase for AI collaboration.

Here are the issues from my audit:
[Paste audit results]

Please prioritize and create a phased plan:

Phase 1 (Quick wins):
- [Items that take < 1 hour]

Phase 2 (Medium effort):
- [Items that take 1-4 hours]

Phase 3 (Major work):
- [Items that take days]

For each item, briefly note what's involved.
```

---

## Post-Refactoring

### Verify Refactoring
```
I just completed this refactoring:

[Describe what was changed]

Please verify:
1. No functionality was lost
2. Tests still pass
3. No broken imports
4. No circular dependencies introduced
5. Documentation is updated
```

---

*Use these prompts after completing a Workspace Audit to systematically 
improve your codebase for AI collaboration.*
