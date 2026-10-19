# Contributing

## Pull Requests Welcome

1. Fork ueberauth_bexio
2. Create a topic branch
3. Make logically-grouped commits with clear commit messages
4. Push commits to your fork
5. Open a pull request against ueberauth_bexio/main

## Commit messages

Commit messages follow [Conventional Commits](https://www.conventionalcommits.org/):
`type(optional-scope): description` in imperative mood, e.g. `fix: handle nil company_id`.
Types in use: `feat`, `fix`, `docs`, `test`, `refactor`, `perf`, `chore`, `ci`. Breaking
changes use `!` before the colon (`feat!: ...`) plus a `BREAKING CHANGE: <description>`
footer explaining the breakage and the migration path.

## Changelog

User-visible changes get an entry under `## [Unreleased]` in `CHANGELOG.md`, grouped under
`### Added` / `### Changed` / `### Fixed` / `### Removed` (Keep a Changelog format),
added in the same commit as the change itself.

## Issues

If you believe there to be a bug, please provide the maintainers with enough
detail to reproduce or a link to an app exhibiting unexpected behavior.