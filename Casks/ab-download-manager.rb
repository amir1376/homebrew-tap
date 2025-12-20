cask "ab-download-manager" do
  arch arm: "arm64", intel: "x64"

  version "1.8.1"
  sha256 arm:   "053920bd7a9baedf1f745811d46ce43bf30555d68f1a4765785a308031f6063b",
         intel: "3781dfde05a697a6d1dea7014ce05800eb3934746031428e337d365aca5a4b83"

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
