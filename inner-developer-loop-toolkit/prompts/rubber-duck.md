# Rubber Duck Problem-Solving Prompts
<!-- Your AI as a thinking partner, not just a code generator -->

## Overview

Traditional "rubber ducking" means explaining your problem to an inanimate object to gain clarity. With AI, the duck talks back—asking relevant questions and highlighting blind spots.

> "Unlike a rubber duck, AI responds with relevant questions and quacks, 
> highlighting blind spots in your reasoning."
> — Chapter 14, Vibe Coding

---

## Key Principle

**Approach**:
```
"Let's think through this together..."
```

**Not**:
```
"Fix this for me."
```

This subtle shift transforms debugging dead-ends into productive explorations.

---

## Prompts by Situation

### When You're Stuck on a Bug

#### Basic Rubber Duck
```
I'm stuck on a bug and want to think through it with you. Let me explain what's happening:

**Expected behavior**: [What should happen]
**Actual behavior**: [What actually happens]
**What I've tried**: [Steps taken so far]

Don't fix it yet—first, help me understand what might be causing this by asking clarifying questions.
```

#### Systematic Bug Investigation
```
Let's debug this systematically together:

**The symptom**: [What's wrong]
**When it happens**: [Conditions]
**When it doesn't happen**: [Working conditions]

Walk me through questions that will help narrow down the root cause. Act like a senior engineer pair programming with me.
```

### When You Can't Understand Code

#### Code Comprehension
```
I'm trying to understand this code but it's confusing me:

[paste code]

Instead of explaining it all at once, let's go through it together:
1. What's the high-level purpose?
2. [Follow-up based on answer]

Walk me through your understanding and pause for my questions.
```

#### Legacy Code Archaeology
```
I need to understand this legacy code to modify it safely:

[paste code]

Help me understand:
- What was the original author trying to do?
- What assumptions are baked in?
- What would break if I changed [X]?

Think out loud as you analyze it.
```

### When You're Not Sure How to Approach Something

#### Architecture Discussion
```
I'm trying to figure out the best approach for [problem]. Let me share my constraints:

**Must have**: [Requirements]
**Nice to have**: [Preferences]
**Constraints**: [Limitations]

Let's explore options together. What approaches come to mind, and what are the trade-offs of each?
```

#### Design Decision
```
I'm torn between two approaches:

**Option A**: [Description]
**Option B**: [Description]

Help me think through this by asking about my priorities and constraints. Don't just pick one—help me understand which is better for MY situation.
```

### When Code Works But Feels Wrong

#### Code Smell Investigation
```
This code works, but something feels off about it:

[paste code]

Let's discuss:
- What specifically bothers me (or should)?
- Is this a real problem or just aesthetic?
- If it's a problem, what's the principle being violated?
- What would be better?
```

#### "Why Does This Work?"
```
This code works and I don't fully understand why:

[paste code]

Don't just explain it—help me understand by asking what parts I find confusing, then address those specifically.
```

### When You're About to Make a Big Decision

#### Pre-Mortem
```
I'm about to [big change/decision]. Before I do it, let's imagine it's 6 months from now and this decision caused problems.

What might have gone wrong? What could we do now to prevent those issues?
```

#### Sanity Check
```
I'm planning to [action]. Before I commit to this:

1. What am I not considering?
2. What are the risks?
3. What's my rollback plan?
4. Is there a simpler approach?

Challenge my thinking.
```

---

## Conversation Patterns

### The "Explain It To Me" Pattern
```
Explain [concept] to me, but stop after each main point and check if I have questions. Assume I'm smart but unfamiliar with this specific topic.
```

### The "What If" Pattern
```
Let's explore "what if" scenarios:
- What if [edge case]?
- What if [unexpected input]?
- What if [failure condition]?

For each, what would happen and is that acceptable?
```

### The "Walk Through" Pattern
```
Let's walk through the execution of this code step by step:

[paste code]

For the input [X], what happens at each step? Pause after each step so I can follow along.
```

### The "Teach Me" Pattern
```
I want to understand [concept] better. Instead of just explaining, teach me:
- Start with why it matters
- Give me a simple example
- Then build up complexity
- Check my understanding as we go
```

---

## Follow-Up Questions to Keep Handy

When AI gives an explanation or suggestion, dig deeper:

```
- "Why is that the case?"
- "What would happen if we didn't do that?"
- "Is there a simpler way?"
- "What am I still missing?"
- "What are the trade-offs?"
- "How would we test this?"
- "What could go wrong?"
- "Can you give me a concrete example?"
```

---

## Anti-Patterns to Avoid

### ❌ Don't: Just Ask for the Answer
```
"Fix this code"
"Why doesn't this work"
"What's wrong with this"
```

### ✅ Do: Engage in Dialogue
```
"Let's figure out together what's wrong with this..."
"I think the problem might be X, but let me explain my reasoning..."
"Walk me through what happens when..."
```

### ❌ Don't: Accept First Answer
```
AI: "The problem is X"
You: "OK, fix it"
```

### ✅ Do: Verify Understanding
```
AI: "The problem is X"
You: "Help me understand why X causes this symptom..."
```

---

## Templates for Common Situations

### Bug Report → Rubber Duck
```
I found a bug. Let me describe it and then let's investigate together:

**Steps to reproduce**:
1. 
2. 
3. 

**Expected**: 
**Actual**: 

What questions do you have that would help narrow down the cause?
```

### Code Review → Rubber Duck
```
I'm reviewing this code and want to think through it:

[paste code]

Let's go through it together:
- Does the logic make sense?
- Are there edge cases not handled?
- Is anything unclear or suspicious?

What stands out to you?
```

### Performance Issue → Rubber Duck
```
This code is slow and I need to figure out why:

[paste code]

Let's think through where time might be spent:
- What operations are O(n²) or worse?
- What might be called more than necessary?
- What might be blocking?

Help me form hypotheses before we jump to solutions.
```

### Integration Problem → Rubber Duck
```
These two pieces of code need to work together and they're not:

**Code A**: [description/snippet]
**Code B**: [description/snippet]

**What should happen**: 
**What actually happens**: 

Let's trace through the data flow together. Where might things be going wrong?
```

---

## The Power of Thinking Out Loud

From Chapter 14:
> "Maybe the reason this technique works is because humans, like AIs, think 
> better when forced to emit output tokens. The act of verbalizing forces us 
> to organize our thoughts and sometimes reveals assumptions or overlooked details."

When you explain your problem to AI:
1. You organize your own thoughts
2. AI highlights gaps in your reasoning  
3. The conversation reveals assumptions
4. Solutions often emerge naturally

---

## Quick Reference

| Situation | Opening Line |
|-----------|--------------|
| Bug | "Let's debug this together..." |
| Confusion | "Help me understand by walking through..." |
| Decision | "Let's explore the trade-offs..." |
| Code smell | "Something feels wrong, let's discuss..." |
| Before change | "Let's think through what could go wrong..." |

---

> "You'll get your best results by thinking of your talking duck as a pair 
> programming partner."
> — Chapter 14, Vibe Coding
