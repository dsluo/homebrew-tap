cask "opendeck" do
  arch arm: "aarch64", intel: "x64"

  version "2.14.0"
  sha256 arm:   "5130d4e65e5511deffdf0f07665d615d9607abff63562bdcae07a6040fda0f8e",
         intel: "ae3125aa05d34db2c14c5a400a4b4e9b6a13706b8a7043c1a430b8fee7ad04d7"

  url "https://github.com/nekename/OpenDeck/releases/download/v#{version}/OpenDeck_#{version}_#{arch}.dmg"
  name "OpenDeck"
  desc "Stream Deck software with support for Elgato Stream Deck plugins"
  homepage "https://github.com/nekename/OpenDeck"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "OpenDeck.app"

  zap trash: [
    "~/Library/Application Support/opendeck",
    "~/Library/Caches/opendeck",
    "~/Library/Logs/opendeck",
    "~/Library/WebKit/opendeck",
  ]

  caveats <<~EOS
    #{token} is not notarized, so macOS will block it on first launch.
    Allow it in System Settings → Privacy & Security, or run:
      xattr -dr com.apple.quarantine #{appdir}/OpenDeck.app

    Plugins built only for Windows also need Wine:
      brew install --cask wine-stable
  EOS
end
