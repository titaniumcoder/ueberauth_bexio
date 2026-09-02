---
name: release
description: Release ueberauth_bexio to Hex.pm. Updates documentation, generates the changelog from the git log, updates README.md and AGENTS.md, bumps the version in mix.exs, runs the test suite, tags the release, and publishes to Hex.pm via the GitHub Actions tag-triggered workflow. Use when the user says "release", "cut a release", "publish to hex", or asks to ship a new version.
---

# Release ueberauth_bexio

Releases are published to Hex.pm by GitHub Actions (`.github/workflows/hex.yml`) whenever a tag
matching `*` is pushed to `origin`. Never run `mix hex.publish` locally — the `HEX_API_KEY` only
exists in CI.

## Environment setup (this machine)

Elixir/Erlang are managed with asdf (see `.tool-versions`). Because of the TLS-intercepting proxy,
Erlang's SSL rejects hex.pm certificates, and `mix` cannot download Hex/Rebar itself. Use these
env vars and pre-installed tools for every mix command:

```bash
export PATH="$HOME/.asdf/bin:$HOME/.asdf/shims:$PATH"
export MIX_REBAR3=~/.mix/rebar3
export HEX_UNSAFE_HTTPS=1
```

Hex itself is already installed from a local archive. If a fresh machine is missing it, download
the right `.ez` for the Elixir version from `https://builds.hex.pm/installs/hex-1.x.csv` with curl
(curl works fine through the proxy) and run `mix archive.install <file>`.

## Release steps

1. **Decide the version.** Ask the user if unclear; otherwise infer from the changelog since the
   last tag (`git log --oneline $(git describe --tags --abbrev=0)..HEAD`): fixes → patch,
   new features → minor, breaking → major. Current version lives in `@version` in `mix.exs`.

2. **Bump the version** in `mix.exs` (`@version "X.Y.Z"`).

3. **Update CHANGELOG.md.** Convert the `## (Unreleased)` section into `## vX.Y.Z` and fill it
   from the git log since the last tag (`git log --oneline <last-tag>..HEAD`), grouping into
   human-readable bullets (skip pure housekeeping commits). Keep an empty `## (Unreleased)`
   section on top.

4. **Update README.md.** The dependency snippet must show `{:ueberauth_bexio, "~> X.Y.0"}`
   matching the new version. While there, fix any stale links/badges you notice.

5. **Update AGENTS.md** if project structure, env setup, or workflows changed.

6. **Verify.** Run from the repo root:
   ```bash
   MIX_REBAR3=~/.mix/rebar3 HEX_UNSAFE_HTTPS=1 mix test
   MIX_REBAR3=~/.mix/rebar3 HEX_UNSAFE_HTTPS=1 mix credo --no-color
   MIX_REBAR3=~/.mix/rebar3 HEX_UNSAFE_HTTPS=1 mix dialyzer
   ```
   All three must pass. Also run `mix hex.build` (dry-run, does not publish) and sanity-check the
   package contents against the `files:` list in the `package/0` function of `mix.exs`.

7. **Commit and tag.**
   ```bash
   git add -A
   git commit -m "Release vX.Y.Z"
   git tag "vX.Y.Z"
   git push origin main "vX.Y.Z"
   ```

8. **Watch CI** (it runs test + dialyzer + credo, then publishes to Hex.pm):
   ```bash
   gh run watch   # or: gh run list --limit 1 && gh run view <id>
   ```
   If `gh` is unavailable, check `https://github.com/titaniumcoder/ueberauth_bexio/actions`.

9. **Confirm publication** at `https://hex.pm/packages/ueberauth_bexio` (or
   `curl -s https://hex.pm/api/packages/ueberauth_bexio | ...` and check the new version appears
   in `releases`). Report success or the failing CI step to the user.

## Failure handling

- If CI fails after the tag was pushed: fix, delete the tag
  (`git push origin :refs/tags/vX.Y.Z`), re-tag on the fix commit, and push again. Hex.pm will
  reject a re-publish of the same version, so if the package already went out you must bump the
  version instead.
- If a docs link or badge is broken in the published package, it can only be fixed in the next
  release — Hex packages are immutable.
