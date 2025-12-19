# Session Handoff Document
<!-- The "Memento Method" - Because AI forgets everything between sessions -->
<!-- Update this before clearing context or ending a session -->
<!-- Note: Even with native resume (claude --resume, /resume), this doc provides insurance -->

## Session: [DATE] - [TIME]

### 🎯 What We Were Working On
**Main Task**: 
<!-- One sentence description -->

**Current Status**: 🟢 Complete | 🟡 In Progress | 🔴 Blocked

**Progress Summary**:
<!-- What got accomplished this session -->
- 
- 
- 

---

## 📍 Where We Left Off

### Last Action Taken
<!-- What was the most recent thing done? -->
```
Describe the last completed action
```

### Current State of Code
<!-- Is it working? Broken? Mid-refactor? -->
```
Compiles: Yes/No
Tests Pass: Yes/No/Partial
Runnable: Yes/No
```

### Files Modified This Session
<!-- Help next session know what was touched -->
| File | Changes | Status |
|------|---------|--------|
| | | Done/Partial/Reverted |
| | | |

### Uncommitted Changes
<!-- What's in the working tree? -->
```bash
# Output of git status
```

---

## 📋 Next Steps

### Immediate Next Action
<!-- THE most important thing to do next -->
```
1. [Specific action to take]
```

### Remaining Work
<!-- Ordered list of what's left -->
1. [ ] 
2. [ ] 
3. [ ] 

### Blocked Items
<!-- Things we can't do until something else happens -->
| Item | Blocked By | Resolution |
|------|------------|------------|
| | | |

---

## 🧠 Context to Remember

### Key Decisions Made
<!-- Important choices that inform future work -->
- **Decision**: [What we decided]
  - **Why**: [Rationale]
  - **Alternative rejected**: [What we didn't do]

### Technical Details
<!-- Things that took time to figure out -->
```
Important technical context that's easy to forget:
- 
- 
```

### Gotchas Discovered
<!-- Pitfalls to avoid -->
⚠️ 
⚠️ 

### Useful Commands/Snippets
<!-- Things that worked and might be needed again -->
```bash
# Command that was helpful
```

---

## 🐛 Known Issues

### Bugs Found (Not Fixed)
| Issue | Severity | Notes |
|-------|----------|-------|
| | Low/Med/High | |

### Technical Debt Noted
<!-- Things that work but should be improved -->
- 
- 

### Tests to Add
<!-- Test coverage gaps identified -->
- [ ] Test for: 
- [ ] Test for: 

---

## 📝 AI Instructions for Next Session

### Resuming Options
<!-- Choose based on situation -->

**Option A: Native Resume** (same-day, quick return)
```bash
# Claude Code
claude --continue       # Resume most recent
claude --resume         # Interactive session picker

# Gemini CLI (v0.20.0+)
gemini --resume         # Resume most recent
gemini --list-sessions  # See all available sessions
```
Then verify: "Summarize where we left off and what's next"

**Option B: Manual Resume** (multi-day, complex work, sharing)
1. Read this entire document
2. Check git status and recent commits
3. Run tests to verify current state
4. Review the files mentioned above

### What to Do Next
<!-- Clear instructions for resuming -->
```
Start by:
1. 
2. 
3. 
```

### What NOT to Do
<!-- Specific warnings -->
- Do NOT: 
- Do NOT: 
- AVOID: 

### Context Window Management
<!-- If context was getting full -->
- Session context usage: ~X% full
- Files loaded that can be unloaded: 
- Summary sufficient? Yes/No

---

## 🔗 Related Resources

### Reference Documents
- 
- 

### Related Code
<!-- Other files that provide context -->
- 
- 

### External Links
- 
- 

---

## 📊 Session Metrics

| Metric | Value |
|--------|-------|
| Session Duration | |
| Commits Made | |
| Tests Added | |
| Bugs Fixed | |
| Context Clears | |

---

## ✅ Pre-Handoff Checklist

Before ending session:
- [ ] All work committed or intentionally uncommitted
- [ ] This document updated
- [ ] Tests run one final time
- [ ] No broken state left behind
- [ ] Next steps clearly documented

---

*Session by: [Human/AI indicator]*
*Handoff ready: [timestamp]*
*Priority for next session: [High/Medium/Low]*
