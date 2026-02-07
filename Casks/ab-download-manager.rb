cask "ab-download-manager" do
  on_macos do
    arch arm: "arm64", intel: "x64"

    version "1.8.5"
    sha256 arm:   "714bc139c79eca0c6c2d131fa8a9c0957bef49c01bc23adf92ca5d7f91639939",
           intel: "e0772838927175eb0d383d272561a94917c827f26fa490b5c9796bd13e0243ec"

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
    version "1.8.5"
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
