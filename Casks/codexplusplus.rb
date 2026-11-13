cask "codexplusplus" do
  version "2.6.7"
  sha256 "35e4bb3e3744423934ba23a86df2921a4eb58830185912a86a77178655bfb96b"

  url "https://github.com/BigPizzaV3/CodexPlusPlus/releases/download/v#{version}/CodexPlusPlus-#{version}-macos-universal.dmg"
  name "Codex++"
  name "Codex++ 管理工具"
  desc "Launcher and management tool for the Codex desktop app"
  homepage "https://github.com/BigPizzaV3/CodexPlusPlus"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "Codex++.app"
  app "Codex++ 管理工具.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args: [
          "-dr",
          "com.apple.quarantine",
          "{{appdir}}/Codex++.app",
          "{{appdir}}/Codex++ 管理工具.app",
        ]
  end

  caveats <<~EOS
    This cask automatically removes macOS quarantine from both installed apps.
    Upstream's apps are ad-hoc signed and unnotarized, so install them only if
    you trust the upstream project.
  EOS
end
