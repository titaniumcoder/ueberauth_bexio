# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.4.0] - 2026-09-02

### Changed

- Moved ownership to the [titaniumcoder](https://github.com/titaniumcoder/ueberauth_bexio) repository structure
- Documentation fixes (badges, links)

## [0.3.0] - 2025-01-19

### Added

- `company_id`, `company_user_id`, and `company_name` are now part of the `raw_info` in `Ueberauth.Auth.Extra`

### Changed

- Removed parsing the JWT token; `company_id`, `company_name`, and `uid` are now read from the userinfo endpoint

## [0.2.1] - 2025-01-16

### Changed

- `company_profile` in default scopes to keep with current logic

### Fixed

- Further adaptation to the new endpoint logic

## [0.2.0] - 2025-01-16

### Changed

- Updated the OAuth2 logic from idp to the new auth endpoint

## [0.1.6] - 2025-01-14

### Added

- Dialyzer and Credo

### Fixed

- SSL bugfix

## [0.1.5] - 2024-08-29

### Fixed

- Naming fixes

## [0.1.4] - 2024-08-29

### Added

- Company id and login id under the raw user info (extra)

## [0.1.3] - 2024-06-20

### Added

- Company id

## [0.1.2] - 2024-06-20

### Added

- Parsed JWT token added to raw info because company_id and login_id combined are unique

## [0.1.1] - 2024-05-09

### Fixed

- Pipeline fixes

## [0.1.0] - 2024-05-09

### Added

- Initial release

[Unreleased]: https://github.com/titaniumcoder/ueberauth_bexio/compare/v0.4.0...HEAD
[0.4.0]: https://github.com/titaniumcoder/ueberauth_bexio/compare/0.3.0...v0.4.0
[0.3.0]: https://github.com/titaniumcoder/ueberauth_bexio/compare/0.2.1...0.3.0
[0.2.1]: https://github.com/titaniumcoder/ueberauth_bexio/compare/0.2.0...0.2.1
[0.2.0]: https://github.com/titaniumcoder/ueberauth_bexio/compare/0.1.6...0.2.0
[0.1.6]: https://github.com/titaniumcoder/ueberauth_bexio/compare/0.1.5...0.1.6
[0.1.5]: https://github.com/titaniumcoder/ueberauth_bexio/compare/0.1.4...0.1.5
[0.1.4]: https://github.com/titaniumcoder/ueberauth_bexio/compare/0.1.3...0.1.4
[0.1.3]: https://github.com/titaniumcoder/ueberauth_bexio/compare/0.1.2...0.1.3
[0.1.2]: https://github.com/titaniumcoder/ueberauth_bexio/compare/0.1.1...0.1.2
[0.1.1]: https://github.com/titaniumcoder/ueberauth_bexio/compare/0.1.0...0.1.1
[0.1.0]: https://github.com/titaniumcoder/ueberauth_bexio/releases/tag/0.1.0
