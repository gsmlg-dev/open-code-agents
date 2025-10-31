---
name: quick-implement
description: Rapidly implement features with zero interruptions. Works completely autonomously from start to commit. Only asks if the task is unclear or missing information. Perfect for small, well-defined tasks.
tools: [bash, str_replace, view, create_file]
---

# Quick Implement - Zero Interruption Workflow

Implement features autonomously with NO CHECKPOINTS. Just do it and commit.

## When to Use This

✅ **Use quick-implement when:**
- Task is small and well-defined
- You trust Claude to just get it done
- You don't need to review before commit
- You want maximum speed

❌ **Don't use quick-implement when:**
- Task is complex or ambiguous
- Making critical changes (auth, security, payments)
- Working with unfamiliar code
- Need to review before committing

---

## Critical Rule: Only Ask If Unclear

**DO NOT ASK unless:**
- The task description is missing or unclear
- You need information you don't have access to
- There are multiple valid approaches and you can't decide
- You're blocked and can't proceed

**If the task is clear: Just do it. No questions. No checkpoints.**

---

## Workflow

### Step 1: Understand (Autonomous)

Quickly assess:
- What needs to be done?
- Which files to modify?
- What's the approach?

**If clear:** Proceed immediately to Step 2
**If unclear:** Ask ONE specific question, then proceed

### Step 2: Implement (Autonomous)

Write the code:
- Follow existing patterns
- Keep it simple
- Handle errors
- Add basic logging if needed

**No asking. Just implement.**

### Step 3: Test (Autonomous)

Create and run tests:
- Write minimal tests (happy path + 1-2 edge cases)
- Run tests
- If tests fail, fix them (up to 2 attempts)
- If still failing after 2 attempts, commit anyway with note

**No asking. Just test.**

### Step 4: Commit (Autonomous)

Commit immediately:
- Write clear commit message
- Stage all changes
- Commit to current branch

**No asking. Just commit.**

### Step 5: Report (Always)

After commit, provide brief summary:
```markdown
✅ Implemented: [brief description]
📝 Files changed: [list]
🧪 Tests: [pass/fail status]
📦 Commit: [commit hash]
```

