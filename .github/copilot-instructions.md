# Copilot Instructions

See `AGENTS.md` at the repository root for project structure, conventions, and
how to add new modules.

## Additional notes

- Each module under `lib/mug/` monkey-patches core Ruby classes. Ensure new
  methods do not conflict with the Ruby version's stdlib.
- Individual modules must remain independently requireable; do not introduce
  cross-dependencies between modules.
- Commits that modify `README.md`, `LICENSE`, or `code_of_conduct.md` must NOT
  include `[ci skip]`, because a workflow triggers a gh-pages deployment when
  those files change on `main`.
