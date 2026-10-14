cask "opendeck" do
  arch arm: "aarch64", intel: "x64"

  version "2.14.1"
  sha256 arm:   "d290ccdaf22c0c2735120e27de193da53a59ca7537093284c0fb7fb4c33d80a3",
         intel: "6476b95b5f136510c7646beb7974c2cc4d054a2a3c6a0e319e31c606215bd536"

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
