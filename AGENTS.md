# AGENTS.md

Instructions for coding agents working on this repository.

## Project

`ueberauth_bexio` — an [Überauth](https://github.com/ueberauth/ueberauth) strategy for
[Bexio](https://www.bexio.com/) OAuth2 authentication, published on Hex.pm as
[`ueberauth_bexio`](https://hex.pm/packages/ueberauth_bexio).

Key files:

- `lib/ueberauth/strategy/bexio.ex` — the strategy (request/callback handling, scopes)
- `lib/ueberauth/strategy/bexio/oauth.ex` — the OAuth2 client setup
- `mix.exs` — version (`@version`), package metadata, deps
- `CHANGELOG.md` — [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format, keep an `[Unreleased]` section on top
- `.github/workflows/hex.yml` — publishes to Hex.pm on tag push (test → dialyzer → credo → publish)

## Environment setup (this machine)

- Elixir/Erlang via **asdf**, pinned in `.tool-versions` (Elixir 1.17.3-otp-27, Erlang 27.1.3).
  `export PATH="$HOME/.asdf/bin:$HOME/.asdf/shims:$PATH"` first.
- The machine sits behind a TLS-intercepting proxy that Erlang's SSL rejects. For **every**
  mix command use:
  ```bash
  MIX_REBAR3=~/.mix/rebar3 HEX_UNSAFE_HTTPS=1 mix <task>
  ```
  Hex is installed from a local archive; rebar3 is a pre-downloaded binary at `~/.mix/rebar3`.
  `curl` works fine through the proxy — use it for any direct downloads (hex archives, etc.).

## Common commands

```bash
mix test            # run the test suite
mix credo --no-color
mix dialyzer
mix hex.build       # dry-run package build, never publishes
```

## Conventions

- Format with `mix format`; keep credo and dialyzer clean.
- README.md and CHANGELOG.md are shipped in the Hex package — keep them accurate.
- Releases: see the project skill at `.agents/skills/release/SKILL.md` (`/skill:release`).
  Publishing happens through the tag-triggered GitHub Actions workflow, not locally.

## Commit conventions

- Every commit message follows [Conventional Commits](https://www.conventionalcommits.org/):
  `type(optional-scope): description` in imperative mood, e.g. `fix: handle nil article_type`.
- Types in use: `feat`, `fix`, `docs`, `test`, `refactor`, `perf`, `chore`, `ci`.
- Breaking changes use `!` before the colon (`feat!: ...`) plus a `BREAKING CHANGE: <description>`
  footer explaining the breakage and the migration path.
- The description of a `fix` commit should describe the observable behaviour, not the code change.

## Changelog conventions

- `CHANGELOG.md` follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/):
  - a `## [Unreleased]` section sits at the top; changes are accumulated there while developing,
  - on release, `Unreleased` becomes `## [X.Y.Z] - YYYY-MM-DD` (ISO date),
  - entries are grouped under `### Added`, `### Changed`, `### Fixed`, `### Removed`,
    `### Deprecated`, `### Security`,
  - breaking changes are listed first under `### Changed` with a bold **BREAKING** marker
    and a migration note,
  - each version has a compare-link in the footer at the bottom of the file.
- While developing, add the CHANGELOG entry for a user-visible change in the same commit
  as the change itself.

## Release / versioning

- This is a Hex package (version in `mix.exs`), published automatically by GitHub Actions
  (`.github/workflows/hex.yml`) **on git tag push**. The workflow runs `mix test`,
  `mix dialyzer`, `mix credo`, then `mix hex.publish --yes`.
- Release procedure: move `CHANGELOG.md`'s `Unreleased` entries into a new `[X.Y.Z] - YYYY-MM-DD`
  section, bump `version` in `mix.exs`, commit as `chore: release vX.Y.Z`, `git tag vX.Y.Z`,
  push commit + tag.
- Version policy: SemVer. Breaking changes require a major version bump, new features a minor,
  bugfixes a patch. Breaking changes must be marked with `!` in the commit, a
  `BREAKING CHANGE:` footer, and a bold **BREAKING** entry in the CHANGELOG.
- Never publish manually with `mix hex.publish` locally unless the CI route is unavailable.
