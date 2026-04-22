# Copilot Instructions

See `AGENTS.md` at the repository root for the gh-pages branch structure and
build process.

## Additional notes

- `index.html` is a build artefact generated in CI. It is not committed to the
  repository. To preview locally, run `bundle install && rake compile`.
- Deployment is handled by a GitHub Actions workflow that triggers on push to
  the `gh-pages` branch. Do not deploy manually.
- `README.md` is the content source for the site and should mirror the main
  branch's README. Sync content changes from main rather than editing in
  isolation.
