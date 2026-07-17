cask "codexplusplus" do
  arch arm: "arm64", intel: "x64"

  version "1.2.38"
  sha256 arm:   "22b173b1cdfdffbbf447b8a8c29767031b25f6f5a0fe22bcc83ae5f64a7734c7",
         intel: "139deb521e82b72423abad7de7bbaa9df3bea030652cb3d01f7e5fde8057058d"

  url "https://github.com/BigPizzaV3/CodexPlusPlus/releases/download/v#{version}/CodexPlusPlus-#{version}-macos-#{arch}.dmg"
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

  postflight do
    system_command "/usr/bin/xattr",
                   args: [
                     "-dr",
                     "com.apple.quarantine",
                     "#{appdir}/Codex++.app",
                     "#{appdir}/Codex++ 管理工具.app",
                   ]
  end

  caveats <<~EOS
    This cask automatically removes macOS quarantine from both installed apps.
    Upstream's apps are ad-hoc signed and unnotarized, so install them only if
    you trust the upstream project.
  EOS
end
