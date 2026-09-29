cask "pebrel" do
  arch arm: "arm64", intel: "x64"

  version "2.0.0"
  sha256 arm:   "eb3a4f758f53e2571bcd9c0cbbb2560c8d43c2e4446cadac65487594a5ccc778",
         intel: "6698b0e04b395ca99a1e33fbb3382d9c95886f07e80c85c6fb9ac794150e3e3e"

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
