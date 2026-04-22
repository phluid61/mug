# Copilot Instructions

See `AGENTS.md` at the repository root for the gh-pages branch structure and
build process.

## Additional notes

- `index.html` is a build artefact committed by CI. Do not edit it directly;
  modify the source files and let CI rebuild it. To preview locally, run
  `bundle install && rake compile`.
- GitHub Pages deploys from the `gh-pages` branch directly (branch-based
  deployment). CI workflows on both `main` and `gh-pages` keep `index.html`
  up to date.
- `README.md` is the content source for the site and should mirror the main
  branch's README. Sync content changes from main rather than editing in
  isolation.
