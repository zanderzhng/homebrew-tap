cask "codextools" do
  arch arm: "arm64", intel: "x64"

  version "1.2.9"
  sha256 arm:   "cc3a16961ffe8686ff56c69d61f8c999d0da4b972b0b0344a566378eaa4b66ff",
         intel: "d914aff197793b8bc99a9bdab088bb9087e888aee7c26d273443cb60b7f8dab1"

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
