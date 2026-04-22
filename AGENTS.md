# Agents

## Overview

This is the `gh-pages` branch of MUG (Matty's Ultimate Gem). It contains the
source for the project's GitHub Pages site, which presents the gem's API
documentation as a single HTML page.

The `README.md` here is a copy of the main branch's README and serves as the
primary content source for the generated page.

## Repository layout

- `index.html` — generated output (not committed; built in CI)
- `head` — HTML before the content (doctype, head, navigation, etc.)
- `tail` — HTML after the content (closing tags, scripts)
- `README.md` — Markdown content, converted to HTML during compilation
- `LICENSE` — ISC licence text, included verbatim in the page
- `code_of_conduct.md` — included in the page via Markdown conversion
- `Rakefile` — build script that compiles the above into `index.html`
- `Gemfile` — gem dependencies (`commonmarker`)
- `markdown` — helper script (Ruby) that converts Markdown to HTML using
  `commonmarker`
- `.github/workflows/deploy-pages.yml` — GitHub Actions workflow for building
  and deploying the site
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

Deployment is automated via GitHub Actions (`.github/workflows/deploy-pages.yml`).
Pushing to the `gh-pages` branch triggers a workflow that compiles `index.html`
and deploys it to GitHub Pages. The `index.html` file is not committed to the
repository — it is a build artefact produced in CI.

## Style

- `head` and `tail` are raw HTML fragments. Keep them consistent with
  Bootstrap 3 markup used throughout.
- `index.html` is a build artefact. Changes to site structure or styling
  should be made in `head`, `tail`, or the `Rakefile`, then recompiled.
- `README.md` content changes should be ported from the main branch to keep
  the documentation in sync.

## Licence

ISC. See `LICENSE`.
