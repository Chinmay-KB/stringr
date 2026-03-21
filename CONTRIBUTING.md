# Contributing to stringr

Thanks for helping improve `stringr`. The goal of this project is to be a reliable, Unicode-aware string manipulation library for Dart and Flutter, so contributions that improve correctness, clarity, documentation, and edge-case coverage are all valuable.

## Ways to contribute

- Fix bugs or improve correctness
- Add or improve tests, especially Unicode-heavy cases
- Improve performance or reduce unnecessary allocations
- Clarify API docs, README examples, or package metadata
- Propose new APIs with clear use cases and examples

## Development setup

1. Fork the repository.
2. Clone your fork:
   `git clone https://github.com/YOUR_USERNAME/stringr.git`
3. Move into the project directory:
   `cd stringr`
4. Install dependencies:
   `dart pub get`
5. Run the test suite:
   `dart test`
6. Run static analysis:
   `dart analyze`

## Workflow

1. Create a branch for your change:
   `git checkout -b feature/short-description`
2. Make your change in small, reviewable commits.
3. Add or update tests when behavior changes.
4. Run the checks before opening a PR:
   - `dart format .`
   - `dart analyze`
   - `dart test`
5. Open a pull request with a clear explanation of the problem, solution, and any tradeoffs.

## What we look for

### Correctness first

String handling gets tricky quickly. Please prefer behavior that is:

- Unicode-aware
- explicit about limitations
- backed by tests
- consistent across similar APIs

If a change affects word boundaries, graphemes, casing, diacritics, transliteration, or slug generation, include examples covering more than plain ASCII where practical.

### Tests

Please add tests for:

- the main happy path
- at least one edge case
- Unicode or non-Latin inputs when relevant
- regressions for any reported bug

Good examples include:

- accented Latin text
- Cyrillic, Greek, or other non-Latin scripts
- emoji and grapheme clusters
- mixed separators and casing inputs such as `XMLHttpRequest`

### API changes

If you are proposing a new method or changing behavior, include:

- the use case
- example input and output
- how it compares to existing methods
- any compatibility or migration concerns

For breaking changes, please open an issue or discussion first unless the fix is clearly necessary.

## Documentation expectations

Please update documentation when needed:

- README examples for user-facing features
- inline docs for public API changes
- CHANGELOG entries for notable changes

## Pull request checklist

Before submitting a PR, make sure that:

- code is formatted with `dart format .`
- `dart analyze` passes
- `dart test` passes
- new behavior is covered by tests
- docs are updated when needed
- the PR description explains the change clearly

## Commit message suggestions

Conventional-style messages are welcome, for example:

- `feat: add grapheme-safe trimming helper`
- `fix: handle combining marks in slugify`
- `docs: expand unicode examples in readme`
- `test: add regression coverage for emoji splitting`

## Reporting issues

Please use the GitHub issue templates when possible. The most helpful reports include:

- Dart and Flutter versions
- package version
- platform or runtime details if relevant
- a minimal reproducible example
- expected behavior
- actual behavior

If the issue involves a Unicode edge case, include the exact input string and output you expected.

## Security

For security-sensitive reports, please follow the guidance in `SECURITY.md` instead of opening a public issue.

## Questions and support

For usage questions, ideas, or general help, see `SUPPORT.md`.
