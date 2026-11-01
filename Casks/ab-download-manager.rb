cask "ab-download-manager" do
  on_macos do
    arch arm: "arm64", intel: "x64"

    version "1.11.2"
    sha256 arm:   "4b67b2f5c0a59f50de14b624032b20528a6124bfb08d367f437151123ce35809",
           intel: "661f9b876ce25ac9c17e236a166b35ed0bec172876c3b2c54b55643e15bcc72d"

    url "https://github.com/amir1376/ab-download-manager/releases/download/v#{version}/ABDownloadManager_#{version}_mac_#{arch}.dmg"
    name "AB Download Manager"
    desc "Download manager that speeds up your downloads"
    homepage "https://abdownloadmanager.com/"

    livecheck do
      url :url
      strategy :github_latest
    end

    auto_updates true

    app "ABDownloadManager.app"

    uninstall_postflight_steps do
      run "/usr/bin/pkill",
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
    version "1.10.4"
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
