cask "ab-download-manager" do
  arch arm: "arm64", intel: "x64"

  version "1.8.0"
  sha256 arm:   "bb82e1ee4d634bd80618571935a236ab556646a945607beae312c4db16c43b12",
         intel: "dc331039b29e89588b28bb775187b9db3e8472368a00f3b4de5e882fae8f012a"

  url "https://github.com/amir1376/ab-download-manager/releases/download/v#{version}/ABDownloadManager_#{version}_mac_#{arch}.dmg",
      verified: "github.com/amir1376/ab-download-manager/"
  name "AB Download Manager"
  desc "Download manager that speeds up your downloads"
  homepage "https://abdownloadmanager.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "ABDownloadManager.app"
end
