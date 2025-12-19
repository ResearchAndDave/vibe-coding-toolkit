# API Contract Registry
<!-- Document and protect your API contracts -->

## Overview

This document registers all public APIs that MUST NOT be broken. AI assistants must preserve these contracts unless explicitly authorized to change them.

> "You cannot break any existing functionality."
> — The One Rule for API Changes

---

## The Philosophy: Accrete, Don't Destroy

```
GOOD: Add new functions/endpoints alongside old ones
BAD:  Modify or remove existing functions/endpoints

GOOD: Deprecate with warnings, keep working
BAD:  Delete deprecated code

GOOD: Extend interfaces with optional parameters  
BAD:  Change required parameters or return types
```

**Visual Guide** (from Chapter 16):
- Horizontal slices = code that lives forever (GOOD)
- Jagged downward slopes = code being deleted (BAD)

---

## Registered APIs

### Internal APIs

#### Module: [Module Name]
**File**: `src/[path]`
**Status**: 🟢 Stable | 🟡 Evolving | 🔴 Deprecated

| Function/Method | Signature | Since | Notes |
|-----------------|-----------|-------|-------|
| | | | |
| | | | |

**Constraints**:
- [ ] Cannot change parameter types
- [ ] Cannot change return type
- [ ] Cannot remove
- [ ] New parameters must have defaults

---

#### Module: [Module Name]
**File**: `src/[path]`
**Status**: 🟢 Stable

| Function/Method | Signature | Since | Notes |
|-----------------|-----------|-------|-------|
| | | | |

**Constraints**:
- [ ] 

---

### External APIs (HTTP/REST/GraphQL)

#### Endpoint: [METHOD /path]
**Version**: v1
**Status**: 🟢 Stable

**Request Schema**:
```json
{
  "field": "type"
}
```

**Response Schema**:
```json
{
  "field": "type"
}
```

**Constraints**:
- [ ] Cannot remove fields from response
- [ ] Cannot change field types
- [ ] Cannot make optional fields required
- [ ] New fields must be optional

---

### Database Schemas

#### Table: [table_name]
**Status**: 🟢 Stable

| Column | Type | Nullable | Notes |
|--------|------|----------|-------|
| | | | |

**Constraints**:
- [ ] Cannot remove columns
- [ ] Cannot change column types (narrowing)
- [ ] Cannot make nullable columns non-nullable
- [ ] New columns must be nullable or have defaults

---

### Event/Message Contracts

#### Event: [event_name]
**Version**: 1
**Status**: 🟢 Stable

**Payload Schema**:
```json
{
  "field": "type"
}
```

**Consumers**:
- [Service A]
- [Service B]

**Constraints**:
- [ ] Cannot remove fields
- [ ] Cannot change field semantics

---

## Change Process

### To Add New API
1. Document in this registry
2. Mark as 🟡 Evolving initially
3. Promote to 🟢 Stable after validation

### To Modify Existing API
1. **DO NOT** modify in place
2. Create new version alongside old
3. Update consumers over time
4. Deprecate old version (but keep working)

### To Deprecate API
1. Mark as 🔴 Deprecated in registry
2. Add deprecation warning in code
3. Document migration path
4. Set removal timeline (generous)
5. **Keep working** until all consumers migrated

### To Remove API (Rare!)
1. Requires explicit approval
2. All consumers must be migrated
3. Document removal in changelog
4. Archive in "Removed APIs" section

---

## Golden Rules for AI

Add these to your AGENTS.md:

```markdown
## API Rules (NEVER VIOLATE)

1. **Never modify existing function signatures**
   - Don't change parameter names, types, or order
   - Don't change return types
   - New parameters MUST have default values

2. **Never remove existing functions**
   - Deprecate with warnings instead
   - Keep deprecated code working

3. **Never change database schemas destructively**
   - Don't remove columns
   - Don't narrow column types
   - New columns must be nullable or have defaults

4. **Never change API response shapes**
   - Don't remove fields
   - Don't change field types
   - Add new fields as optional only

5. **When in doubt, ADD rather than MODIFY**
   - Create functionV2() instead of changing function()
   - Create /v2/endpoint instead of changing /v1/endpoint
```

---

## Verification Checklist

Before accepting AI changes:

- [ ] No existing functions modified
- [ ] No existing functions removed
- [ ] No parameter types changed
- [ ] No return types changed
- [ ] New parameters have defaults
- [ ] Database migrations are additive only
- [ ] API responses maintain backward compatibility
- [ ] Event payloads maintain backward compatibility

---

## Removed APIs Archive

| API | Removed Date | Reason | Migration Path |
|-----|--------------|--------|----------------|
| | | | |

---

*Remember: "The number one excuse for changing APIs incompatibly is 'It's too much 
work to maintain them.' With AI, this excuse gets to retire with a full pension."*
