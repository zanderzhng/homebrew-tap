cask "codexplusplus" do
  arch arm: "arm64", intel: "x64"

  version "1.2.44"
  sha256 arm:   "91902ec67ca824065c6a8a290606dad699ad4d7f03a91c0bae5e174f3001ac38",
         intel: "4f3f7b9d2d1ae09ec3d5842034990d426b2616e672292e1eccf8250eb7e35e3c"

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
