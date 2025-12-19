# Disaster Recovery Prompts
<!-- When things go catastrophically wrong -->

## The Key Insight

> "What finally got him out of the mess was giving AI a 'Captain Jack Aubrey–
> style order,' telling it, 'Look, these branches are a mess. You figure out 
> how to rescue the work and get it properly merged. Don't screw it up any 
> worse. Make it recoverable.'"
> — Chapter 16, Vibe Coding

**When standard procedures fail, give AI a high-level goal and let it devise the strategy.**

---

## The Captain Jack Aubrey Approach

For complex problems beyond normal procedures:

```
Stop. We're in trouble.

Situation: [Describe the mess]

Goal: [What needs to be achieved]

Constraints:
- Don't make it worse
- Make every step recoverable
- Explain before acting

You figure out how to rescue this. What's your plan?
```

---

## Merge Disaster Recovery

### Epic Merge Conflicts
```
We have a merge disaster:

Source branch: [branch]
Target branch: [branch]
Files in conflict: [number or list]

The problem: [Describe - e.g., "conflicts across 100+ commits"]

Current state:
[Describe what you've tried]

I need you to devise a recovery strategy. Options might include:
- Cherry-picking commits
- Manual file copying
- Creating fresh branch and replaying
- Some approach I haven't thought of

What's your plan? Walk me through it step by step.
```

### Diverged Branches
```
Two branches have diverged significantly:

Branch A: [name] - [description of state]
Branch B: [name] - [description of state]

They're both valuable but seem incompatible.

Help me:
1. Identify what's unique to each
2. Find a strategy to preserve both
3. Create a plan to reconcile them

Don't start executing - give me the plan first.
```

---

## Repository Recovery

### Lost Work (Steve's Scenario)
```
Code has disappeared from my repository.

What I know:
- Last known good state: [description]
- Current state: [description]
- What's missing: [description]

Places to check:
- Local branches
- Remote branches
- Git reflog
- Stashes
- Other clones
- Open terminals/editors

Help me systematically search for the lost code.
```

### Corrupted Repository
```
My Git repository seems corrupted.

Symptoms:
[Describe errors/problems]

What I've tried:
[List attempts]

What I have:
- [ ] Remote clone available
- [ ] Other local clones
- [ ] Recent backups
- [ ] Open files in editors

Help me recover as much as possible.
```

---

## Architecture Recovery

### Fused Modules (Eldritch Horrors)
```
My codebase has become a tangled mess:

[Describe the problem - modules fused, boundaries violated, etc.]

I need to restore modularity:
1. Identify the boundaries that existed
2. Map current dependencies
3. Plan extraction strategy
4. Execute without breaking functionality

Help me create an untangling plan.
```

### Broken APIs (Gene's Scenario)
```
Recent changes broke our API contracts:

What broke: [description]
Who's affected: [consumers]
Current state: [working/not working]

Options:
1. Roll back to [commit]
2. Fix forward by restoring compatibility
3. Version bump and communicate

Help me choose and execute. Priority is restoring service.
```

---

## Data Recovery

### Database Issues
```
We have a database problem:

[Describe the issue - data loss, corruption, wrong migrations, etc.]

Available resources:
- [ ] Backups from [date]
- [ ] Transaction logs
- [ ] Read replicas
- [ ] Application-level backups

Constraints:
- Downtime tolerance: [duration]
- Data loss tolerance: [acceptable loss]

Help me create a recovery plan.
```

---

## Production Incidents

### Service Down
```
[Service] is down in production.

Symptoms:
[What users are experiencing]

What we know:
[Error messages, logs, recent changes]

Help me:
1. Diagnose the likely cause
2. Identify quickest path to restore service
3. Plan proper fix after stability

Start with restore, then root cause.
```

### Performance Degradation
```
[System] has become extremely slow:

Metrics:
[Response times, error rates, etc.]

Recent changes:
[Deployments, config changes, traffic changes]

Help me:
1. Identify likely bottleneck
2. Suggest diagnostic steps
3. Plan remediation

Prioritize: What's the fastest way to restore performance?
```

---

## Decision Framework for Disasters

### Rollback vs Fix Forward
```
I need to decide: rollback or fix forward.

Situation:
[Describe the problem]

Rollback pros:
[List]

Rollback cons:
[List]

Fix forward pros:
[List]

Fix forward cons:
[List]

What would you recommend and why?
```

### Triage Multiple Issues
```
We have multiple problems happening at once:

1. [Problem 1]
2. [Problem 2]
3. [Problem 3]

Resources available:
[People, time, etc.]

Help me triage:
- What's most urgent?
- What's blocking what?
- What can wait?
- What's the attack order?
```

---

## Post-Incident

### Blameless Postmortem
```
Help me conduct a blameless postmortem:

Incident: [description]
Duration: [time]
Impact: [what was affected]

Guide me through:
1. Timeline of events
2. What went wrong (systems, not people)
3. What went right (what limited damage)
4. Root cause(s)
5. Contributing factors
6. Action items to prevent recurrence
```

### Lessons Learned
```
After this incident:

[Describe what happened]

Help me extract lessons:
1. What should we add to AGENTS.md?
2. What detection should we add?
3. What process should change?
4. What documentation is missing?
5. What would have prevented this?
```

---

## Recovery Checklist

During any disaster:

### Phase 1: Assess
- [ ] What's the blast radius?
- [ ] Who's affected?
- [ ] What's the urgency?
- [ ] What resources do we have?

### Phase 2: Stabilize
- [ ] Can we stop the bleeding?
- [ ] Is rollback an option?
- [ ] What's the quickest fix?
- [ ] Who needs to know?

### Phase 3: Recover
- [ ] Execute recovery plan
- [ ] Verify each step
- [ ] Keep notes for postmortem
- [ ] Communicate progress

### Phase 4: Learn
- [ ] Conduct postmortem
- [ ] Update procedures
- [ ] Add detection
- [ ] Strengthen prevention

---

## Emergency Prompts (Copy-Paste Ready)

### Quick Assessment
```
Something's wrong. Help me assess:
[Paste symptoms/errors]

What's likely happening? What should I check first?
```

### Panic Mode
```
URGENT: [Brief description]

What's the fastest way to [restore/fix/recover]?
```

### "I Don't Know What's Wrong"
```
System is misbehaving but I don't understand why.

Expected behavior: [what should happen]
Actual behavior: [what's happening]
Recent changes: [any changes]

Help me diagnose systematically.
```

---

## Golden Rule for Disasters

> "Elevate your Prompts for Complex Problems: When standard procedures fail, 
> don't keep trying the same commands. Give AI a higher-level goal. Treat it 
> like a talented collaborator: Describe the desired outcome, such as 'We 
> need this rescued and integrated,' and let it devise a strategy."

---

*"Even the best chefs occasionally burn dishes, but they also know how 
to rescue the salvageable bits."*
