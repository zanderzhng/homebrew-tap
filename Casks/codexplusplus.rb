cask "codexplusplus" do
  arch arm: "arm64", intel: "x64"

  version "1.2.45"
  sha256 arm:   "6587cccbb35ba53c915da5525af2c8eb2642b0985919b42d30a1b2c85c2960b9",
         intel: "6245718b592dcb428fb2f41c1087e2f9b380cd148457d2f50529c86db0a54d32"

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
