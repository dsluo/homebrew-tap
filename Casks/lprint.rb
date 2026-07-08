cask "lprint" do
  version "1.4.0"
  sha256 "e0d0a478586d2f3e406c44e925e31c3c657f1f5b7c60d539a5984dd45524a408"

  url "https://github.com/michaelrsweet/lprint/releases/download/v#{version}/lprint-#{version}-macos.pkg",
      verified: "github.com/michaelrsweet/lprint/"
  name "LPrint"
  desc "Label printer application"
  homepage "https://www.msweet.org/lprint/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  pkg "lprint-#{version}-macos.pkg"

  uninstall pkgutil: "org.msweet.lprint"
end
