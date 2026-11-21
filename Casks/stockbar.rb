cask "stockbar" do
  version "1.4.1"
  sha256 "711717b08f2c9a70b167d78f72bbfef787717bc8d01e4cff7caf486174075181"

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
