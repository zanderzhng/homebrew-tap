cask "pebrel" do
  arch arm: "arm64", intel: "x64"

  version "2.2.1"
  sha256 arm:   "33aa6fd44e3c9184f5d321e8800e378d686ffefcd846f21943c646dfc272bfeb",
         intel: "884606ba07eb61884c3f781dbd702b51437a556f174db777e490c8a5a38f70e3"

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
