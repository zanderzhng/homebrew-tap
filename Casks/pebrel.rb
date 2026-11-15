cask "pebrel" do
  arch arm: "arm64", intel: "x64"

  version "2.5.8"
  sha256 arm:   "43e386f17c7cf5b56af478ea0bd93491ac3d5c77482c92636d1456f8385932f2",
         intel: "b1f5b4aa3b7d23b54969c5f499b9a2850a4f2fd5f6a328b3ae04b21f927ce5d8"

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
