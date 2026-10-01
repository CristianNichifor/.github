# Contributing

Choose a bounded issue and read the repository's README and AGENTS instructions. Explain the intended behavior and acceptance criteria before a large change. A useful issue includes reproduction steps or an example, expected results, constraints, affected area and a verification command.

Use the project's documented locked install and check commands. Ordinary tests should use synthetic fixtures without maintainer accounts. Keep live-service checks separate and report which checks were not run.

AI-assisted contributions are welcome. Contributors remain responsible for understanding their changes, checking sources, running relevant tests and responding to review. Do not submit generated bulk changes without reviewing them.

## Contribution workflow

- Work from the remote default branch in a separate checkout. With the maintainer's `wt` tool, run `git fetch origin` then `wt new chore/<task> origin/<default-branch>`; it creates `<repo>/.worktrees/chore/<task>`. Contributors without `wt` can use a separate clone and feature branch. Never modify another task's working tree.
- Use Conventional Commits: imperative lower-case subject, at most 72 characters, no trailing full stop, one change per commit. Explain why in the body only when needed; link issues with `Refs: #N` or `Closes: #N`.
- Open a PR against the repository’s default branch with the problem, resulting behavior, verification command/results and any limitations. Agents never merge PRs, push directly to protected branches, deploy, or publish releases.
- A required check or administrator-only branch rule is not an agent permission boundary: administrator credentials can bypass rules. Keep publication credentials out of ordinary development.
- Tasks need an observable acceptance criterion, affected area, constraints and a verification command. Use synthetic fixtures; do not include credentials or personal data in issues, logs or tests.

For UI changes, include screenshots of affected states. For data or calculation changes, include source provenance and a representative input/output example. Changes to generated files must include the source and regeneration command.
