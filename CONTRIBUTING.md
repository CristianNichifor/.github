# Contributing

Choose a bounded issue and read the repository's README and AGENTS instructions. Explain the intended behavior and acceptance criteria before a large change. A useful issue includes reproduction steps or an example, expected results, constraints, affected area and a verification command.

Use the project's documented locked install and check commands. Ordinary tests should use synthetic fixtures without maintainer accounts. Keep live-service checks separate and report which checks were not run.

AI-assisted contributions are welcome. Contributors remain responsible for understanding their changes, checking sources, running relevant tests and responding to review. Do not submit generated bulk changes without reviewing them.

## Contribution workflow

- For a deployed project, start from `origin/dev` and target `dev` in the pull request. For a configuration-only project, start from `origin/main` and target `main`. The README or AGENTS file identifies the project type. Use a separate clone or worktree so existing work is not disturbed. Maintainers with `wt` can run `git fetch origin` and `wt new chore/<task> origin/<base>`.
- Use Conventional Commits: imperative lower-case subject, at most 72 characters, no trailing full stop, one change per commit. Explain why in the body only when needed; link issues with `Refs: #N` or `Closes: #N`.
- Open a PR with the problem, resulting behavior, verification command/results and any limitations. Reviewed PRs into `dev` land by squash after required checks pass. Only the account owner merges a configuration repository PR into `main` or promotes deployed `dev` to `main`; production promotion is fast-forward only.
- Keep publication credentials out of ordinary development. Do not push directly to protected branches or bypass their rules.
- Tasks need an observable acceptance criterion, affected area, constraints and a verification command. Use synthetic fixtures; do not include credentials or personal data in issues, logs or tests.

For UI changes, include screenshots of affected states. For data or calculation changes, include source provenance and a representative input/output example. Changes to generated files must include the source and regeneration command.
