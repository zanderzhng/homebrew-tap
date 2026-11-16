cask "pebrel" do
  arch arm: "arm64", intel: "x64"

  version "2.5.9"
  sha256 arm:   "8c4a72156f5aad2682c8cfb21964d1393be36d9aa29ac5ecb150b3560e68d56f",
         intel: "ca6221af6e2866359d5849a03198d270fc96de7ca78ba757f5d97291716d6967"

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
