cask "codextools" do
  arch arm: "arm64", intel: "x64"

  version "1.2.7"
  sha256 arm:   "bc71685934c9bec13b60b67f09b320810a01b7ba9455155c81769d52cc1c5cd7",
         intel: "8e4602c153ba2a6b28c0433f0aadc0e06b49c33bd3b818a09dbef69c4a259d5f"

  url "https://github.com/hereww/codextools/releases/download/v#{version}/ChatGPT-Codex-Tools-#{version}-macos-#{arch}.zip"
  name "ChatGPT Codex Tools"
  name "ChatGPT Codex 管理工具"
  desc "Desktop control center for ChatGPT Codex"
  homepage "https://github.com/hereww/codextools"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "ChatGPT-Codex-Tools-#{version}-macos-#{arch}/ChatGPT Codex.app"
  app "ChatGPT-Codex-Tools-#{version}-macos-#{arch}/ChatGPT Codex 管理工具.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: [
                     "-dr",
                     "com.apple.quarantine",
                     "#{appdir}/ChatGPT Codex.app",
                     "#{appdir}/ChatGPT Codex 管理工具.app",
                   ]
  end

  caveats <<~EOS
    This cask automatically removes macOS quarantine from both installed apps.
    Upstream's apps are ad-hoc signed and unnotarized, so install them only if
    you trust the upstream project.
  EOS
end
