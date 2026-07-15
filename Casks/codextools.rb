cask "codextools" do
  arch arm: "arm64", intel: "x64"

  version "1.2.5"
  sha256 arm:   "a29fce094101541fe82c82eb72d9a77da4489ce3a85070808d93606aa250e8c7",
         intel: "74e948c25a7db7ff354a4f4806a13f6401f4b42f0b16bcd06506d6444e6175a0"

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
