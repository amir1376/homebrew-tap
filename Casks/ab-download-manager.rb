cask "ab-download-manager" do
  on_macos do
    arch arm: "arm64", intel: "x64"

    version "1.10.1"
    sha256 arm:   "4424c95707c145849627b0436146d348bfd3674d97e0649051db74336f705daf",
           intel: "3cb0ae9f938123892e02be1d9455998ce4a6f67b9e75466fb60b05b427610808"

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
    version "1.10.1"
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
