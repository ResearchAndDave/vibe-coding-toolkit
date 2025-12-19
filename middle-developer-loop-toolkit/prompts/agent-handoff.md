# Agent Handoff Prompts
<!-- Copy-paste prompts for session transitions -->

This file contains ready-to-use prompts for session handoffs. For the complete session transition procedure (checklists, timing, best practices), see `checklists/session-transitions.md`.

---

## Session Ending Prompts

### Standard Session End
```
We need to wrap up this session. Please create a handoff document:

## What We Accomplished
[List completed work]

## Current State
- Code compiles: Yes/No
- Tests pass: Yes/No
- Application runs: Yes/No
- Uncommitted changes: [List or "None"]

## Files Modified
[List files changed this session]

## Next Steps
1. [First priority]
2. [Second priority]
3. [Third priority]

## Important Context
[Key decisions, gotchas, anything the next session needs to know]

## To Resume
[Specific instructions for picking up]

Save this to SESSION_HANDOFF.md
```

### Quick Session End
```
Quick wrap-up needed. Write a brief handoff:

1. What's done
2. What's in progress
3. What's next
4. Any blockers

Save to SESSION_HANDOFF.md
```

### Emergency Session End
```
Need to stop immediately. Quick state dump:

1. What were we doing?
2. What's the current code state?
3. Anything uncommitted?
4. Where exactly did we stop?

I'll review and commit.
```

### Extended Break Handoff
```
I'll be away for [days/weeks]. Create a comprehensive handoff:

## Project Status
[Overall state of the project]

## Recent Work
[What's been done recently]

## Open Items
[Work in progress, known issues]

## Architecture Notes
[Anything important about current design]

## How to Continue
[Detailed instructions for resuming]

## Known Issues
[Bugs, tech debt, concerns]

## Contacts/Resources
[Anything external needed]

Save to SESSION_HANDOFF.md and update README if needed.
```

---

## Session Starting Prompts

### Standard Session Start
```
We're resuming work on [project]. Here's the context from last session:

[Paste SESSION_HANDOFF.md content]

Before we continue:
1. Confirm you understand the current state
2. Ask any clarifying questions
3. Review what we need to do next

Then we'll proceed with [first task].
```

### Cold Start (No Handoff)
```
I'm starting work on this project without recent context.

Project: [Name]
Location: [Path]

Please:
1. Read the README.md and AGENTS.md
2. Explore the project structure
3. Summarize what you understand
4. Identify any questions

Then we can discuss what I want to work on.
```

### Resuming After Days
```
Resuming work after [X] days. Here's the last handoff:

[Paste SESSION_HANDOFF.md]

Please:
1. Read the current code state
2. Verify the handoff is still accurate
3. Check if anything has changed
4. Confirm readiness to continue

My goal today is: [Goal]
```

---

## Multi-Agent Handoffs

### Agent-to-Agent Handoff
```
I'm handing work from Agent A to Agent B.

Agent A completed:
[Work done]

Current state:
[Code state, branch, etc.]

Agent B should:
[Next task]

Key context:
[Important information]

Files involved:
[List files]

Agent B: Confirm you understand and have any questions.
```

### Parallel Agent Coordination
```
We have multiple agents working. Current status:

Agent A: [Task] - [Status]
Agent B: [Task] - [Status]
Agent C: [Task] - [Status]

Coordination notes:
- [Any dependencies between agents]
- [Shared resources]
- [Merge plan]

You are Agent [X]. Your focus is [Task]. 
Do not modify [files owned by other agents].
```

### Agent Status Update
```
Provide a status update for AGENT_STATUS.md:

Agent: [Your designation]
Branch: [Current branch]
Task: [Current task]
Status: [Active/Waiting/Blocked/Complete]
Progress: [% or description]
Blockers: [Any blockers]
Next: [What you'll do next]
Notes: [Anything important]
```

---

## Context Compaction Prompts

### Pre-Compaction Summary
```
We're about to clear context. Before we do, document:

## Session Summary
[Everything accomplished]

## Current Work State
[Exact state of code]

## Decisions Made
[Important choices and rationale]

## Problems Encountered
[Issues and how they were resolved]

## For Next Session
[What needs to happen next, in order]

## Commands to Run
[Exact commands to verify and continue]

This will be our only memory of this session.
```

### Post-Compaction Resume
```
We just cleared context. Here's what we need to know:

[Paste pre-compaction summary]

Please:
1. Confirm you understand the state
2. Tell me what you think we should do next
3. Ask any clarifying questions

Then we'll continue with [task].
```

---

## Special Situations

### Picking Up Someone Else's Work
```
I'm picking up work from another developer/session.

Their notes say:
[Paste their handoff notes]

Current state:
[What I can observe]

Please:
1. Analyze the code state
2. Verify the notes are accurate
3. Identify any gaps in information
4. Suggest how to proceed

I want to [goal].
```

### Returning to Stale Project
```
I'm returning to a project I haven't touched in [weeks/months].

What I remember:
[What you recall]

Please:
1. Explore the current state
2. Read any documentation
3. Check git history for recent changes
4. Summarize what you find
5. Identify what needs attention

Help me get re-oriented.
```

### Recovering from Interrupted Session
```
My last session ended unexpectedly without proper handoff.

What I know:
- Was working on: [Task]
- Last thing I remember: [Action]

Please:
1. Check git status for uncommitted changes
2. Review recent commits
3. Look for any temp/backup files
4. Reconstruct what happened
5. Suggest how to proceed

Let's figure out where we are.
```

---

## Handoff Quality Checks

### Verify Handoff Completeness
```
Review this handoff document:

[Paste handoff]

Check for:
1. Is it specific enough to resume without questions?
2. Is the code state clear?
3. Are next steps actionable?
4. Is important context captured?
5. Are there any gaps?

What's missing or unclear?
```

### Test Handoff Clarity
```
Pretend you're a new AI starting fresh. Given only this handoff:

[Paste handoff]

1. What would you do first?
2. What questions would you have?
3. What might you do wrong?
4. What's unclear?

Help me improve this handoff based on your confusion points.
```

---

## Templates

### Minimal Handoff
```markdown
## Status
Working / Blocked / Complete

## Summary
[One sentence]

## Next
[One action item]

## Note
[One critical thing to remember]
```

### Standard Handoff
```markdown
## Completed
- [Item 1]
- [Item 2]

## State
Code: [compiles/runs/tested]
Branch: [branch name]
Uncommitted: [yes/no]

## Next Steps
1. [Priority 1]
2. [Priority 2]

## Context
[Important information]
```

### Comprehensive Handoff
```markdown
## Session [Date]

### Completed
- [Detailed item 1]
- [Detailed item 2]

### In Progress
- [Partial work, state]

### Code State
- Compiles: [Yes/No]
- Tests: [Pass/Fail/Partial]
- Runs: [Yes/No]
- Branch: [Name]
- Uncommitted changes: [List]

### Decisions Made
- [Decision 1]: [Rationale]
- [Decision 2]: [Rationale]

### Blockers/Issues
- [Issue 1]: [Status]

### Next Session
1. [First task - detailed]
2. [Second task]
3. [Third task]

### Commands
```bash
[Commands to run to resume]
```

### Notes
[Any other important context]
```

---

*Good handoffs make the difference between productive sessions 
and frustrating re-orientation.*
