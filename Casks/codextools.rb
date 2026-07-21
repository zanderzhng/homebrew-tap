cask "codextools" do
  arch arm: "arm64", intel: "x64"

  version "1.2.6"
  sha256 arm:   "8175defbf5d532c205219893812b5333587a0fb5e0e068b473e15db1cf67342b",
         intel: "4fbd79704bd24808c5888cf0a36d61b9146df0aada39e4c6100774ac19016708"

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
