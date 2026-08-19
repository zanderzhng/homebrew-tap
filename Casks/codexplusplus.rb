cask "codexplusplus" do
  arch arm: "arm64", intel: "x64"

  version "1.2.49"
  sha256 arm:   "b5781275d9b5702d137fbf1d0fcb98d8bad15f38629cbb13a0b0aabd89614f0c",
         intel: "a5d1d25ec285c55656ff621cc0321c411eb9a00f784444657c2674603f92fe51"

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
