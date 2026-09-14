cask "3dxware" do
  version "10.8.12,3901,6B667FEC"
  sha256 "f8dac191c24fa566732e95dda0adcd4eafe27e79641fd268c9638bb47565c511"

  url "https://download.3dconnexion.com/drivers/mac/#{version.csv.first.dots_to_hyphens}_#{version.csv.third}/3DxWareMac_v#{version.csv.first.dots_to_hyphens}_r#{version.csv.second}.dmg"
  name "3DxWare"
  name "3DxWare 10"
  name "3Dconnexion software"
  desc "Driver and utilities for 3Dconnexion 3D mice"
  homepage "https://3dconnexion.com/"

  livecheck do
    skip "Vendor download page is behind Cloudflare bot protection"
  end

  depends_on macos: :monterey

  pkg "Install 3Dconnexion software.pkg"

  uninstall launchctl: [
              "com.3dconnexion.helper",
              "com.3dconnexion.nlserverIPalias",
            ],
            quit:      [
              "com.3dconnexion.3DMouseHome",
              "com.3dconnexion.driver.helper",
              "com.3dconnexion.nlserver",
              "com.3dconnexion.Pairing",
              "com.3dconnexion.RadialMenu",
              "com.3dconnexion.VirtualNumPad",
            ],
            script:    {
              executable:   "/bin/sh",
              args:         [
                "-c",
                "helper=/Applications/3DconnexionHelper.app/Contents/MacOS/3DconnexionHelper; " \
                "[ -x \"$helper\" ] && exec \"$helper\" -uninstall",
              ],
              must_succeed: false,
              sudo:         true,
            },
            pkgutil:   "com.3dconnexion.*",
            delete:    [
              "/Applications/3Dconnexion",
              "/Applications/3DconnexionHelper.app",
              "/Applications/3DconnexionUninstaller.app",
              "/Library/Application Support/3Dconnexion",
              "/Library/Frameworks/3DconnexionClient.framework",
              "/Library/Frameworks/3DconnexionNavlib.framework",
              "/Library/LaunchAgents/com.3dconnexion.helper.plist",
              "/Library/LaunchDaemons/com.3dconnexion.nlserverIPalias.plist",
              "/Library/PreferencePanes/3Dconnexion.prefPane",
            ]

  zap trash: [
    "~/Library/Application Support/3Dconnexion",
    "~/Library/Preferences/3Dconnexion",
    "~/Library/Preferences/com.3[Dd]connexion*.plist",
  ]

  caveats do
    reboot
    <<~EOS
      #{token} installs a driver extension that macOS blocks until you
      approve it in:
        System Settings → Privacy & Security

      Your 3D mouse will not be detected until the extension is approved.
    EOS
  end
end
