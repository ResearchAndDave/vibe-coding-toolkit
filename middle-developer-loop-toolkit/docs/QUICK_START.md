# Quick Start Guide

Get productive with the Middle Developer Loop Toolkit in 15 minutes.

## Stage 1: Minimal Setup (5 minutes)

### Step 1: Copy AGENTS.md to Your Project

```bash
cp templates/AGENTS.md /path/to/your-project/
```

### Step 2: Customize the Golden Rules

Open `AGENTS.md` and update these sections:

**NEVER Do** — Add your project's forbidden patterns:
```markdown
## NEVER Do
- Never use `var` in JavaScript (use `const`/`let`)
- Never commit to main directly
- Never use raw SQL queries (use the ORM)
```

**ALWAYS Do** — Add your project's required practices:
```markdown
## ALWAYS Do
- Always run `npm test` before committing
- Always use TypeScript strict mode
- Always handle errors with our ErrorHandler class
```

**Project Conventions** — Add your stack-specific rules:
```markdown
## Project Conventions
- Components: PascalCase in src/components/
- Tests: Co-located as *.test.ts
- API routes: kebab-case
```

### Step 3: Reference at Session Start

Begin every AI session with:
```
Read AGENTS.md and confirm you understand the project rules.
```

**You're now using the toolkit.** Continue to Stage 2 when you need session continuity.

---

## Stage 2: Session Continuity (5 minutes)

### Step 1: Copy SESSION_HANDOFF.md

```bash
cp templates/SESSION_HANDOFF.md /path/to/your-project/
```

Or use the lite version for simpler projects:
```bash
cp templates-lite/SESSION_HANDOFF_LITE.md /path/to/your-project/SESSION_HANDOFF.md
```

### Step 2: End-of-Session Ritual

Before ending a session, ask your AI:
```
We need to wrap up. Please update SESSION_HANDOFF.md with:
1. What we accomplished
2. Current code state (compiles? tests pass?)
3. What to do next
4. Any important context
```

### Step 3: Start-of-Session Ritual

When starting a new session:
```
Read AGENTS.md and SESSION_HANDOFF.md.
Summarize where we left off and what's next.
```

---

## Stage 3: Multi-Agent Work (5 minutes)

Only needed if running 2+ AI agents simultaneously.

### Step 1: Copy AGENT_STATUS.md

```bash
cp templates/AGENT_STATUS.md /path/to/your-project/
```

### Step 2: Allocate Resources

Before starting agents, decide:

| Resource | Agent A | Agent B |
|----------|---------|---------|
| Branch | feature-auth | feature-cart |
| Ports | 3000-3099 | 3100-3199 |
| Files | src/auth/* | src/cart/* |

### Step 3: Brief Each Agent

Start each agent with clear boundaries:
```
You are Agent A working on authentication.
- Your branch: feature-auth
- Your files: src/auth/*
- DO NOT touch: src/cart/*, src/checkout/*
- Port range: 3000-3099

Read AGENTS.md for project rules.
```

### Step 4: Round-Robin Attention

Cycle between agents every 2-5 minutes:
1. Check Agent A progress
2. Check Agent B progress
3. Update AGENT_STATUS.md
4. Repeat

---

## Adoption Checklist

### Minimum (Solo, Simple Projects)
- [ ] AGENTS.md in project root
- [ ] Reference it at session start

### Standard (Solo, Multi-Session)
- [ ] AGENTS.md in project root
- [ ] SESSION_HANDOFF.md in project root
- [ ] End-of-session documentation ritual
- [ ] Start-of-session context loading

### Full (Multi-Agent Work)
- [ ] All of the above
- [ ] AGENT_STATUS.md for tracking
- [ ] Resource allocation plan
- [ ] Round-robin attention pattern

---

## Common First-Week Issues

### "AI keeps ignoring my rules"
- AGENTS.md is too long — trim to essentials
- Rules are too vague — be specific
- Not referencing it at session start

### "Sessions feel like starting over"
- SESSION_HANDOFF.md is incomplete — be more specific
- Not reviewing handoff at session start
- AI writing vague summaries — ask for specifics

### "Agents keep conflicting"
- Overlapping file ownership — stricter boundaries
- Same branch — use separate branches
- Port conflicts — allocate ranges

### "Context fills up fast"
- Loading too many files — be selective
- Verbose conversation — be concise
- Not compacting proactively — compact at 50%

---

## Next Steps

Once comfortable with basics:

1. **Run a workspace audit** — `checklists/workspace-audit.md`
2. **Use tracer bullets** for risky tech — `templates/TRACER_BULLET.md`
3. **Keep agents productive** — `prompts/keep-busy.md`
4. **Optimize your codebase** — `prompts/workspace-optimization.md`

---

## Tool-Specific Setup

See integration guides for your AI tool:
- [Claude Code](integrations/claude-code.md)
- [Cursor](integrations/cursor.md)
- [GitHub Copilot](integrations/github-copilot.md)
- [Gemini CLI](integrations/gemini-cli.md)
