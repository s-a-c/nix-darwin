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
    homebrew-dutis = {
      url = "github:tsonglew/dutis";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew,
    homebrew-bundle, homebrew-cask, homebrew-core,
    homebrew-dutis,
    ... }:
  let
    configuration = { pkgs, config, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
        #pkgs.avfs
        #pkgs.binutils-unwrapped-all-targets
        #pkgs.chruby
        #pkgs.clolcat
        #pkgs.corepack_latest
        #pkgs.darwin.xcode
        #pkgs.gcc
        #pkgs.guix
        #pkgs.jdk23
        #pkgs.jellycli
        #pkgs.jellyfin
        #pkgs.jellyfin-ffmpeg
        #pkgs.jellyfin-media-player
        #pkgs.jellyfin-mpv-shim
        #pkgs.jellyfin-web
        #pkgs.jftui
        #pkgs.julia
        #pkgs.kodi
        #pkgs.ksnip
        #pkgs.laravel
        #pkgs.llvm-manpages
        #pkgs.mopidy-jellyfin
        #pkgs.neovide
        #pkgs.neovim
        #pkgs.neovim-remote
        #pkgs.netbird
        #pkgs.netbird-ui
        #pkgs.nu_scripts
        #pkgs.nufmt
        #pkgs.nushell
        #pkgs.nushellPlugins.formats
        #pkgs.nushellPlugins.gstat
        #pkgs.nushellPlugins.net
        #pkgs.nushellPlugins.query
        #pkgs.pgadmin4
        #pkgs.pgadmin4-desktopmode
        #pkgs.php83
        #pkgs.php83Packages.composer
        #pkgs.php83Packages.composer-local-repo-plugin
        #pkgs.php83Packages.phpstan
        #pkgs.php83Packages.psysh
        #pkgs.phpunit
        #pkgs.postgresql_16
        #pkgs.postgresql16Packages.postgis
        #pkgs.postgresql16Packages.temporal_tables
        #pkgs.postgresql16Packages.timescaledb
        #pkgs.postgresql16Packages.timescaledb_toolkit
        #pkgs.powerline-fonts
        #pkgs.powerline-symbols
        #pkgs.rubyPackages_3_3.sass
        #pkgs.rustup
        #pkgs.scribus
        #pkgs.tailscale
        #pkgs.tailscale-nginx-auth
        #pkgs.tailscalesd
        #pkgs.tartube-yt-dlp
        #pkgs.tmux
        #pkgs.typescript
        #pkgs.vcpkg
        #pkgs.vim
        #pkgs.wireguard-tools
        #pkgs.yubikey-personalization
        #pkgs.yubikey-personalization-gui
        #pkgs.yubikey-touch-detector
        #pkgs.zig
        #pkgs.zig-shell-completions
        #pkgs.zls
        #pkgs.zsh
        #pkgs.zsh-abbr
        #pkgs.zsh-autocomplete
        #pkgs.zsh-autopair
        #pkgs.zsh-autosuggestions
        #pkgs.zsh-completions
        #pkgs.zsh-f-sy-h
        #pkgs.zsh-forgit
        #pkgs.zsh-fzf-history-search
        #pkgs.zsh-history-search-multi-word
        #pkgs.zsh-history-substring-search
        #pkgs.zsh-navigation-tools
        #pkgs.zsh-nix-shell
        #pkgs.zsh-you-should-use
        #pkgs.zsh-zhooks
        #pkgs.ztags
        pkgs.any-nix-shell
        pkgs.ascii-image-converter
        pkgs.atuin
        pkgs.autoconf
        pkgs.autoconf-archive
        pkgs.autogen
        pkgs.automake
        pkgs.bash_unit
        pkgs.bash-preexec
        pkgs.bashate
        pkgs.bat
        pkgs.bat-extras.batdiff
        pkgs.bat-extras.batgrep
        pkgs.bat-extras.batman
        pkgs.bat-extras.batpipe
        pkgs.bat-extras.batwatch
        pkgs.bat-extras.prettybat
        pkgs.bats
        pkgs.blesh
        pkgs.btop
        pkgs.bun
        pkgs.bzip2
        pkgs.cacert
        pkgs.carapace
        pkgs.ccache
        pkgs.ccls
        pkgs.chafa
        pkgs.checkbashisms
        pkgs.clang-analyzer
        pkgs.clang-manpages
        pkgs.clang-tools
        pkgs.clipse
        pkgs.clojure
        pkgs.clojure-lsp
        pkgs.coreutils-full
        pkgs.cowsay
        pkgs.cq
        pkgs.curlFull
        pkgs.dart
        pkgs.dart-sass
        pkgs.dbus
        pkgs.deno
        pkgs.dwt1-shell-color-scripts
        pkgs.e2fsprogs
        pkgs.editorconfig-checker
        pkgs.editorconfig-core-c
        pkgs.elixir
        pkgs.elixir-ls
        pkgs.elvish
        pkgs.erlang_27
        pkgs.erlang-ls
        pkgs.erlfmt
        pkgs.exercism
        pkgs.exiftool
        pkgs.eza
        pkgs.fastfetch
        pkgs.fd
        pkgs.fennel-ls
        pkgs.ffmpeg_7-full
        pkgs.ffmpegthumbnailer
        pkgs.figlet
        pkgs.findutils
        pkgs.fnlfmt
        pkgs.fortune
        pkgs.fzf
        pkgs.fzf-git-sh
        pkgs.fzf-make
        pkgs.fzf-obc
        pkgs.fzf-zsh
        pkgs.gettext
        pkgs.gh
        pkgs.gh-f
        pkgs.gist
        pkgs.gitFull
        pkgs.gitui
        pkgs.gleam
        pkgs.gmp
        pkgs.gnugrep
        pkgs.gnum4
        pkgs.gnumake
        pkgs.gnupatch
        pkgs.gnupg
        pkgs.go
        pkgs.gopls
        pkgs.gpa
        pkgs.gpg-tui
        pkgs.guile
        pkgs.guile-lib
        pkgs.gum
        pkgs.imagemagickBig
        pkgs.iterm2
        pkgs.jq
        pkgs.jq-lsp
        pkgs.jq-zsh-plugin
        pkgs.json_c
        pkgs.lazycli
        pkgs.lazygit
        pkgs.lazysql
        pkgs.lemonade
        pkgs.lesspipe
        pkgs.lfe
        pkgs.libtool
        pkgs.lilypond-with-fonts
        pkgs.livebook
        pkgs.lldb
        pkgs.llvm
        pkgs.lolcat
        pkgs.lorri
        pkgs.lsd
        pkgs.lua-language-server
        pkgs.lua54Packages.fennel
        pkgs.lua54Packages.lua
        pkgs.lua54Packages.luacheck
        pkgs.lua54Packages.luarepl
        pkgs.lua54Packages.luarocks
        pkgs.mas
        pkgs.mediainfo
        pkgs.mediainfo-gui
        pkgs.micro
        pkgs.mkalias
        pkgs.mmv
        pkgs.mopidy-bandcamp
        pkgs.mopidy-local
        pkgs.mopidy-moped
        pkgs.mopidy-notify
        pkgs.mopidy-podcast
        pkgs.mopidy-scrobbler
        pkgs.mopidy-somafm
        pkgs.mopidy-soundcloud
        pkgs.mopidy-spotify
        pkgs.mopidy-tunein
        pkgs.mopidy-youtube
        pkgs.mopidy-ytmusic
        pkgs.mpd
        pkgs.mpv
        pkgs.ncurses
        pkgs.ninja
        pkgs.nix-zsh-completions
        pkgs.nixd
        pkgs.nixfmt-rfc-style
        pkgs.nsxiv
        pkgs.odin
        pkgs.ols
        #pkgs.openssh_hpn
        pkgs.openssl
        pkgs.parallel-full
        pkgs.perl
        pkgs.pinentry_mac
        pkgs.pipx
        pkgs.pkg-config
        pkgs.pngpaste
        pkgs.ponysay
        pkgs.poppler
        pkgs.poppler_data
        pkgs.poppler_utils
        pkgs.procps
        pkgs.progress
        pkgs.python313Full
        pkgs.racket
        pkgs.rakudo
        pkgs.ranger
        pkgs.rebar3
        pkgs.rich-cli
        pkgs.ripgrep
        pkgs.rlwrap
        pkgs.roswell
        pkgs.ruby_3_3
        pkgs.rubyPackages_3_3.rails
        pkgs.rubyPackages_3_3.ruby-lsp
        pkgs.rubyPackages_3_3.sass-listen
        pkgs.rubyPackages_3_3.sassc
        pkgs.screen
        pkgs.sheldon
        pkgs.shellcheck
        pkgs.shellcheck-sarif
        pkgs.shellharden
        pkgs.shellspec
        pkgs.shfmt
        pkgs.spatialite_tools
        pkgs.sqlar
        pkgs.sqlcipher
        pkgs.sqldiff
        pkgs.sqlite
        pkgs.sqlite-utils
        pkgs.sqlite-web
        pkgs.starship
        pkgs.stow
        pkgs.stylelint
        pkgs.stylua
        pkgs.sysz
        pkgs.tailwindcss
        pkgs.tailwindcss-language-server
        pkgs.taoup
        pkgs.tcl
        pkgs.tclx
        pkgs.tealdeer
        pkgs.tewisay
        pkgs.texi2html
        pkgs.texliveFull
        pkgs.tig
        pkgs.tigerbeetle
        pkgs.tix
        pkgs.tk
        pkgs.tkman
        pkgs.trash-cli
        pkgs.tree
        pkgs.tree-sitter
        pkgs.unar
        pkgs.unzip
        pkgs.vcpkg-tool
        pkgs.vivid
        pkgs.wget
        pkgs.xclip
        pkgs.xsel
        pkgs.yaml-language-server
        pkgs.yamlfmt
        pkgs.yamlscript
        pkgs.yazi
        pkgs.yq
        pkgs.yt-dlg
        pkgs.yt-dlp
        pkgs.ytfzf
        pkgs.yubico-pam
        pkgs.yubico-piv-tool
        pkgs.yubikey-agent
        pkgs.yubikey-manager
        pkgs.zef
        pkgs.zellij
        pkgs.zlib
        pkgs.zoxide
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
        brews = [ ## ==> Formulae
          "aom"
          "asciinema"
          "autoenv"
          "bdw-gc"
          "binutils"
          "brotli"
          "c-ares"
          "c2048"
          "ca-certificates"
          "cairo"
          "cargo-about"
          "cargo-all-features"
          "cargo-audit"
          "cargo-auditable"
          "cargo-binstall"
          "cargo-binutils"
          "cargo-bloat"
          "cargo-bundle"
          "cargo-c"
          "cargo-crev"
          "cargo-deny"
          "cargo-depgraph"
          "cargo-deps"
          "cargo-docset"
          "cargo-edit"
          "cargo-fuzz"
          "cargo-generate"
          "cargo-instruments"
          "cargo-llvm-cov"
          "cargo-llvm-lines"
          "cargo-make"
          "cargo-nextest"
          "cargo-outdated"
          "cargo-release"
          "cargo-sweep"
          "cargo-udeps"
          "cargo-watch"
          "cargo-zigbuild"
          "cffi"
          "chruby"
          "clipboard"
          "cmatrix"
          "coreutils"
          "curl"
          "deno"
          "dialog"
          "duti"
          "dutis"
          "fish"
          "fisher"
          "fizsh"
          "fontconfig"
          "freetype"
          "fribidi"
          "gcc"
          "gettext"
          "ghcup"
          "ghostscript"
          "giflib"
          "glib"
          "gmime"
          "gmp"
          "gnu-sed"
          "gnupg"
          "gnutls"
          "gpatch"
          "gpgme"
          "graphite2"
          "greed"
          "harfbuzz"
          "highway"
          "icu4c@76"
          "imagemagick"
          "imath"
          "imlib2"
          "isl"
          "jasper"
          "jbig2dec"
          "jpeg-turbo"
          "jpeg-xl"
          "json-c"
          "juliaup"
          "leptonica"
          "libarchive"
          "libassuan"
          "libb2"
          "libcaca"
          "libde265"
          "libdeflate"
          "libevent"
          "libgcrypt"
          "libgit2"
          "libgit2@1.7"
          "libgpg-error"
          "libheif"
          "libiconv"
          "libidn"
          "libidn2"
          "libksba"
          "liblqr"
          "libmpc"
          "libnghttp2"
          "libomp"
          "libpng"
          "libraw"
          "libssh2"
          "libtasn1"
          "libtiff"
          "libtool"
          "libunistring"
          "libusb"
          "libuv"
          "libvmaf"
          "libvterm"
          "libx11"
          "libxau"
          "libxcb"
          "libxdmcp"
          "libxext"
          "libxrender"
          "libyubikey"
          "little-cms2"
          "lmdb"
          "lpeg"
          "lua"
          "luajit"
          "luv"
          "lz4"
          "lzo"
          "m4"
          "mas"
          "mpdecimal"
          "mpfr"
          "mplayer"
          "msgpack"
          "nbsdgames"
          "ncurses"
          "neofetch"
          "neomutt"
          "neovim-remote"
          "neovim"
          "nethack"
          "nettle"
          "newsboat"
          "ninvaders"
          "node"
          "notmuch"
          "npth"
          "nudoku"
          "nushell"
          "nvm"
          "openexr"
          "openjpeg"
          "openssl@3"
          "p11-kit"
          "pango"
          "pcre"
          "pcre2"
          "pinentry"
          "pixman"
          "portaudio"
          "pycparser"
          "python-packaging"
          "python@3.12"
          "python@3.13"
          "readline"
          "rtmpdump"
          "screenresolution"
          "shared-mime-info"
          "speedtest-cli"
          "sqlite"
          "talloc"
          "tesseract"
          "tokyo-cabinet"
          "tree-sitter"
          "unbound"
          "unibilium"
          "w3m"
          "webp"
          "x265"
          "xapian"
          "xorgproto"
          "xz"
          "ykpers"
          "z3"
          "zig"
          "zigmod"
          "zsh-lovers"
          "zsh"
          "zstd"
        ];
        casks = [ ## ==> Casks
          "adium"
          "alacritty"
          "alfred"
          "amethyst"
          "arc"
          "bbedit"
          "bitwarden"
          "blender-benchmark"
          "blender"
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
          "droidcam-obs"
          "duckduckgo"
          "dyalog"
          "emacs@pretest"
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
          "gitkraken-cli"
          "gitkraken"
          "godot-mono"
          "godot"
          "google-chrome"
          "gpg-suite"
          "hammerspoon"
          "herd"
          "iina"
          "inkscape"
          "insync"
          "itermai"
          "jellyfin-media-player"
          "jellyfin"
          "jetbrains-gateway"
          "jetbrains-space"
          "jetbrains-toolbox"
          "jupyterlab"
          "karabiner-elements"
          "keycast"
          "kitty"
          "kodi"
          "languagetool"
          "launchcontrol"
          "launchpad-manager"
          "libreoffice-language-pack"
          "libreoffice"
          "logitech-g-hub"
          "macfuse"
          "mediainfo"
          "mediainfoex"
          "messenger"
          "microsoft-auto-update"
          "microsoft-azure-storage-explorer"
          "microsoft-excel"
          "microsoft-onenote"
          "microsoft-outlook"
          "microsoft-powerpoint"
          "microsoft-teams"
          "microsoft-word"
          "musescore"
          "neovide"
          "nextcloud"
          "notesollama"
          "notion-calendar"
          "notion-enhanced"
          "notion"
          "obs-advanced-scene-switcher"
          "obs-backgroundremoval"
          "obs-websocket"
          "obs"
          "obsidian"
          "ollama"
          "ollamac"
          "onedrive"
          "onyx"
          "opera@beta"
          "oracle-jdk"
          "oracle-jdk-javadoc"
          "paragon-extfs"
          "pgadmin4"
          "porting-kit"
          "powershell"
          "quarto"
          "r"
          "raycast"
          "rstudio"
          "scribus"
          "setapp"
          "slack-cli"
          "slack"
          "spotify"
          "sqlitemanager"
          "sqlitestudio"
          "steam"
          "steamcmd"
          "swiftformat-for-xcode"
          "sync"
          "tex-live-utility"
          "the-unarchiver"
          "visual-studio-code"
          "vlc-setup"
          "vlc-webplugin"
          "vlc"
          "vmware-fusion"
          "wakatime"
          "warp"
          "wavebox"
          "wezterm"
          "whatsapp"
          "windows-app"
          "xcodeclangformat"
          "youtube-downloader"
          "ytmdesktop-youtube-music"
          "yubico-yubikey-manager"
          "zed"
          "zen-browser"
          "zenmap"
        ];
        masApps = {
          "Amazon Prime Video" = 545519333;
          "Apple Develooper" = 640199958;
          "iPulse" = 1028916583;
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
          "Smart JSON Editor" = 1268962404;
          "Testflight" = 899247664;
          #"Tomorrow.io: Weather Forecast" = 1443325509;
          "Ultra CharMap" = 520265986;
          #"Windows App" = 1295203466;
          #"Xcode" = 97799835;
          "Xcode: XCFormat" = 1165321484;
          "Xcode: Text Toolset" = 1157225201;
          "Xcode: Comment Wrapper" = 1377998565;
          "Xcode: NamingTranslator" = 1218784832;
          #"Yoink" = 457622435;
        };
        taps = [
          # "homebrew/bundle"
          # "homebrew/cask"
          # "homebrew/core"
          { name = "tsonglew/dutis";
            clone_target = "https://github.com/tsonglew/dutis.git";
            force_auto_update = true;
          }
        ];
        onActivation = {
          cleanup = "zap";
          extraFlags = [ "--verbose" ];
        };
      };

      nix = {
        extraOptions = ''
          extra-platforms = x86_64-darwin aarch64-darwin
          keep-derivations = true
          keep-failed = false
          keep-going = true
          keep-outputs = true
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
          auto-optimise-store = false;

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
          enable = false;
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
            while read -r src; do
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
            #mutableTaps = false;

            # Optional: Declarative tap management
            taps = {
              "homebrew/homebrew-bundle" = homebrew-bundle;
              "homebrew/homebrew-cask" = homebrew-cask;
              "homebrew/homebrew-core" = homebrew-core;
              "tsonglew/dutis" = homebrew-dutis;
            };
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."StandAloneComplexs-MacBook-Pro".pkgs;
  };
}
