# When to Take Back the Wheel
## Knowing When to Step In During AI-Assisted Coding

---

## The Core Insight

From Chapter 14:
> "All software project tasks have a last mile that requires human insight and oversight. Every software task handled by AI must be 'completed' by a human in that last mile, whether AI finished the task or not."

AI is powerful but not infallible. Knowing when to intervene is a crucial vibe coding skill.

---

## Signs You Need to Take Control

### Immediate Red Flags 🚩

| Sign | What's Happening | Action |
|------|------------------|--------|
| AI repeating same approach | Stuck in a loop | Stop and redirect |
| Adding more and more logging | Context window filling | Clear logs, try debugger |
| "Let me try a different approach" (3rd+ time) | Flailing | Take over |
| Increasingly complex "fixes" | Making it worse | Roll back |
| Contradicting earlier statements | Context saturation | New session |
| Ignoring your instructions | Lost focus | Reassert control |

### The Slot Machine Problem

From Chapter 14:
> "AI can be like a slot machine with infinite upsides and nearly infinite downsides."

**When you're winning**: AI generates great code, fixes bugs quickly, makes progress
**When you're losing**: Each "fix" makes things worse, complexity explodes, time disappears

**Key insight**: Know when to walk away from the slot machine.

---

## The Last Mile

Every AI task requires human completion. The question is how long that last mile is.

```
┌─────────────────────────────────────────────────────┐
│                  THE LAST MILE                       │
│                                                      │
│  AI does 95% ──────────────────────────┐            │
│                                         │ You: 5%   │
│  AI does 70% ───────────────────┐       │           │
│                                  │      │ You: 30%  │
│  AI does 30% ────────┐           │      │           │
│                      │           │      │ You: 70%  │
│  ════════════════════╧═══════════╧══════╧═══════════│
│  START                                        DONE   │
└─────────────────────────────────────────────────────┘
```

**Sometimes the last mile is short**: Quick review, minor fix, done.
**Sometimes the last mile is long**: You finish the implementation yourself.

---

## Three Strategies for Taking Back Control

### Strategy 1: Methodical Debugging (Gene's Approach)

When AI keeps going down wrong paths:

1. **Stop AI completely**
2. **Document the scenarios yourself**
   - What works?
   - What fails?
   - What are the exact symptoms?
3. **Direct AI precisely**
   ```
   Put logging statements at EXACTLY these locations:
   - Line 42 in auth.ts (before token check)
   - Line 67 in auth.ts (after token validation)
   Show me the variable values at each point.
   ```
4. **Analyze the output yourself**
5. **Tell AI what you found and what to fix**

### Strategy 2: Use the Debugger (Steve's Approach)

When logging isn't cutting it:

1. **Clear all the logging cruft**
   ```
   Remove all the debug print statements you added.
   ```

2. **Set up a debugger session**
   ```
   Set a breakpoint at [file]:[line] and run the tests.
   ```

3. **Step through yourself** (or have AI operate debugger via MCP)

4. **Observe actual execution flow**
   - What values do variables have?
   - What path does execution take?
   - Where does it diverge from expected?

**Pro tip**: Stepping through AI-generated code often reveals inefficiencies (like calling an API repeatedly when once would do).

### Strategy 3: Start Fresh

When AI is stuck in a bad line of thinking:

1. **Recognize the pattern**
   - Same approaches repeatedly failing
   - 20+ minutes without progress
   - Increasingly convoluted solutions

2. **Clear the slate**
   ```
   Okay, this isn't working. Let's start over.
   Show me 5 completely different ways to accomplish [goal]:
   - Approach A: [specific technique]
   - Approach B: [different technique]
   - Approach C: [library-based]
   - Approach D: [simple/naive]
   - Approach E: [whatever you think is best]
   ```

3. **Try fresh approaches**
   - Often, what failed 10 times in one approach works first try in another

---

## Decision Matrix

| Situation | Best Strategy |
|-----------|---------------|
| AI flailing on a bug | Strategy 1: Methodical |
| Need to see actual execution | Strategy 2: Debugger |
| Conceptually stuck | Strategy 3: Start Fresh |
| Context window saturated | Strategy 3: Start Fresh |
| Logging flooding context | Strategy 2: Debugger |
| Don't understand the code | Strategy 2: Debugger |
| Know the solution, AI doesn't | Strategy 1: Direct it |

---

## When to Just Do It Yourself

Sometimes the fastest path is manual work:

- [ ] **Simple fixes**: Faster to type than explain
- [ ] **Obvious bugs**: You can see the problem immediately
- [ ] **Domain knowledge**: You know something AI doesn't
- [ ] **Small remaining work**: 10 minutes manual vs 30 minutes AI wrangling

**The goal is shipping, not AI purity.**

---

## Keeping AI Productive (When You Take Over)

Don't waste AI while you're debugging. Give it useful work:

```
While I debug this issue, please:
1. Review [other file] for similar problems
2. Write additional test cases for [feature]
3. Document what we've tried so far
4. Check for edge cases in [component]
```

---

## Recovery Commands

```bash
# When you need to take over
checkpoint save "Before taking manual control"

# After you fix it
checkpoint save "Manual fix for [issue]"

# If AI made a mess
checkpoint recover [last-good-commit]
```

---

## Warning Signs Checklist

Before each AI response, ask yourself:

- [ ] Is AI making forward progress?
- [ ] Does the approach make sense?
- [ ] Is complexity increasing without benefit?
- [ ] Is context window filling with noise?
- [ ] Am I understanding what AI is doing?

**If 2+ boxes unchecked, consider taking control.**

---

## Key Quotes from Chapter 14

> "Know when to take the whisk back: If AI is fumbling or stuck in a loop, step in. Your human insight is often the quickest way to get unstuck or walk that crucial last mile."

> "As your collaboration with AI deepens, you'll develop an intuition for when to let it explore solutions and when to take manual control. This judgment is part of the art of vibe coding."

> "Until future tools arrive that can handle more of these challenges, curating your debugging skills and problem-solving techniques remains essential for effective vibe coding."

---

*Based on Chapter 14: The Inner Developer Loop from "Vibe Coding" by Gene Kim and Steve Yegge*
