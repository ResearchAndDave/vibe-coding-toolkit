# Process Reform Prompts
<!-- Fighting organizational bottlenecks -->

## The Problem

> "The alluring potential of 10x productivity from your AI assistants 
> collides head-on with organizational processes designed for a different era."
> — Chapter 16, Vibe Coding

Old processes can make AI speed useless. Time to reform.

---

## Identifying Bottlenecks

### Process Audit
```
Help me audit this process for bottlenecks:

Process: [Name]
Purpose: [What it's supposed to achieve]

Current steps:
1. [Step 1] - [Time/who]
2. [Step 2] - [Time/who]
3. [Step 3] - [Time/who]
...

Where are the delays? What's blocking flow?
What would a DevOps engineer critique?
```

### Approval Chain Analysis
```
Our approval chain for [changes/deployments]:

1. [Approval 1] - [who] - [typical wait time]
2. [Approval 2] - [who] - [typical wait time]
3. [Approval 3] - [who] - [typical wait time]

Total typical time: [duration]

Help me identify:
1. Which approvals add genuine value?
2. Which are theater/checkbox exercises?
3. What could be automated?
4. What could be parallelized?
5. What could be eliminated?
```

---

## Building the Case for Change

### Data-Driven Argument
```
Help me build a case for changing [process]:

Current state:
- Time: [duration]
- Steps: [number]
- People involved: [number]
- Failure rate: [percent]

Problems:
[List issues]

Help me:
1. Quantify the cost of current process
2. Project benefits of improvement
3. Identify risks of not changing
4. Create compelling metrics
5. Address likely objections
```

### Morgan Stanley Pattern
```
Morgan Stanley reduced change approval from 3.5 days to under 1 hour 
with BETTER safety (0% incidents vs 1.5% with human review).

Help me propose a similar approach for [our process]:

Current approval process:
[Description]

Available data:
[What metrics we have]

How could we:
1. Use data to identify low-risk changes?
2. Create a "fast lane" for safe changes?
3. Apply more scrutiny to high-risk only?
4. Measure safety outcomes?
```

---

## Proposing Alternatives

### Fast Lane Design
```
Design a "fast lane" for low-risk [changes/deployments]:

Criteria for fast lane (auto-approve):
- [Criterion 1]
- [Criterion 2]
- [Criterion 3]

Criteria requiring full review:
- [Criterion 1]
- [Criterion 2]

Safety measures still applied:
- [Measure 1]
- [Measure 2]

How do we validate this is safe before full rollout?
```

### Automation Proposal
```
This manual process could be automated:

[Describe current manual process]

Proposed automation:
1. [What would be automated]
2. [What stays manual]
3. [How we verify it's working]

Benefits:
- Speed: [improvement]
- Consistency: [improvement]
- Error reduction: [estimate]

Risks and mitigations:
- [Risk 1]: [Mitigation]
```

---

## Handling Objections

### Common Objections
```
I'm proposing [change] and expect these objections:

1. "[Objection 1]"
2. "[Objection 2]"
3. "[Objection 3]"

Help me prepare responses that:
- Acknowledge the concern
- Provide evidence/data
- Offer safeguards
- Suggest pilot approach
```

### Compliance Concerns
```
We need to change [process] but have compliance requirements:

Requirements:
- [Compliance standard - e.g., SOC 2, HIPAA]
- [Specific requirements]

Current process:
[How we meet requirements now]

Proposed change:
[What we want to do differently]

Help me show how the new process still meets compliance:
1. Map requirements to new process
2. Identify any gaps
3. Propose controls for gaps
4. Suggest audit evidence
```

---

## Pilot Programs

### Pilot Design
```
Design a pilot for [process change]:

Scope:
- Teams: [which teams]
- Duration: [how long]
- Changes: [what's different]

Success metrics:
- [Metric 1]: Target [X]
- [Metric 2]: Target [Y]

Guardrails:
- [Safety measure 1]
- [Rollback trigger]

How do we evaluate and decide to expand?
```

### Pilot Results Analysis
```
Analyze our pilot results:

Pilot: [description]
Duration: [time]
Scope: [teams/changes]

Results:
[Paste metrics]

Help me:
1. Interpret the data
2. Identify what worked
3. Identify what didn't
4. Recommend: expand / modify / abort
5. Create presentation for stakeholders
```

---

## Cultural Change

### Building Allies
```
I want to change [process] but need support.

Key stakeholders:
1. [Person/Role]: [Their concerns]
2. [Person/Role]: [Their concerns]
3. [Person/Role]: [Their concerns]

Help me:
1. Understand each stakeholder's perspective
2. Identify shared goals
3. Find win-win framings
4. Sequence conversations strategically
```

### Gradual Transformation
```
We can't change everything at once. Help me create a phased plan:

Ultimate goal: [vision]

Current state: [today]

Constraints:
- [Constraint 1]
- [Constraint 2]

Create a roadmap with:
1. Quick wins (this month)
2. Medium-term changes (this quarter)
3. Larger transformations (this year)

Each phase should build credibility for the next.
```

---

## If You Can't Change the Process

### Working Within Constraints
```
I can't change [process] right now.

Constraints:
[Why it can't change]

But I still want to go faster. Help me:
1. Optimize within the current rules
2. Reduce wait times where possible
3. Batch work more efficiently
4. Automate what I can control
5. Build evidence for future change
```

### Guerrilla Improvements
```
Officially I can't change [process].

But what could I do to:
1. Reduce friction in my part
2. Make reviews easier/faster for approvers
3. Front-load work to reduce iterations
4. Build tools that help everyone
5. Create data that supports future change

Small improvements, low profile, real impact.
```

---

## AI-Specific Process Arguments

### The AI Productivity Case
```
Help me explain why AI development needs different processes:

Current process designed for:
- [Velocity X]
- [Change rate Y]

AI-assisted development produces:
- [Velocity 10X]
- [Change rate 10Y]

The mismatch:
[Describe the bottleneck]

What we need instead:
[Proposed changes]

This isn't about less safety - it's about different safety.
```

### AI-Enhanced Safety
```
AI can actually make reviews BETTER and FASTER. Help me propose:

Current review process:
[Description]

AI-enhanced version:
1. AI pre-reviews all changes
2. AI flags risks and anomalies
3. Human reviews AI summary + flagged items
4. AI handles routine, humans handle judgment

Benefits:
- Faster: [time saved]
- Safer: [coverage improved]
- Focused: [human attention on what matters]
```

---

## Quick Reference

| Situation | Approach |
|-----------|----------|
| Too many approvals | Fast lane for low-risk |
| Long wait times | Parallel instead of serial |
| Manual checks | Automate what can be |
| Change resistance | Data + pilot + gradual |
| Compliance blocker | Map requirements to new process |
| No authority | Optimize what you control |

---

## Key Quotes

> "With AI, the excuse of 'It's too much work to maintain backward 
> compatibility' gets to retire with a full pension."

> "Control doesn't always require bureaucracy."

> "If you're not allowed to use AI to write production code at your company, 
> think about using it to write automated tests, or to help create a strategy 
> to dismantle your monolith, or to increase the effectiveness of your CI/CD 
> pipeline."

---

*"You need to remove these organizational rate limiters. You need to reach 
a minimum level of capability where engineers can work and iterate with 
more autonomy."*
