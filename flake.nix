{
  description = "StandAloneComplexs-MacBook-Pro Darwin system flake";
  # # /usr/sbin/softwareupdate --install-rosetta --agree-to-license

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };
    # Warning: The Intel Homebrew prefix has been set up, but Rosetta isn't installed yet.
    # ==> Run ${tty_bold}softwareupdate --install-rosetta${tty_reset} to install it.
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    # Optional: Declarative tap management
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew,
    homebrew-bundle, homebrew-cask, homebrew-core, ... }:
  let
    configuration = { pkgs, config, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
        # pkgs.vim
        pkgs.any-nix-shell
        pkgs.ascii-image-converter
        pkgs.atuin
        pkgs.autoconf pkgs.autoconf-archive pkgs.automake pkgs.gnum4 pkgs.libtool pkgs.texi2html
        pkgs.avfs
        pkgs.bash-preexec pkgs.bash_unit pkgs.bashate pkgs.bats pkgs.checkbashisms pkgs.blesh pkgs.shellcheck pkgs.shellcheck-sarif pkgs.shellharden pkgs.shellspec pkgs.shfmt
        pkgs.bat pkgs.bat-extras.batdiff pkgs.bat-extras.batgrep pkgs.bat-extras.batman pkgs.bat-extras.batpipe pkgs.bat-extras.batwatch pkgs.bat-extras.prettybat
        pkgs.binutils-unwrapped-all-targets
        pkgs.btop
        pkgs.bun
        pkgs.bzip2
        pkgs.ccache pkgs.ccls pkgs.clang-analyzer pkgs.clang-manpages pkgs.clang-tools pkgs.lldb pkgs.llvm # pkgs.gcc pkgs.llvm-manpages
        pkgs.chafa
        pkgs.clipse
        pkgs.clojure pkgs.clojure-lsp pkgs.cq pkgs.guile pkgs.guile-lib pkgs.racket pkgs.roswell # pkgs.corepack_latest pkgs.typescript
        pkgs.coreutils-full
        pkgs.curlFull
        pkgs.dart pkgs.dart-sass pkgs.stylelint pkgs.tailwindcss pkgs.tailwindcss-language-server # pkgs.darwin.xcode
        pkgs.dbus
        pkgs.deno
        pkgs.e2fsprogs
        pkgs.editorconfig-core-c pkgs.editorconfig-checker
        pkgs.erlang_27 pkgs.erlang-ls pkgs.erlfmt pkgs.lfe pkgs.rebar3 pkgs.elixir pkgs.elixir-ls pkgs.livebook pkgs.gleam
        pkgs.exercism
        pkgs.exiftool
        pkgs.eza
        pkgs.fastfetch
        pkgs.fd
        pkgs.ffmpeg_7-full pkgs.ffmpegthumbnailer pkgs.mediainfo pkgs.mediainfo-gui pkgs.mpc-cli pkgs.ncmpcpp pkgs.mpd pkgs.mpv
        pkgs.figlet
        pkgs.findutils
        pkgs.fortune pkgs.cowsay pkgs.ponysay pkgs.taoup pkgs.tewisay
        pkgs.fzf pkgs.fzf-git-sh pkgs.fzf-make pkgs.fzf-obc pkgs.fzf-zsh pkgs.gh-f pkgs.sysz pkgs.ytfzf pkgs.zsh-forgit pkgs.zsh-fzf-history-search
        pkgs.gettext
        pkgs.gitFull pkgs.gitui pkgs.gh pkgs.gist pkgs.lazygit pkgs.tig
        pkgs.gmp
        pkgs.gnugrep
        pkgs.gnupg pkgs.gpa pkgs.gpg-tui pkgs.pinentry_mac pkgs.cacert
        pkgs.go pkgs.gopls
        pkgs.gmp # pkgs.guix
        pkgs.gum
        pkgs.imagemagickBig pkgs.nsxiv
        pkgs.iterm2
        pkgs.jdk22 # pkgs.jellycli pkgs.jellyfin pkgs.jellyfin-ffmpeg pkgs.jellyfin-media-player pkgs.jellyfin-mpv-shim pkgs.jellyfin-web pkgs.jftui pkgs.mopidy-jellyfin
        pkgs.jq pkgs.jq-lsp pkgs.jq-zsh-plugin pkgs.json_c # pkgs.kodi
        pkgs.lazycli
        pkgs.lesspipe
        pkgs.lilypond-with-fonts
        pkgs.lolcat pkgs.dwt1-shell-color-scripts # pkgs.clolcat
        pkgs.lorri
        pkgs.lsd
        pkgs.lua54Packages.lua pkgs.lua-language-server pkgs.lua54Packages.luarepl pkgs.lua54Packages.luarocks pkgs.lua54Packages.fennel pkgs.fennel-ls pkgs.fnlfmt
        pkgs.mas
        pkgs.micro
        pkgs.mkalias
        pkgs.mmv
        pkgs.ncurses
        pkgs.neovim pkgs.neovim-remote pkgs.neovide # pkgs.netbird pkgs.netbird-ui
        pkgs.ninja
        pkgs.nix-zsh-completions pkgs.nixfmt-rfc-style
        #pkgs.nushell pkgs.nushellPlugins.formats pkgs.nushellPlugins.gstat pkgs.nushellPlugins.net pkgs.nushellPlugins.query pkgs.nu_scripts pkgs. nufmt
        pkgs.odin pkgs.ols
        pkgs.openssh_hpn
        pkgs.openssl
        pkgs.parallel-full
        pkgs.perl pkgs.perl538Packages.XMLParser pkgs.perl538Packages.CPAN pkgs.perl538Packages.CPANPLUS pkgs.rakudo pkgs.zef
        #pkgs.php83 pkgs.php83Packages.composer pkgs.php83Packages.phpstan pkgs.phpunit pkgs.laravel # pkgs.php83Packages.composer-local-repo-plugin pkgs.php83Packages.psysh
        pkgs.pkg-config
        pkgs.pngpaste
        pkgs.poppler pkgs.poppler_data pkgs.poppler_utils
        # pkgs.postgresql_16 pkgs.postgresql16Packages.postgis pkgs.postgresql16Packages.temporal_tables pkgs.postgresql16Packages.timescaledb pkgs.postgresql16Packages.timescaledb_toolkit # pkgs.pgadmin4 pkgs.pgadmin4-desktopmode
        pkgs.procps
        pkgs.progress
        pkgs.python313Full pkgs.pipx pkgs.rich-cli
        pkgs.ranger
        pkgs.ripgrep
        pkgs.rlwrap
        pkgs.ruby_3_3 pkgs.rubyPackages_3_3.rails pkgs.rubyPackages_3_3.ruby-lsp pkgs.rubyPackages_3_3.sass-listen pkgs.rubyPackages_3_3.sassc # pkgs.rubyPackages_3_3.sass
        pkgs.rustup
        pkgs.screen # pkgs.scribus
        pkgs.sheldon
        pkgs.sqlite pkgs.sqlite-utils pkgs.sqlite-web pkgs.sqlar pkgs.sqlcipher pkgs.sqldiff pkgs.spatialite_tools pkgs.lazysql
        pkgs.starship # pkgs.tailscale pkgs.tailscale-nginx-auth pkgs.tailscalesd
        pkgs.tcl pkgs.tclx pkgs.tix pkgs.tk pkgs.tkman
        pkgs.tealdeer
        pkgs.texliveFull
        pkgs.tigerbeetle  # pkgs.tmux
        pkgs.trash-cli
        pkgs.tree
        pkgs.tree-sitter
        pkgs.unar # pkgs.vcpkg pkgs.vcpkg-tool
        pkgs.wget # pkgs.wireguard-tools
        pkgs.yaml-language-server pkgs.yamlfmt pkgs.yamlscript pkgs.yq
        pkgs.yazi
        pkgs.yt-dlp pkgs.yt-dlg # pkgs.tartube-yt-dlp
        pkgs.yubico-pam pkgs.yubico-piv-tool pkgs.yubikey-agent pkgs.yubikey-manager # pkgs.yubikey-personalization pkgs.yubikey-personalization-gui # pkgs.yubikey-touch-detector
        pkgs.zellij # pkgs.zig pkgs.zig-shell-completions pkgs.zls pkgs.ztags
        pkgs.zlib
        pkgs.zoxide # pkgs.zsh
        #pkgs.zsh-abbr pkgs.zsh-autocomplete pkgs.zsh-autopair pkgs.zsh-autosuggestions pkgs.zsh-completions pkgs.zsh-f-sy-h pkgs.zsh-history-search-multi-word pkgs.zsh-history-substring-search pkgs.zsh-navigation-tools pkgs.zsh-you-should-use
        pkgs.zsh-nix-shell
        pkgs.zsh-zhooks
        pkgs.zstd
        pkgs.zunit
      ];

      fonts.packages = with pkgs; [
        alegreya
        iosevka
        iosevka-comfy.comfy iosevka-comfy.comfy-duo iosevka-comfy.comfy-fixed
        iosevka-comfy.comfy-motion iosevka-comfy.comfy-motion-duo iosevka-comfy.comfy-motion-fixed
        iosevka-comfy.comfy-wide iosevka-comfy.comfy-wide-duo iosevka-comfy.comfy-wide-fixed
        iosevka-comfy.comfy-wide-motion iosevka-comfy.comfy-wide-motion-duo iosevka-comfy.comfy-wide-motion-fixed
        nerdfonts
        open-dyslexic
        overpass
      ];

      homebrew = {
        enable = true;
        brews = [
          "autoenv"
          "fisher"
          "fizsh"
          "ghcup"
          "nushell"
          "opam"
          "yubikey-personalization"
          "zig" "zigmod"
          "zsh-lovers"
        ];
        casks = [
          "adium"
          "alfred"
          "amethyst"
          "arc"
          "BBEdit"
          "bitwarden"
          "blender" "blender-benchmark"
          "brewservicesmenubar"
          "chatgpt"
          "cmake"
          "copyq"
          "crossover"
          "cursor"
          "devtoys"
          "discord"
          "docker"
          "dotnet-sdk"
          "duckduckgo"
          "dyalog"
          "emacs@nightly"
          "emojipedia"
          "expressvpn"
          "flutter"
          "font-alegreya-sans-sc"
          "font-alegreya-sans"
          "font-alegreya-sc"
          "font-awesome-terminal-fonts"
          "font-fontawesome"
          "font-linux-biolinum"
          "font-monaspace-nerd-font"
          "font-monaspace"
          "font-open-dyslexic"
          "font-trispace"
          "font-zed-sans"
          "font-zen-antique-soft"
          "font-zen-dots"
          "font-zen-loop"
          "git-credential-manager"
          "github"
          "gitkraken" "gitkraken-cli"
          "godot" "godot-mono"
          "gpg-suite"
          "hammerspoon"
          "herd"
          "iina"
          "inkscape"
          "insync"
          "itermai"
          "jellyfin" "jellyfin-media-player"
          "jupyterlab"
          "karabiner-elements"
          "keycast"
          "kodi"
          "languagetool"
          "launchcontrol"
          "launchpad-manager"
          "libreoffice-language-pack"
          "libreoffice"
          "logitech-g-hub"
          "mediainfo"
          "mediainfoex"
          "Messenger"
          "microsoft-auto-update"
          "microsoft-azure-storage-explorer"
          "microsoft-edge@beta"
          "microsoft-excel" "microsoft-onenote" "microsoft-outlook" "microsoft-powerpoint" "microsoft-teams" "microsoft-word" "onedrive" "windows-app" # "microsoft-office-businesspro" "microsoft-remote-desktop"
          "musescore"
          "nextcloud"
          "notion" "notion-calendar" "notion-enhanced"
          "obs" "droidcam-obs" "obs-advanced-scene-switcher" "obs-backgroundremoval" "obs-websocket"
          "obsidian"
          "onyx"
          "paragon-extfs"
          "pgadmin4"
          "porting-kit"
          "powershell"
          "quarto"
          "r" "rstudio"
          "raycast"
          "scribus"
          "setapp"
          "slack" "slack-cli"
          "spotify"
          "sqlitemanager" "sqlitestudio"
          "steam" "steamcmd"  # "steam-plus-plus"
          "swiftformat-for-xcode"
          "sync"
          "tex-live-utility"
          "the-unarchiver"
          "visual-studio-code"
          "vlc" "vlc-setup" "vlc-webplugin"
          "vmware-fusion"
          "wakatime"
          "warp"
          "wavebox"
          "wezterm"
          "whatsapp"
          "xcodeclangformat"
          "youtube-downloader"
          "ytmdesktop-youtube-music"
          "yubico-yubikey-manager"
          "zed"
          "zen-browser"
          "zenmap"
          #"zsh-abbr" "zsh-async" "zsh-autocomplete" "zsh-autopair" "zsh-autosuggestions" "zsh-completions" "zsh-fast-syntax-highlighting" "zsh-git-prompt" "zsh-history-substring-search" "zsh-navigation-tools" "zsh-syntax-highlighting" "zsh-vi-mode" "zsh-you-should-use"
        ];
        masApps = {
          "Amazon Prime Video" = 545519333;
          "Apple Develooper" = 640199958;
          "Kindle" = 302584613;
          "LanguageTool - Grammar Checker" = 1534275760;
          #"Messenger" = 1480068668;
          #"Microsoft 365" = 1450038993;
          "Safari: Black Menu for Wikipedia" = 1543803288;
          #"Safari: Carrot Weather: Alerts and Radar" = 961390574;
          "Safari: Dark Readert Pro" = 1438243180;
          "Safari: DuckDuckGo Privacy" = 1482920575;
          "Safari: G App Launcher" = 1543803459;
          "Safari: Inkscape Editor for Graphics" = 6443424132;
          "Safari: LanguageTool" = 1534275760;
          #"Safari: MSE MoneySavingExpert" = 1590502794;
          "Safari: Notion Web Clipper" = 1559269364;
          "Safari: Refined GitHub" = 1519867270;
          "Safari: Save to Pocket" = 1477385213;
          "Safari: SingleFile" = 6444322545;
          "Safari: Raindrop.io" = 1549370672;
          "Safari: Wayback Machine" = 1472432422;
          "Safari: Web Translator for DeepL" = 6443492610;
          "Testflight" = 899247664;
          #"Tomorrow.io: Weather Forecast" = 1443325509;
          "Ultra CharMap" = 520265986;
          #"Windows App" = 1295203466;
          #"Xcode" = 97799835;
          #"Yoink" = 457622435;
        };
        onActivation = {
          cleanup = "zap";
          extraFlags = [ "--verbose" ];
        };
      };

      nix = {
        extraOptions = ''
          extra-platforms = x86_64-darwin aarch64-darwin
        '';

        # Automatically run the garbage collector at a specific time.
        gc.automatic = true;

        # Automatically run the nix store optimiser at a specific time.
        optimise.automatic = true;

        #package = pkgs.nix;

        settings = {
          # If set to true, automatically detects files in the store that have identical contents,
          #   and replaces them with hard links to a single copy.
          # This saves disk space.
          # If set to false (the default), you can still run nix-store --optimise to get rid of duplicate files.
          auto-optimise-store = true;

          # Necessary for using flakes on this system.
          experimental-features = "nix-command flakes";

          # Add users to the Nix store group.
          trusted-users = [
            "root"
            "s-a-c"
            "@admin"
            "@wheel"
          ];
        };
      };

      nixpkgs = {
        config = {
          # allowBroken = true;	# Allow broken packages.
          allowUnfree = true;
        };


        # The platform the configuration will be used on.
        hostPlatform = "aarch64-darwin";
      };

      programs = {
        bash = { # bourne again shell
          enable = true;
          completion.enable = true;
        };

        # Enable direnv to automatically load .envrc files.
        direnv.enable = true; # direnv is a shell extension that loads and unloads environment variables depending on the current directory.

        # Whether to configure fish as an interactive shell.
        fish = { # friendly interactive shell
          enable = true;
        };

        tmux = {  # terminal multiplexer
          enable = true;
          enableFzf = true;
          enableMouse = true;
          enableSensible = true;
          enableVim = true;
        };

        vim = { # vi improved
          enable = true;
          enableSensible = true;
        };

        zsh = {
          enable = true;
          enableFzfCompletion = true;
          enableFzfGit = true;
          enableFzfHistory = true;
          enableSyntaxHighlighting = true;
        };
      };

      security.pam.enableSudoTouchIdAuth = true;

      services = {
        eternal-terminal = {
          enable = true;
          port = 2022;
          verbosity = 2;
        };

        jankyborders = {
          enable = true;
          active_color = "gradient(top_right=0x9992B3F5,bottom_left=0x9992B3F5)";
          blur_radius = 5.0;
          hidpi = true;
          inactive_color = "gradient(top_left=0x9992B3F5,bottom_right=0x9992B3F5)";
        };

        karabiner-elements.enable = false;

        mopidy = {
          enable = true;
          mediakeys.enable = true;
        };

        netbird.enable = true;

        # Auto upgrade nix package and the daemon service.
        nix-daemon.enable = true;  # # nix.package = pkgs.nix;

        postgresql = {
          enable = true;
          enableTCPIP = false;
          package = pkgs.postgresql;
        };

        sketchybar.enable = false;

        spacebar.enable = false;

        spotifyd.enable = true;

        tailscale.enable = true;
      };

      system = {
        activationScripts.applications.text = let
          env = pkgs.buildEnv {
            name = "system-applications";
            paths = config.environment.systemPackages;
            pathsToLink = "/Applications";
          };
        in
          pkgs.lib.mkForce ''
            # Set up applications.
            echo "setting up /Applications..." >&2
            rm -rf /Applications/Nix\ Apps
            mkdir -p /Applications/Nix\ Apps
            find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
            while read src; do
              app_name=$(basename "$src")
              echo "copying $src" >&2
              ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
            done
          '';

        # Set Git commit hash for darwin-version.
        configurationRevision = self.rev or self.dirtyRev or null;

        defaults = {
          # CustomUserPreferences = {
          #   NSGlobalDomain = {
          #     TISRomanSwitchState = 1;
          #   };
          #   "com.apple.Safari" = {
          #     "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
          #   };
          # };
          NSGlobalDomain = {
            AppleFontSmoothing = 2;
            AppleICUForce24HourTime = true;
            AppleInterfaceStyle = "Dark";
            AppleShowAllExtensions = true;
            AppleShowAllFiles = true;
            AppleWindowTabbingMode = "always";
            KeyRepeat = 2;
            NSAutomaticCapitalizationEnabled = false;
            NSAutomaticDashSubstitutionEnabled = false;
            NSAutomaticQuoteSubstitutionEnabled = false;
            NSNavPanelExpandedStateForSaveMode = true;
            NSNavPanelExpandedStateForSaveMode2 = true;
            NSTableViewDefaultSizeMode = 2;
            NSTextShowsControlCharacters = true;
            # NSQuitAlwaysKeepsWindows = true;
            "com.apple.springing.enabled" = true;
            "com.apple.swipescrolldirection" = false;
            "com.apple.trackpad.forceClick" = true;
            "com.apple.trackpad.trackpadCornerClickBehavior" = 1;
          };
          SoftwareUpdate = {
            AutomaticallyInstallMacOSUpdates = true;
          };
          WindowManager = {
            AppWindowGroupingBehavior = true;
            GloballyEnabled = true;
            StandardHideDesktopIcons = true;
          };
          alf = {
            allowdownloadsignedenabled = 1;
            globalstate = 1;
            loggingenabled = 1;
            stealthenabled = 1;
          };
          dock = {
            appswitcher-all-displays = true;
            autohide  = true;
            enable-spring-load-actions-on-all-items = true;
            largesize = 128;
            magnification = true;
            mineffect = "suck";
            minimize-to-application = true;
            mouse-over-hilite-stack = true;
            # persistent-apps = [
            #   "${pkgs.alacritty}/Applications/Alacritty.app"
            #   "/Applications/Firefox.app"
            #   "${pkgs.obsidian}/Applications/Obsidian.app"
            #   "/System/Applications/Mail.app"
            #   "/System/Applications/Calendar.app"
            # ];
            showhidden = true;
            slow-motion-allowed = true;
          };
          finder = {
            AppleShowAllExtensions = true;
            AppleShowAllFiles = true;
            FXPreferredViewStyle = "clmv";
            QuitMenuItem = true;
            ShowPathbar = true;
            ShowStatusBar = true;
            _FXShowPosixPathInTitle = true;
            _FXSortFoldersFirst = true;
          };
          loginwindow = {
            GuestEnabled  = true;
            LoginwindowText = ''
              \\U03bb
              ¡There's No Such Thing As A Free Lunch!
            '';
            SHOWFULLNAME = true;
          };
          magicmouse = {
            MouseButtonMode = "TwoButton";
          };
          menuExtraClock = {
            Show24Hour = true;
            ShowDayOfWeek = true;
            ShowSeconds = true;
          };
          #universalaccess = {
            #closeViewScrollWheelToggle = true;
            #mouseDriverCursorSize = 2.0;
          #};
        };

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        stateVersion = 5;
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#StandAloneComplexs-MacBook-Pro
    darwinConfigurations."StandAloneComplexs-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
            enable = true;
            # Automatically migrate existing Homebrew installations
            #autoMigrate = true;

            # Apple Silicon Only
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "s-a-c";

            # Optional: Enable fully-declarative tap management
            # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
            mutableTaps = false;

            # Optional: Declarative tap management
            taps = {
              "homebrew/homebrew-bundle" = homebrew-bundle;
              "homebrew/homebrew-cask" = homebrew-cask;
              "homebrew/homebrew-core" = homebrew-core;
            };
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."StandAloneComplexs-MacBook-Pro".pkgs;
  };
}
