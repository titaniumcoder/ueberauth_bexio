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
- `CHANGELOG.md` — one section per release, keep an `(Unreleased)` section on top
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
- **Never install system packages yourself (apt/sudo). Ask the user** to run installs.

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
