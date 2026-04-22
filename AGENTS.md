# Agents

## Overview

This is the `gh-pages` branch of MUG (Matty's Ultimate Gem). It contains the
source for the project's GitHub Pages site, which presents the gem's API
documentation as a single HTML page.

The site inherits its layout, navbar, and CSS/JS includes from the
[phluid61.github.io](https://github.com/phluid61/phluid61.github.io)
repository via the `jekyll-remote-theme` plugin.

The `README.md` here is a copy of the main branch's README and serves as the
primary content source for the generated page.

## Repository layout

- `index.html` — generated output (committed by CI; built from source files).
  Contains Jekyll front matter and page content only; the layout is applied by
  GitHub Pages' Jekyll at serve time.
- `_config.yml` — Jekyll configuration; sets `remote_theme` to inherit layouts
  from `phluid61/phluid61.github.io`
- `_data/navigation.yml` — navbar menu data (copy from parent theme; update
  when the parent's navigation changes)
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

To preview the site locally with the inherited layout, symlink the parent
theme's `_layouts/`, `_includes/`, and `_data/` directories into this repo,
then run `jekyll serve`.

## Deployment

GitHub Pages is configured to deploy from the `gh-pages` branch. Jekyll
processes the branch content at serve time, applying the remote theme layout.

Two workflows keep the site up to date:

- `.github/workflows/deploy-pages.yml` (on `gh-pages`) — triggers when source
  files are pushed directly to `gh-pages`. Builds `index.html` and commits it.
- `.github/workflows/update-pages.yml` (on `main`) — triggers when `README.md`,
  `LICENSE`, or `code_of_conduct.md` change on `main`. Syncs those files to
  `gh-pages`, rebuilds `index.html`, and commits both.

## Style

- `index.html` is a build artefact committed by CI. Changes to site structure
  or styling should be made in the `Rakefile` or the parent theme; CI will
  rebuild and commit `index.html` automatically.
- `README.md` content changes should be ported from the main branch to keep
  the documentation in sync.
- The shared layout (navbar, page skeleton, Bootstrap 3 CSS/JS) is maintained
  in `phluid61/phluid61.github.io`. Changes to navigation should be made in
  `_data/navigation.yml` in both the parent theme and this repo.

## Licence

ISC. See `LICENSE`.
