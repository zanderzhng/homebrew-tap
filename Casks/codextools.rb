cask "codextools" do
  arch arm: "arm64", intel: "x64"

  version "1.2.10"
  sha256 arm:   "4038027329ba519eb7ab83510236ddc60d54a36677155bd742219b32ad4ea7a6",
         intel: "973ac22b9ca91785585c1ee3b9cc694c1aeb4a63be8ad447ee76a11d272a3ecf"

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

  postflight_steps do
    run "/usr/bin/xattr",
        args: [
          "-dr",
          "com.apple.quarantine",
          "{{appdir}}/ChatGPT Codex.app",
          "{{appdir}}/ChatGPT Codex 管理工具.app",
        ]
  end

  caveats <<~EOS
    This cask automatically removes macOS quarantine from both installed apps.
    Upstream's apps are ad-hoc signed and unnotarized, so install them only if
    you trust the upstream project.
  EOS
end
