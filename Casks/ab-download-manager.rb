cask "ab-download-manager" do
  on_macos do
    arch arm: "arm64", intel: "x64"

    version "1.9.1"
    sha256 arm:   "68f94ebf9c95e8cd751cd6bd76995d4f559ee4cdaac8476dd58419944d457d28",
           intel: "ebe57f0f2e97459a51bb0f0fffd2e9fb0f67a870316620f3772f17a32d946272"

    url "https://github.com/amir1376/ab-download-manager/releases/download/v#{version}/ABDownloadManager_#{version}_mac_#{arch}.dmg",
        verified: "github.com/amir1376/ab-download-manager/"
    name "AB Download Manager"
    desc "Download manager that speeds up your downloads"
    homepage "https://abdownloadmanager.com/"

    livecheck do
      url :url
      strategy :github_latest
    end

    auto_updates true

    app "ABDownloadManager.app"

    uninstall_postflight do
      system_command "/usr/bin/pkill",
                     args:         ["-f", "ABDownloadManager.app"],
                     must_succeed: false
    end

    uninstall quit:       "com.abdownloadmanager.desktop",
              login_item: "ABDownloadManager",
              delete:     "~/Library/LaunchAgents/AB Download Manager.plist"

    zap trash: [
      "~/.abdm",
      "~/Library/Preferences/com.abdownloadmanager.desktop.desktop.plist",
    ]
  end

  on_linux do
    version "1.9.1"
    sha256 :no_check

    url "https://raw.githubusercontent.com/amir1376/ab-download-manager/master/scripts/install.sh"
    name "AB Download Manager"
    desc "Download manager that speeds up your downloads"
    homepage "https://abdownloadmanager.com/"

    installer script: {
      executable: "bash",
      args:       [
        "-c",
        "curl -fsSL https://raw.githubusercontent.com/amir1376/ab-download-manager/master/scripts/install.sh | bash",
      ],
    }

    uninstall script: {
      executable: "bash",
      args:       [
        "-c",
        "curl -fsSL " \
        "https://raw.githubusercontent.com/amir1376/ab-download-manager/master/scripts/uninstall.sh | bash",
      ],
    }
  end
end
