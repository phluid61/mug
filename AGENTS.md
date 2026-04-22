# Agents

## Overview

MUG (Matty's Ultimate Gem) is a Ruby gem consisting of independent extensions to
core Ruby classes and modules. Each extension is a standalone file that can be
required individually (`require 'mug/bool'`) or all at once (`require 'mug'`).

The canonical reference for what the gem provides is `lib/mug.rb`, which lists
every requireable module. The `README.md` documents each module's public API.

## Repository layout

- `lib/mug.rb` — top-level require; lists all modules
- `lib/mug/` — one file per extension; some are grouped into subdirectories
  (`array/`, `hash/`, `enumerable/`, `matchdata/`, `iterator/`)
- `test/` — one test file per extension, named `test-<module>.rb`
- `mug.gemspec` — gem metadata and version

## Building and testing

```
bundle install
rake          # runs the default task: tests
rake test     # runs tests explicitly
rake rubocop  # runs the linter against lib/**/*.rb
```

Tests use `test-unit` (Test::Unit). The test naming convention is
`test/test-<module>.rb`, matching the corresponding `lib/mug/<module>.rb`.

## Style

RuboCop is configured via `.rubocop.yml` (and `test/.rubocop.yml` for tests).
The configuration is heavily customised — read it before relying on defaults.
Notable choices include `lambda` over `->` and liberal use of whitespace.

## Adding a new module

Discover the pattern by examining any existing module and its test. The key
steps are:

1. Create `lib/mug/<name>.rb`
2. Add a `require_relative` line to `lib/mug.rb`
3. Create `test/test-<name>.rb`
4. Verify with `rake test`

Some modules are grouping shims (e.g. `lib/mug/array.rb` requires everything
under `lib/mug/array/`). Follow that pattern when adding to a subdirectory.

## Licence

ISC. See `LICENSE`.
