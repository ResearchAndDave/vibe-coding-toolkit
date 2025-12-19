# AI Collaboration Tips
## Learn While Watching & Help AI Navigate

---

## Learn While Watching

One surprising benefit of vibe coding: **You become a better developer** just by paying attention.

From Chapter 14:
> "You might be thinking, 'Ugh, what a chore to have to babysit and monitor coding agents!' However, it's not only unexpectedly fun, but we've found that there's a surprising and significant benefit: You learn a ton of interesting things that make you a better developer, without having to try."

### Real Examples from the Authors

**Steve discovered `gradle projects`**:
> "Steve first ran into this when observing AI use a Gradle command he'd never seen... Steve wishes he'd known this command a decade ago."

**Gene discovered `bash wait`**:
> "Gene was blown away to learn that Bash has a wait command, which allows running multiple tasks in parallel... Gene learned the Bourne shell nearly forty years ago, before Bash was invented, and was so excited about this discovery that he texted Steve."

### What to Watch For

Pay attention when AI:

| AI Does This | You Might Learn |
|--------------|-----------------|
| Uses unfamiliar command | New tool/technique |
| Takes unexpected approach | Alternative patterns |
| Chains tools together | Workflow optimizations |
| Handles edge case | Defensive programming |
| Structures code | Design patterns |
| Writes tests | Testing strategies |

### Learning Prompts

Ask AI to explain what it's doing:

```
Before you make changes, explain your approach:
- What technique are you using?
- Why this approach over alternatives?
- What's the tradeoff?
```

```
That command you just used - I've never seen that.
Explain what it does and when I should use it.
```

```
Show me 3 different ways to accomplish this.
Which would you recommend and why?
```

### Keep a Learning Log

Consider maintaining a file of discoveries:

```markdown
# Things I Learned from AI

## 2024-01-15
- `git bisect run` can automate finding bad commits
- Python's `functools.lru_cache` for memoization

## 2024-01-14  
- Bash `wait` command for parallel execution
- `jq` can modify JSON in-place
```

---

## Tell Your Sous Chef Where the Freezer Is

AI agents fumble around looking for things. Help them.

From Chapter 14:
> "When using coding agents, you'll see them fumbling around looking for things. You might find them searching the file system using grep to locate useful files. You'll see them struggle to figure out how to run the test suites. Agents frequently explore new spaces by fumbling around in the dark, looking in the wrong files and places at first."

### The Problem

AI is like **a new hire, but every day**:
- Doesn't know your project structure
- Doesn't know where important files are
- Doesn't know your test commands
- Doesn't know your conventions

And it re-learns this every session.

### Solutions

#### 1. Proactive Direction

When you see AI searching blindly:

```
Stop. The file you're looking for is at src/utils/auth.ts
```

```
The test command for this project is: npm run test:unit
```

```
All API handlers are in server/routes/, not in lib/
```

#### 2. Add to AGENTS.md

Create a project navigation guide:

```markdown
# Project Navigation

## Key Locations
- API handlers: `server/routes/`
- Database models: `server/models/`
- Frontend components: `client/components/`
- Tests: `__tests__/` (mirrors src structure)
- Configuration: `config/`

## Commands
- Run tests: `npm test`
- Run single test: `npm test -- --grep "test name"`
- Start dev server: `npm run dev`
- Build: `npm run build`

## Important Files
- Main entry: `src/index.ts`
- Database connection: `src/db/connection.ts`
- Auth middleware: `src/middleware/auth.ts`
- Environment config: `.env.example`
```

#### 3. Restructure for AI

Sometimes the best fix is making your project more navigable:

From Chapter 14:
> "Steve's game used a nonstandard Gradle project layout. It kept confusing his AI partners, so Steve finally gave up and restructured his project, renaming each module to use the standard layout. This saved time on almost every single session with AI."

Consider:
- Standard directory layouts
- Predictable naming conventions
- Clear separation of concerns
- Well-named files and functions

#### 4. Session Startup Prompt

Start each session with context:

```
I'm working on [PROJECT]. Key info:
- Tests: `pytest tests/`
- The bug is in `src/auth/token.py`
- We use SQLAlchemy for database
- API docs are in `docs/api.md`
```

---

## Put Your Sous Chef on Cleanup Duty

From Chapter 14:
> "We've found that successful vibe coders develop a new reflex: The moment they encounter an issue, they delegate it to their AI partner. This simple shift in tone can become joyful."

### The New Standard

Old mindset: "I'll add that bug to the backlog"
New mindset: "Hey AI, fix this bug right now"

> "Don't let your bugs age like milk. In vibe coding, fresh bugs are the only acceptable bugs—because they won't stay around long enough to spoil."

### What to Delegate Immediately

- [ ] Small bugs (fix faster than ticketing)
- [ ] Code cleanup tasks
- [ ] Documentation updates
- [ ] Test improvements
- [ ] Formatting inconsistencies
- [ ] TODO comments that can be addressed
- [ ] Minor refactoring

### Delegation Prompts

```
I just noticed [issue]. Fix it now before we continue.
```

```
While I review this code, clean up:
- Remove unused imports
- Fix any linter warnings
- Add missing type annotations
```

```
This function is messy. Refactor it for clarity 
while maintaining the same behavior. Show me the tests first.
```

---

## Quick Reference

### Before Starting Work
```
Here's what you need to know about this project:
[Key file locations]
[Test commands]
[Current task context]
```

### When AI Is Lost
```
Stop searching. The file is at [path].
The command you need is [command].
```

### When You Learn Something
```
That's interesting - explain that technique more.
When would I use this vs [alternative]?
```

### For Immediate Cleanup
```
Fix this now: [issue description]
```

---

## Key Insight

> "Yes, it's a bit like providing memory care for an elderly LLM, but it can save you time and tokens (i.e., money)—if you care—by keeping it from re-researching things over and over."

The investment in helping AI navigate pays off across every session.

---

*Based on Chapter 14: The Inner Developer Loop from "Vibe Coding" by Gene Kim and Steve Yegge*
