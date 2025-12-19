# AGENTS.md - Project Golden Rules
<!-- Copy this template to your project root and customize -->

## About This File
This file contains rules that are injected into every AI coding session. Keep it focused on your "golden rules" - what should ALWAYS be done and what should NEVER be done.

> ⚠️ **Remember**: The longer this file, the less likely AI will follow everything. Be selective and prioritize.

---

## 🚫 NEVER Do (Hard Rules)

### Security
- Never put API keys, secrets, or credentials in code or version control
- Never use wildcard imports in production code
- Never disable security features without explicit approval
- Never commit sensitive data even in comments

### Code Quality
- Never use global variables
- Never leave debug/print statements in committed code
- Never use `any` type in TypeScript (use proper types)
- Never catch exceptions and ignore them silently
- Never commit code with TODO comments that reference security issues

### Process
- Never commit directly to main/master branch
- Never force push to shared branches
- Never delete tests to make the build pass
- Never skip running the test suite

---

## ✅ ALWAYS Do (Mandatory Practices)

### Before Coding
- Always read existing code in the area you're modifying
- Always check for existing utilities before writing new ones
- Always understand the existing patterns in the codebase

### During Coding
- Always use the project's established patterns and conventions
- Always handle errors explicitly (no silent failures)
- Always use meaningful variable and function names
- Always write self-documenting code (comments for "why", not "what")

### After Coding
- Always run the full test suite before claiming success
- Always verify your changes work as expected
- Always clean up temporary files and debug code
- Always update documentation if behavior changes

---

## 📋 Project-Specific Conventions

### Language/Framework Rules
<!-- Customize for your stack -->
```
# Example for a Node.js/TypeScript project:
- Use async/await, not callbacks
- Use named exports, not default exports
- Use strict mode always
- Prefer const over let, never use var
```

### File Organization
<!-- Define your project structure -->
```
# Example:
- Components go in src/components/
- Utilities go in src/utils/
- Tests go adjacent to source files (*.test.ts)
- Types go in src/types/
```

### Naming Conventions
<!-- Be specific -->
```
# Example:
- Components: PascalCase (UserProfile.tsx)
- Utilities: camelCase (formatDate.ts)
- Constants: SCREAMING_SNAKE_CASE
- Test files: *.test.ts or *.spec.ts
```

### Testing Requirements
```
# Example:
- All public functions must have tests
- Use describe/it pattern for test structure
- Mock external dependencies
- Minimum coverage: 80%
```

---

## 🔧 Environment & Tools

### Build Commands
```bash
# Build
npm run build

# Test
npm test

# Lint
npm run lint

# Type check
npm run typecheck
```

### Key Files to Know
```
# Configuration
- package.json - dependencies and scripts
- tsconfig.json - TypeScript config
- .env.example - required environment variables

# Entry Points
- src/index.ts - main entry
- src/app.ts - application setup
```

---

## ⚡ Quick Reference

### When You Get Stuck
1. Re-read this file
2. Check existing implementations for patterns
3. Ask for clarification rather than guessing
4. If unsure, implement the simplest solution first

### When Making Changes
1. Small, focused changes
2. One logical change per commit
3. Test before and after
4. Verify nothing else broke

### When Tests Fail
1. Don't disable or delete the test
2. Understand why it's failing
3. Fix the code, not the test (unless test is wrong)
4. Run full suite after fix

---

## 📝 Notes From Past Sessions

<!-- Add learnings from past AI sessions here -->
<!-- Example:
- The payment module uses a specific retry pattern - check src/utils/retry.ts
- Database migrations must be backwards compatible
- The config system has nested objects - don't flatten them
-->

---

## 🔄 Session Transition Checklist

Before ending a session:
- [ ] All tests passing
- [ ] No uncommitted changes (or intentionally staged)
- [ ] Document any work in progress
- [ ] Update this file if new rules discovered

When starting a session:
- [ ] Read this entire file
- [ ] Check current git status
- [ ] Review recent commits for context
- [ ] Confirm understanding of the current task

---

*Last updated: [DATE]*
*Version: 1.0*
