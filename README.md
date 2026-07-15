# Zander's Homebrew Tap

Personal Homebrew packages maintained by Zander Zhang.

## CodexPlusPlus

This tap installs the two macOS apps published by
[BigPizzaV3/CodexPlusPlus](https://github.com/BigPizzaV3/CodexPlusPlus):

- `Codex++.app`
- `Codex++ 管理工具.app`

Install them with:

```bash
brew tap zanderzhng/tap
brew install --cask zanderzhng/tap/codexplusplus
```

Upstream currently describes its macOS apps as unsigned and unnotarized.
If macOS blocks either app, review and trust the upstream project before
manually removing Apple's quarantine attribute. For Homebrew's default app
directory:

```bash
xattr -dr com.apple.quarantine "/Applications/Codex++.app"
xattr -dr com.apple.quarantine "/Applications/Codex++ 管理工具.app"
```

Use your configured cask app directory instead of `/Applications` when it
differs.

## Updates

GitHub Actions checks the latest stable upstream release every day. When a new
release contains both required Mac DMGs, the workflow temporarily downloads
them, calculates their SHA-256 checksums, validates the cask, and commits the
updated version and checksums.

The DMGs always download directly from the upstream CodexPlusPlus GitHub
release. This repository does not contain, upload as workflow artifacts, or
republish those binaries.

## License

The tap metadata and automation are available under the [MIT License](LICENSE).
CodexPlusPlus is a separate upstream project distributed under its own AGPL
license.
