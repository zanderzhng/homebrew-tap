cask "codexplusplus" do
  arch arm: "arm64", intel: "x64"

  version "1.2.36"
  sha256 arm:   "0a510e8154ad5e4388660530fc4c6f9ededcb01e382bc60fa09ddb5d306bab10",
         intel: "f9ba9ea61e9deeeb8747ab67c5a80cad90f5e389bccac2b93fb84c0abe58e809"

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

  caveats <<~EOS
    The upstream macOS apps are currently unsigned and unnotarized.
    Review the upstream project before installing, then use Homebrew's
    explicit --no-quarantine option if you accept that risk.
  EOS
end
