---
name: diff-walkthrough
description: Walk through git diffs as a detailed, educational code review. Use when the user asks to explain, walk through, or review a diff, commit, or set of changes — e.g., "explain the diff from commit X", "walk me through these changes", "what changed since tag Y". Produces a structured walkthrough referencing exact file paths, line numbers, and function names, showing before/after code, and explaining motivation.
---

# Diff Walkthrough

Produce a structured, side-by-side style walkthrough of git changes. The user and Claude are looking at the diff together; Claude narrates each logical change with precise source locations.

## Invocation

Accept a diff source: commit hash, range (`A..B`), branch, tag, or PR. Determine the appropriate `git diff` or `git log` command. When invoked with `/diff-walkthrough`, the user provides the diff source as an argument (e.g., `/diff-walkthrough abc123`).

## Gathering Context

1. Run `git log --oneline` to establish surrounding commit context.
2. Run `git diff <source>..HEAD --stat` (or appropriate range) for a file-level summary.
3. Run `git diff <source>..HEAD -- <path>` to get the full diff. For large diffs, split by directory (e.g., `src/`, `tests/`, `templates/`).
4. Read the **current state** of key changed files to get accurate line numbers — diff hunks alone don't give stable line references for the "after" state.
5. When needed, read the **before state** with `git show <ref>:<path>` to show what was removed or restructured.

## Structuring the Walkthrough

Group changes into **logical changes**, not per-file. A single logical change may span multiple files. Number them sequentially: "Change 1", "Change 2", etc.

Order logical changes by dependency — foundational changes first (e.g., data types before model logic before tests).

## Explaining Each Change

For each logical change, provide:

### Header

A short title describing the change (e.g., "`Question` type moved from stages to data layer").

### Before

Show the relevant code **before** the change. Reference the exact location:

> `src/stages/question_generation.rs`, lines 12-17, `QuestionOutput` struct:

Then show the code block. Use the old commit to get exact content via `git show <ref>:<path>`.

### After

Show the relevant code **after** the change. Reference the exact location in the current codebase:

> `src/data/refinement_session.rs`, lines 14-19, `Question` struct:

Then show the code block. Use current file reads for accurate line numbers.

### Ripple Effects

When a change propagates to other files (imports, call sites, test assertions), list the affected locations briefly:

> This flows through to `src/model/refinement_session.rs`, `add_answer()` at lines 104-108 where the `Answer` is constructed.

### Motivation

Explain **why** the change was made — not just what changed. Connect it to design principles, consistency goals, or API simplification. Keep this concise (1-3 sentences).

## Conventions

- Always reference locations as `file_path`, lines N-M, `function_name()` or `StructName`.
- Show code blocks with the language identifier (```rust, ```sql, etc.).
- When the before/after are short (< 5 lines), an inline comparison is fine. For larger blocks, use separate Before/After subsections.
- Do not reproduce entire files. Show only the relevant excerpt (typically 3-10 lines).
- When a change is purely mechanical (e.g., `tailored.name` -> `tailored.snapshot.name` across 20 test assertions), show one example and summarize the rest.
