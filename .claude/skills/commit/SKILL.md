---
name: commit
description: Create git commits with conventional commit format and optional Linear issue linking. Use when the user invokes /commit, optionally with a Linear issue ID argument (e.g., "/commit RES-81"). Stages files, generates commit messages, and links to Linear issues.
---

# Commit

Stage and commit changes with Linear issue tracking.

## Workflow

1. **Gather context** (run in parallel):
   - `git status` — check for changes; if none, inform user and stop
   - `git diff` (staged + unstaged) — review changes for commit message and issue matching
   - `git log --oneline -5` — match recent commit style

2. **Resolve Linear issue**:
   - If issue ID provided as argument (e.g., `/commit RES-81`), use it directly
   - Otherwise, fetch issues in parallel via `list_issues` MCP tool:
     - `assignee: "me"`, `state: "In Progress"`, `limit: 10`
     - `assignee: "me"`, `state: "Todo"`, `limit: 10`
   - Match diff against issue titles/descriptions, pick up to 2 most relevant (prioritize In Progress)
   - Use `AskUserQuestion` with matched issues as options (format: "RES-81: Title"). Always include "None" as final option

3. **Stage and commit**:
   - Stage specific files related to the changes (avoid `git add -A` unless user requests it)
   - Generate commit message using conventional commits format
   - If a Linear issue was selected, add `Closes ISSUE-ID` footer
   - Use HEREDOC for commit message to preserve formatting

4. **Push** (ask first):
   - Use `AskUserQuestion`: "Push to remote?" with "Yes" and "No" options
   - Push only if confirmed

## Commit Message Convention

```
<type>: <short description>

<optional body>

Closes <ISSUE-ID>
```

**Example** — `/commit RES-81` produces:
```
feat: add user authentication flow

Implement OAuth2 login with Google and GitHub providers.

Closes RES-81
```

## Edge Cases

- **Pre-commit hook failure**: Fix the issue, re-stage, create a NEW commit (never amend)
- **Nothing to commit**: Inform the user and stop
- **Secrets detected** (.env, credentials.json, etc.): Warn and exclude from staging
