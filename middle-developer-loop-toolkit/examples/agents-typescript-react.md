# AGENTS.md - TypeScript React Project Example

This is a filled-in example of AGENTS.md for a TypeScript React application with a Node.js backend.

---

## NEVER Do

### Security
- Never put API keys, secrets, or credentials in code or version control
- Never use `dangerouslySetInnerHTML` without sanitization
- Never disable TypeScript strict mode
- Never commit `.env` files (use `.env.example` for templates)

### Code Quality
- Never use `any` type — use proper types or `unknown` with type guards
- Never use `var` — use `const` by default, `let` when reassignment needed
- Never leave `console.log` in production code (use our logger)
- Never use `==` — always use `===`
- Never ignore Promise rejections — always handle or propagate errors

### Process
- Never commit directly to `main` — always use feature branches
- Never merge without passing CI
- Never skip the PR review process

---

## ALWAYS Do

### Before Coding
- Always run `npm install` if package.json changed
- Always check existing components in `src/components/` before creating new ones
- Always read the related test file before modifying code

### During Coding
- Always use TypeScript strict mode (already configured)
- Always use named exports, not default exports
- Always handle loading and error states in components
- Always use our custom hooks from `src/hooks/`
- Always use the `ErrorBoundary` component for error handling

### After Coding
- Always run `npm run typecheck` before committing
- Always run `npm test` before pushing
- Always run `npm run lint:fix` to auto-fix issues

---

## Project Conventions

### File Organization
```
src/
├── components/          # React components (PascalCase)
│   └── UserProfile/
│       ├── UserProfile.tsx
│       ├── UserProfile.test.tsx
│       └── index.ts
├── hooks/               # Custom hooks (camelCase, use* prefix)
├── services/            # API calls (camelCase)
├── types/               # TypeScript types (PascalCase)
├── utils/               # Utility functions (camelCase)
└── pages/               # Route pages (PascalCase)
```

### Naming Conventions
- Components: `PascalCase.tsx` (e.g., `UserProfile.tsx`)
- Hooks: `useCamelCase.ts` (e.g., `useAuth.ts`)
- Utils: `camelCase.ts` (e.g., `formatDate.ts`)
- Types: `PascalCase.ts` (e.g., `User.ts`)
- Tests: `*.test.tsx` or `*.test.ts`
- Constants: `SCREAMING_SNAKE_CASE`

### Component Structure
```typescript
// 1. Imports
import { useState } from 'react';
import type { User } from '@/types/User';

// 2. Types (if component-specific)
interface UserCardProps {
  user: User;
  onSelect: (id: string) => void;
}

// 3. Component
export function UserCard({ user, onSelect }: UserCardProps) {
  // hooks first
  const [isLoading, setIsLoading] = useState(false);

  // handlers
  const handleClick = () => {
    onSelect(user.id);
  };

  // render
  return (/* ... */);
}
```

### API Calls
- Always use services from `src/services/`
- Always use React Query for server state
- Never call APIs directly in components

---

## Build Commands

```bash
# Development
npm run dev              # Start dev server (port 3000)

# Testing
npm test                 # Run all tests
npm test -- --watch      # Watch mode
npm test -- UserProfile  # Run specific test

# Quality
npm run lint             # Check linting
npm run lint:fix         # Auto-fix lint issues
npm run typecheck        # TypeScript check

# Build
npm run build            # Production build
npm run preview          # Preview production build
```

---

## Key Files

```
# Configuration
package.json             # Dependencies and scripts
tsconfig.json            # TypeScript config (strict mode)
vite.config.ts           # Vite bundler config
.env.example             # Required environment variables

# Entry Points
src/main.tsx             # Application entry
src/App.tsx              # Root component
src/routes.tsx           # Route definitions
```

---

## Notes From Past Sessions

- The `useAuth` hook handles all authentication state — don't create parallel auth logic
- API error responses follow the format `{ error: string, code: number }`
- The `DataTable` component already handles pagination — use props, don't reimplement
- React Query cache time is set to 5 minutes — adjust per-query if needed

---

*Last updated: 2024-01-15*
*Stack: React 18, TypeScript 5, Vite, React Query, Tailwind CSS*
