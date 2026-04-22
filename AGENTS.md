# Agents

## Overview

This is the `gh-pages` branch of MUG (Matty's Ultimate Gem). It contains the
source for the project's GitHub Pages site, which presents the gem's API
documentation as a single HTML page.

The `README.md` here is a copy of the main branch's README and serves as the
primary content source for the generated page.

## Repository layout

- `index.html` — generated output (committed by CI; built from source files)
- `head` — HTML before the content (doctype, head, navigation, etc.)
- `tail` — HTML after the content (closing tags, scripts)
- `README.md` — Markdown content, converted to HTML during compilation
- `LICENSE` — ISC licence text, included verbatim in the page
- `code_of_conduct.md` — included in the page via Markdown conversion
- `Rakefile` — build script that compiles the above into `index.html`
- `Gemfile` — gem dependencies (`commonmarker`)
- `markdown` — helper script (Ruby) that converts Markdown to HTML using
  `commonmarker`
- `.github/workflows/deploy-pages.yml` — GitHub Actions workflow that builds
  `index.html` and commits it when source files change
- `highlight.js/` — syntax highlighting for code blocks

## Building

```
bundle install
rake          # compiles index.html (default task)
rake compile  # same as above
rake clean    # removes the generated index.html
```

The `markdown` script requires the `commonmarker` gem (declared in `Gemfile`).

## Deployment

GitHub Pages is configured to deploy from the `gh-pages` branch (branch-based
deployment). The `index.html` file is committed to the repository by CI.

Two workflows keep the site up to date:

- `.github/workflows/deploy-pages.yml` (on `gh-pages`) — triggers when source
  files are pushed directly to `gh-pages`. Builds `index.html` and commits it.
- `.github/workflows/update-pages.yml` (on `main`) — triggers when `README.md`,
  `LICENSE`, or `code_of_conduct.md` change on `main`. Syncs those files to
  `gh-pages`, rebuilds `index.html`, and commits both.

## Style

- `head` and `tail` are raw HTML fragments. Keep them consistent with
  Bootstrap 3 markup used throughout.
- `index.html` is a build artefact committed by CI. Changes to site structure
  or styling should be made in `head`, `tail`, or the `Rakefile`; CI will
  rebuild and commit `index.html` automatically.
- `README.md` content changes should be ported from the main branch to keep
  the documentation in sync.

## Licence

ISC. See `LICENSE`.
