cask "pebrel" do
  arch arm: "arm64", intel: "x64"

  version "2.2.2"
  sha256 arm:   "2658e970643de72258cc483f0d2f0cda0f125298fe3b2871ced1b0f36542c84b",
         intel: "783ef14e8454c67d94c0231166e18270bf22711139db05456efc4e828d6dc48e"

  url "https://github.com/Kuddev/pebrel/releases/download/v#{version}/Pebrel-v#{version}-macos-#{arch}-preview.dmg"
  name "Pebrel"
  desc "GPU-accelerated terminal and AI CLI workspace"
  homepage "https://github.com/Kuddev/pebrel"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Pebrel.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args: [
          "-dr",
          "com.apple.quarantine",
          "{{appdir}}/Pebrel.app",
        ]
  end

  caveats <<~EOS
    This cask automatically removes macOS quarantine from Pebrel.app.
    Upstream's macOS preview build is ad-hoc signed and unnotarized, so install it
    only if you trust the upstream project. You may need to allow it in System
    Settings > Privacy & Security on first launch.
  EOS
end
