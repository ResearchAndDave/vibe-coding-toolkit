# Tracer Bullet Template
<!-- Minimal implementation to prove a complete path works -->

## Purpose
A tracer bullet is the **smallest possible implementation** that proves an end-to-end path works. It helps you:
1. Verify AI can handle a specific technology/challenge
2. Establish stable interfaces between components
3. Decide whether to continue with AI or take manual control

---

## Tracer Bullet: [NAME]

### Objective
**What are we proving?**
<!-- One sentence: "We're proving that [X] can [Y]" -->

**Why a tracer bullet?**
- [ ] New/unfamiliar technology
- [ ] Complex integration
- [ ] Uncertain AI capability
- [ ] Interface definition needed
- [ ] Risk mitigation before larger investment

---

## Minimal Scope

### Must Include
<!-- The absolute minimum for end-to-end -->
- Input: 
- Processing: 
- Output: 

### Must NOT Include
<!-- Resist scope creep -->
- No error handling (yet)
- No edge cases (yet)
- No optimization (yet)
- No polish (yet)

### Success Criteria
<!-- Binary: it either works or doesn't -->
```
When I [do X], I see [Y]
```

---

## Implementation

### Target Duration
**Time box**: 15-30 minutes maximum

If not working within this time → STOP and reassess

### Steps
1. [ ] **Setup** (~2 min)
   - 
   
2. [ ] **Minimal Implementation** (~10 min)
   - 
   
3. [ ] **Verify** (~3 min)
   - 

### Code Location
<!-- Where will this minimal code live? -->
```
Path: 
```

### Verification Command
```bash
# How to test if it works
```

---

## Outcome Assessment

### ✅ Success Path
If the tracer bullet works:
```
→ Celebrate briefly
→ Checkpoint (commit)
→ Expand incrementally:
   1. Add error handling
   2. Add edge cases
   3. Add remaining functionality
   4. Add tests
   5. Polish
```

### ❌ Failure Path
If the tracer bullet fails within time box:

**Diagnose**:
- [ ] AI doesn't understand the technology
- [ ] Technology has unusual patterns
- [ ] Missing dependencies/setup
- [ ] Unclear requirements
- [ ] Other: 

**Options**:
1. **Simplify further** - Is there an even smaller tracer?
2. **Take manual control** - Do it yourself, at least partially
3. **Change approach** - Different technology/pattern
4. **Get help** - Human expert, Stack Overflow, etc.

### ⚠️ Partial Success
If it kind of works but not quite:
```
→ Document what works
→ Document what doesn't
→ Decide: fix forward or pivot?
```

---

## Example Tracer Bullets

### Example 1: New API Integration
```
Objective: Prove we can call the Stripe API and get a response
Minimal: 
  - Hardcoded API key (temp)
  - Call one endpoint
  - Print response
Success: See JSON response in console
Time: 15 min
```

### Example 2: Database Connection
```
Objective: Prove we can connect to PostgreSQL and query
Minimal:
  - Connection string
  - SELECT 1 query
  - Print result
Success: See "1" in output
Time: 10 min
```

### Example 3: Shell Command Execution
```
Objective: Prove we can shell out and capture output
Minimal:
  - Run "ls -la"
  - Capture stdout
  - Print to console
Success: See directory listing
Time: 5 min
```

### Example 4: Cross-Service Communication
```
Objective: Prove Service A can call Service B
Minimal:
  - Service B: /ping endpoint returns "pong"
  - Service A: Call /ping, print response
Success: Service A prints "pong"
Time: 20 min
```

---

## Post-Tracer Bullet

### Document Results
| Aspect | Finding |
|--------|---------|
| AI Capability | Strong/Adequate/Weak |
| Technology Fit | Good/Acceptable/Poor |
| Time to Success | Under/At/Over budget |
| Confidence Level | High/Medium/Low |

### Next Actions
Based on tracer bullet results:
- [ ] Proceed with full implementation
- [ ] Modify approach based on learnings
- [ ] Abandon this approach
- [ ] Investigate blockers further

### Learnings
<!-- What did we discover? -->
```
- 
- 
```

---

## Quick Reference

### When to Use Tracer Bullets
- Starting work with unfamiliar tech
- Before large time investments
- When AI seems to struggle
- When establishing interfaces
- When risk is high

### Signs You Need a Tracer Bullet
- AI gives inconsistent solutions
- Documentation is sparse/confusing
- Multiple failed attempts
- High uncertainty
- Expensive to be wrong

### Anti-Patterns
- ❌ Making the tracer bullet too big
- ❌ Adding "just one more thing"
- ❌ Not time-boxing
- ❌ Continuing past time box when failing
- ❌ Skipping the checkpoint on success

---

*Created: [DATE]*
*Result: Pending | Success | Failure | Partial*
