cask "codexplusplus" do
  arch arm: "arm64", intel: "x64"

  version "1.2.55"
  sha256 arm:   "f24f517c61dfdd6a06b03e001907b74175e86fc524314e1d692cc5985906337d",
         intel: "9cd2498d1edf1e5cfc56ed789d068e0165b55d3dde10759feaa9362422a89b24"

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
