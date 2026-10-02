cask "codexplusplus" do
  arch arm: "arm64", intel: "x64"

  version "1.5.0"
  sha256 arm:   "0c8461283b57d869eab09078f100a71d6585240b72cc3b87b70b174acf0a9a86",
         intel: "060093beefc3df8da9e77ec54cf2e060549cb7db641b442d0f3fa4c08ff7566b"

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
