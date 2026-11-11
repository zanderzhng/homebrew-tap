cask "stockbar" do
  version "1.4.0"
  sha256 "4f01b6bc121c492e9f29553eb90c53bc24f5e2c68ed30bcc38465601d59daff2"

  url "https://github.com/VGEAREN/Stockbar/releases/download/v#{version}/Stockbar-v#{version}.dmg"
  name "Stockbar"
  desc "Menu bar stock tracker for A-share, Hong Kong, and US markets"
  homepage "https://github.com/VGEAREN/Stockbar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Stockbar.app"

  zap trash: [
    "~/Library/Application Support/Stockbar",
    "~/Library/Preferences/com.vgearen.Stockbar.plist",
  ]
end
