# AI-Friendly Workspace Layout
<!-- Design for AI Manufacturing: Structure your project to work WITH AI -->

## Overview

AI assistants work best with codebases that follow conventions, have clear structure, and avoid "magic." This template helps you organize projects for optimal AI collaboration.

> "You shouldn't code against the grain of your AI assistants."
> — Chapter 15, Vibe Coding

---

## Recommended Project Structure

```
project-root/
├── README.md                    # Project overview (AI reads this first)
├── AGENTS.md                    # Golden rules for AI
├── ARCHITECTURE.md              # System design overview
├── docs/
│   ├── api/                     # API documentation
│   ├── guides/                  # How-to guides
│   └── decisions/               # Architecture Decision Records
├── src/
│   ├── [module-a]/              # Clear module boundaries
│   │   ├── index.ts             # Public interface
│   │   ├── types.ts             # Type definitions
│   │   ├── [feature].ts         # Implementation
│   │   └── [feature].test.ts    # Co-located tests
│   ├── [module-b]/
│   └── shared/                  # Shared utilities
│       ├── utils/
│       └── types/
├── tests/
│   ├── integration/             # Integration tests
│   └── e2e/                     # End-to-end tests
├── scripts/                     # Build/deploy scripts
├── config/                      # Configuration files
└── .github/                     # CI/CD workflows
```

---

## Principles for AI-Friendly Design

### 1. Conventional Structure
- Use standard layouts for your language/framework
- Avoid custom conventions AI hasn't seen
- Follow community best practices

**Do**: Standard Next.js/Rails/Django structure
**Don't**: Novel directory organization

### 2. Reasonable File Sizes
- Keep files under 500 lines when possible
- Split large files when AI struggles to read them whole
- One concept per file

**Warning Sign**: AI says "file too large" or greps instead of reading

### 3. Clear Module Boundaries
- Explicit public interfaces (index.ts, __init__.py)
- Minimize cross-module dependencies
- Document module responsibilities

```
# Good: Clear boundary
src/auth/
├── index.ts        # Exports public API
├── types.ts        # Auth types
├── service.ts      # Internal implementation
└── utils.ts        # Internal helpers

# Bad: Fuzzy boundary
src/
├── auth.ts
├── authHelpers.ts
├── authTypes.ts
├── userAuth.ts
└── loginAuth.ts
```

### 4. Consistent Naming
- Predictable file names
- Consistent casing (camelCase, snake_case, etc.)
- Meaningful names over abbreviations

```
# Good
UserService.ts
user.service.ts
user_service.py

# Bad
usrSvc.ts
US.ts
userservice.ts
```

### 5. Co-located Tests
- Tests next to source files
- Easy for AI to find related tests
- Clear test file naming

```
src/
├── user/
│   ├── user.service.ts
│   └── user.service.test.ts    # Co-located
```

### 6. Explicit Over Magic
- Prefer explicit imports over auto-loading
- Avoid "magic" conventions AI might not understand
- Document non-obvious behavior

```typescript
// Good: Explicit
import { UserService } from './user/user.service';

// Bad: Magic auto-import
// (framework magically loads all services)
```

### 7. Popular Over Exotic
- Choose widely-used languages/frameworks
- More training data = better AI assistance
- Save exotic tools for where they're essential

**High AI Support**: Python, TypeScript, JavaScript, Go, Java, Rust
**Lower AI Support**: Erlang, Elixir, Haskell, Clojure (though Claude handles these well)

---

## File Organization Guidelines

### Source Files
```
[module]/
├── index.ts           # Public exports only
├── types.ts           # Type definitions
├── constants.ts       # Module constants
├── [feature].ts       # Feature implementation
├── [feature].test.ts  # Feature tests
└── utils.ts           # Internal utilities
```

### Configuration Files
```
config/
├── default.ts         # Default configuration
├── development.ts     # Dev overrides
├── production.ts      # Prod overrides
└── test.ts           # Test overrides
```

### Documentation
```
docs/
├── README.md          # Docs overview
├── api/
│   └── [endpoint].md  # API endpoint docs
├── guides/
│   └── [topic].md     # How-to guides
└── decisions/
    └── [NNN]-[title].md  # ADRs
```

---

## What to Document for AI

### README.md (Project Root)
```markdown
# Project Name

## Overview
[What this project does - 2-3 sentences]

## Quick Start
[How to run locally]

## Architecture
[High-level system description]

## Key Directories
- `src/` - Source code
- `tests/` - Test files
- `docs/` - Documentation

## Development
[Build, test, deploy commands]
```

### ARCHITECTURE.md
```markdown
# Architecture

## System Overview
[Diagram or description]

## Key Components
- **Component A**: [Purpose]
- **Component B**: [Purpose]

## Data Flow
[How data moves through the system]

## Key Decisions
[Link to ADRs]

## Boundaries
[What can/cannot be modified independently]
```

### Module README
```markdown
# Module Name

## Purpose
[What this module does]

## Public API
[What's exported]

## Dependencies
[What this module requires]

## Usage
[Example code]
```

---

## Anti-Patterns to Avoid

### ❌ Giant Files
```
src/
└── app.ts  # 5000 lines, does everything
```
**Fix**: Split by responsibility

### ❌ Deep Nesting
```
src/a/b/c/d/e/f/g/file.ts
```
**Fix**: Flatten to 2-3 levels

### ❌ Inconsistent Patterns
```
src/
├── UserService.ts      # PascalCase
├── product_service.ts  # snake_case
└── orderSvc.ts         # abbreviated
```
**Fix**: Pick one convention

### ❌ Hidden Dependencies
```typescript
// File magically depends on global state
export function getUser() {
  return globalDatabase.users.find(currentUserId);
}
```
**Fix**: Explicit parameters

### ❌ Circular Dependencies
```
auth/ imports user/
user/ imports auth/
```
**Fix**: Extract shared code or restructure

---

## Migration Checklist

When restructuring for AI:

- [ ] Files under 500 lines
- [ ] Clear module boundaries
- [ ] Consistent naming conventions
- [ ] Co-located tests
- [ ] Updated documentation
- [ ] Explicit imports/exports
- [ ] No circular dependencies
- [ ] Standard project layout

---

## Quick Wins

1. **Add README.md** to every module
2. **Split largest file** into smaller pieces
3. **Add AGENTS.md** with golden rules
4. **Document public interfaces**
5. **Rename inconsistent files**

---

*Based on "Design for AI Manufacturing" from Chapter 15, Vibe Coding*
