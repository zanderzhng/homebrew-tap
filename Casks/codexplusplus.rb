cask "codexplusplus" do
  arch arm: "arm64", intel: "x64"

  version "1.5.2"
  sha256 arm:   "008b6fdc07a719eeba67d3988a4f264a9c4eeee3108a85af6bd0ed870a5383c7",
         intel: "5c13508a7224c5406df1b9408f6350905c3ef86efd1d51c1723131a2b8221b39"

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
