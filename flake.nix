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
    homebrew-aerospace = {
      url = "github:nikitabobko/homebrew-tap";
      flake = false;
    };
    homebrew-sketchybar = {
      url = "github:felixkratz/homebrew-formulae";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      homebrew-bundle,
      homebrew-cask,
      homebrew-core,
      homebrew-aerospace,
      homebrew-sketchybar,
      ...
    }:
    let
      configuration =
        { pkgs, config, ... }:
        {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [
            #pkgs.atuin
            #pkgs.avfs
            #pkgs.binutils-unwrapped-all-targets
            #pkgs.chruby
            #pkgs.clolcat
            #pkgs.corepack_latest
            #pkgs.darwin.xcode
            #pkgs.fzf
            #pkgs.fzf-git-sh
            #pkgs.fzf-make
            #pkgs.fzf-obc
            #pkgs.fzf-zsh
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
            #pkgs.mopidy-bandcamp
            #pkgs.mopidy-jellyfin
            #pkgs.mopidy-local
            #pkgs.mopidy-moped
            #pkgs.mopidy-notify
            #pkgs.mopidy-podcast
            #pkgs.mopidy-scrobbler
            #pkgs.mopidy-somafm
            #pkgs.mopidy-soundcloud
            #pkgs.mopidy-spotify
            #pkgs.mopidy-tunein
            #pkgs.mopidy-youtube
            #pkgs.mopidy-ytmusic
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
            #pkgs.openssh_hpn
            #pkgs.perl
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
            #pkgs.rakudo
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
            #pkgs.ytfzf
            #pkgs.yubikey-personalization
            #pkgs.yubikey-personalization-gui
            #pkgs.yubikey-touch-detector
            #pkgs.zellij
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
            pkgs.bfg-repo-cleaner
            pkgs.blesh
            pkgs.btop
            pkgs.bun
            pkgs.bzip2
            pkgs.cacert
            pkgs.carapace
            pkgs.ccache
            pkgs.ccls
            pkgs.chafa
            pkgs.charm
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
            #pkgs.deno
            pkgs.dwt1-shell-color-scripts
            pkgs.e2fsprogs
            pkgs.editorconfig-checker
            pkgs.editorconfig-core-c
            #pkgs.elixir
            #pkgs.elixir-ls
            pkgs.elvish
            #pkgs.erlang_27
            #pkgs.erlang-ls
            #pkgs.erlfmt
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
            pkgs.gettext
            pkgs.gh
            pkgs.gh-f
            #pkgs.gist
            #pkgs.git-filter-repo
            #pkgs.gitFull
            #pkgs.gitui
            #pkgs.gleam
            pkgs.gmp
            pkgs.gnugrep
            pkgs.gnum4
            pkgs.gnumake
            pkgs.gnupatch
            pkgs.gnupg
            #pkgs.go
            pkgs.gopls
            pkgs.gpa
            pkgs.gpg-tui
            pkgs.guile
            pkgs.guile-lib
            pkgs.gum
            pkgs.helix
            pkgs.helix-gpt
            pkgs.imagemagickBig
            pkgs.iterm2
            pkgs.jq
            pkgs.jq-lsp
            pkgs.jq-zsh-plugin
            pkgs.json_c
            pkgs.lazycli
            #pkgs.lazygit
            pkgs.lazysql
            pkgs.lemonade
            pkgs.lesspipe
            #pkgs.lfe
            pkgs.libtool
            pkgs.lilypond-with-fonts
            #pkgs.livebook
            pkgs.lldb
            pkgs.llvm
            pkgs.lolcat
            pkgs.lorri
            pkgs.lsd
            #pkgs.lua-language-server
            #pkgs.lua54Packages.fennel
            #pkgs.lua54Packages.lua
            #pkgs.lua54Packages.luacheck
            #pkgs.lua54Packages.luarepl
            #pkgs.lua54Packages.luarocks
            pkgs.mas
            pkgs.mediainfo
            pkgs.mediainfo-gui
            pkgs.micro
            pkgs.mkalias
            pkgs.mmv
            pkgs.mpd
            pkgs.mpv
            pkgs.ncurses
            pkgs.ninja
            pkgs.nix-zsh-completions
            pkgs.nixd
            pkgs.nixfmt-rfc-style
            pkgs.notcurses
            pkgs.nsxiv
            pkgs.odin
            pkgs.ols
            pkgs.openssl
            pkgs.parallel-full
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
            #pkgs.racket
            pkgs.ranger
            #pkgs.rebar3
            #pkgs.rich-cli
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
            #pkgs.sqlite
            #pkgs.sqlite-utils
            #pkgs.sqlite-web
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
            #pkgs.texliveFull
            pkgs.tig
            pkgs.tigerbeetle
            pkgs.tix
            pkgs.tk
            pkgs.tkman
            pkgs.trash-cli
            pkgs.tree
            #pkgs.tree-sitter
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
            pkgs.yubico-pam
            pkgs.yubico-piv-tool
            pkgs.yubikey-agent
            pkgs.yubikey-manager
            pkgs.zef
            pkgs.zlib
            pkgs.zoxide
            pkgs.zstd
            pkgs.zunit
          ];

          fonts.packages = with pkgs; [
            alegreya
            iosevka
            iosevka-comfy.comfy
            iosevka-comfy.comfy-duo
            iosevka-comfy.comfy-fixed
            iosevka-comfy.comfy-motion
            iosevka-comfy.comfy-motion-duo
            iosevka-comfy.comfy-motion-fixed
            iosevka-comfy.comfy-wide
            iosevka-comfy.comfy-wide-duo
            iosevka-comfy.comfy-wide-fixed
            iosevka-comfy.comfy-wide-motion
            iosevka-comfy.comfy-wide-motion-duo
            iosevka-comfy.comfy-wide-motion-fixed
            # nerdfonts
            open-dyslexic
            overpass
          ];

          homebrew = {
            enable = true;
            brews = [
              ## ==> Formulae
              "aom"
              "armadillo"
              "asciinema"
              "autoenv"
              "bdw-gc"
              "bear"
              "binutils"
              "boost"
              "borders"
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
              "cpanminus"
              "curl"
              "deno"
              "dialog"
              "direnv"
              "dooit"
              "dotenv-linter"
              "duti"
              "elixir"
              "elixir-ls"
              "erlang"
              "erlang_ls"
              "fish"
              "fisher"
              "fizsh"
              # { name = "fnnn";
              #     args = [ "HEAD" ];
              # }
              "fontconfig"
              "freetype"
              "fribidi"
              "fzf"
              "gcc"
              "gettext"
              "ghcup"
              "ghostscript"
              "giflib"
              "gist"
              "git"
              "git-extras"
              "git-flow"
              "git-gui"
              "git-plus"
              "git-tools"
              "gitui"
              "gleam"
              "glib"
              "gmime"
              "gmp"
              "gnu-sed"
              "gnupg"
              "gnuplot"
              "gnutls"
              "go"
              "gpatch"
              "gpgme"
              "graphite2"
              "greed"
              "gsl"
              "harfbuzz"
              "hdf5"
              "highway"
              "icu4c@76"
              "ifstat"
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
              "lazydocker"
              "lazygit"
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
              "libsql"
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
              "lua-language-server"
              "luacheck"
              "luajit"
              "luarocks"
              "luv"
              "lz4"
              "lzo"
              "m4"
              "marksman"
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
              "nnn"
              "node"
              "notmuch"
              "nowplaying-cli"
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
              "perl"
              "pinentry"
              "pixman"
              "portaudio"
              "posting"
              "prettier"
              "pycparser"
              "python-packaging"
              "python@3.12"
              "python@3.13"
              "rakudo-star"
              "readline"
              "rebar3"
              "rtmpdump"
              "screenresolution"
              "shared-mime-info"
              "sketchybar"
              "speedtest-cli"
              "sqlite"
              "stylua"
              "svim"
              "switchaudio-osx"
              "talloc"
              "tesseract"
              "texlab"
              "texlive"
              "tokyo-cabinet"
              "tree-sitter"
              #"turso-cli"
              "unbound"
              "unibilium"
              "w3m"
              "webp"
              "wireguard-go"
              "x265"
              "xapian"
              "xorgproto"
              "xz"
              "ykpers"
              "z3"
              "zellij"
              "zig"
              "zigmod"
              "zsh-lovers"
              "zsh"
              "zstd"
            ];
            casks = [
              ## ==> Casks
              "adium"
              "aerospace"
              "alacritty"
              "alfred"
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
              "cutter"
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
              "font-0xproto-nerd-font"
              "font-3270-nerd-font"
              "font-agave-nerd-font"
              "font-alegreya-sans-sc"
              "font-alegreya-sans"
              "font-alegreya-sc"
              "font-anonymice-nerd-font"
              "font-arimo-nerd-font"
              "font-aurulent-sans-mono-nerd-font"
              "font-awesome-terminal-fonts"
              "font-bigblue-terminal-nerd-font"
              "font-bitstream-vera-sans-mono-nerd-font"
              "font-blex-mono-nerd-font"
              "font-caskaydia-cove-nerd-font"
              "font-caskaydia-mono-nerd-font"
              "font-code-new-roman-nerd-font"
              "font-comic-shanns-mono-nerd-font"
              "font-commit-mono-nerd-font"
              "font-cousine-nerd-font"
              "font-d2coding-nerd-font"
              "font-daddy-time-mono-nerd-font"
              "font-dejavu-sans-mono-nerd-font"
              "font-departure-mono-nerd-font"
              "font-droid-sans-mono-nerd-font"
              "font-envy-code-r-nerd-font"
              "font-fantasque-sans-mono-nerd-font"
              "font-fira-code-nerd-font"
              "font-fira-code"
              "font-fira-mono-nerd-font"
              "font-fontawesome"
              "font-geist-mono-nerd-font"
              "font-go-mono-nerd-font"
              "font-gohufont-nerd-font"
              "font-hack-nerd-font"
              "font-hasklug-nerd-font"
              "font-heavy-data-nerd-font"
              "font-hurmit-nerd-font"
              "font-im-writing-nerd-font"
              "font-inconsolata-go-nerd-font"
              "font-inconsolata-lgc-nerd-font"
              "font-inconsolata-nerd-font"
              "font-intone-mono-nerd-font"
              "font-iosevka-nerd-font"
              "font-iosevka-term-nerd-font"
              "font-iosevka-term-slab-nerd-font"
              "font-jetbrains-mono-nerd-font"
              "font-jetbrains-mono"
              "font-lekton-nerd-font"
              "font-liberation-nerd-font"
              "font-lilex-nerd-font"
              "font-linux-biolinum"
              "font-m+-nerd-font"
              "font-martian-mono-nerd-font"
              "font-meslo-lg-nerd-font"
              "font-monaspace-nerd-font"
              "font-monaspace"
              "font-monocraft-nerd-font"
              "font-monofur-nerd-font"
              "font-monoid-nerd-font"
              "font-mononoki-nerd-font"
              "font-noto-nerd-font"
              "font-open-dyslexic-nerd-font"
              "font-open-dyslexic"
              "font-overpass-nerd-font"
              "font-profont-nerd-font"
              "font-proggy-clean-tt-nerd-font"
              "font-recursive-mono-nerd-font"
              "font-roboto-mono-nerd-font"
              "font-sauce-code-pro-nerd-font"
              "font-sf-mono"
              "font-sf-pro"
              "font-shure-tech-mono-nerd-font"
              "font-space-mono-nerd-font"
              "font-symbols-only-nerd-font"
              "font-terminess-ttf-nerd-font"
              "font-tinos-nerd-font"
              "font-trispace"
              "font-ubuntu-mono-nerd-font"
              "font-ubuntu-nerd-font"
              "font-ubuntu-sans-nerd-font"
              "font-victor-mono-nerd-font"
              "font-zed-mono-nerd-font"
              "font-zen-loop"
              "font-zed-sans"
              "font-zen-antique-soft"
              "font-zen-dots"
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
              "hex-fiend"
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
              "livebook"
              "logitech-g-hub"
              "lulu"
              "macfuse"
              "machoview"
              "mactex"
              "mediainfo"
              "mediainfoex"
              "meetingbar"
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
              "oracle-jdk-javadoc"
              "oracle-jdk"
              "orion"
              "paragon-extfs"
              "pgadmin4"
              "porting-kit"
              "postman"
              "postman-agent"
              "postman-cli"
              "powershell"
              "quarto"
              "r"
              "racket"
              "raycast"
              "rstudio"
              "scribus"
              "setapp"
              "sf-symbols"
              "skim"
              #"slack-cli"
              #"slack"
              "sloth"
              "spotify"
              "sqlitemanager"
              "sqlitestudio"
              "steam"
              "steamcmd"
              "swiftdefaultappsprefpane"
              "swiftformat-for-xcode"
              "sync"
              "telegram-desktop@beta"
              "tex-live-utility"
              "texstudio"
              "the-unarchiver"
              #"visual-studio-code"
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
              "zoom"
            ];
            masApps = {
              "Amazon Kindle" = 302584613;
              "Amazon Prime Video" = 545519333;
              #"Apple Carrot Weather: Alerts and Radar" = 961390574;
              "Apple Configurator" = 1037126344;
              "Apple Develooper" = 640199958;
              "Apple GarageBand" = 682658836;
              "Apple iMovie" = 408981434;
              "Apple Keynote" = 409183694;
              "Apple Numbers" = 409203825;
              "Apple Pages" = 409201541;
              "Apple Shazam: Identify Songs" = 897118787;
              "Apple Swift Playgrounds" = 1496833156;
              "Apple Testflight" = 899247664;
              "Apple Transporter" = 1450874784;
              "iPulse" = 1028916583;
              "LanguageTool - Grammar Checker" = 1534275760;
              "Messenger" = 1480068668;
              #"Microsoft 365" = 1450038993;
              #"MSE MoneySavingExpert" = 1590502794;
              "Safari: Black Menu for Wikipedia" = 1543803288;
              "Safari: Dark Readert Pro" = 1438243180;
              "Safari: DuckDuckGo Privacy" = 1482920575;
              "Safari: G App Launcher" = 1543803459;
              "Safari: Inkscape Editor for Graphics" = 6443424132;
              "Safari: LanguageTool" = 1534275760;
              "Safari: Notion Web Clipper" = 1559269364;
              "Safari: Refined GitHub" = 1519867270;
              "Safari: Save to Pocket" = 1477385213;
              "Safari: SingleFile" = 6444322545;
              "Safari: Raindrop.io" = 1549370672;
              #"Safari: Vimari" = 1480933944;
              "Safari: Wayback Machine" = 1472432422;
              "Safari: Web Translator for DeepL" = 6443492610;
              "Slack" = 803453959;
              "Smart JSON Editor" = 1268962404;
              #"Tailscale" = 1475387142;
              "Testflight" = 899247664;
              #"Tomorrow.io: Weather Forecast" = 1443325509;
              "Ultra CharMap" = 520265986;
              "Windows App" = 1295203466;
              #"Wireguard" = 1451685025;
              "Xcode" = 497799835;
              "Xcode: XCFormat" = 1165321484;
              "Xcode: Text Toolset" = 1157225201;
              "Xcode: Comment Wrapper" = 1377998565;
              "Xcode: NamingTranslator" = 1218784832;
              #"Yoink" = 457622435;
            };
            taps = [
              {
                name = "homebrew/bundle";
                clone_target = "https://github.com/homebrew/homebrew-bundle.git";
                force_auto_update = true;
              }
              {
                name = "homebrew/cask";
                clone_target = "https://github.com/homebrew/homebrew-cask.git";
                force_auto_update = true;
              }
              {
                name = "homebrew/core";
                clone_target = "https://github.com/homebrew/homebrew-core.git";
                force_auto_update = true;
              }
              {
                name = "homebrew/aerospace";
                clone_target = "https://github.com/nikitabobko/homebrew-tap.git";
                force_auto_update = true;
              }
              {
                name = "homebrew/sketchybar";
                clone_target = "https://github.com/felixkratz/homebrew-formulae.git";
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
              #     and replaces them with hard links to a single copy.
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
              #allowBroken = true;	# Allow broken packages.
              allowUnfree = true;
              #allowUnsupportedSystem = true;
            };

            # The platform the configuration will be used on.
            hostPlatform = "aarch64-darwin";
          };

          programs = {
            bash = {
              # bourne again shell
              enable = true;
              completion.enable = true;
            };

            # Enable direnv to automatically load .envrc files.
            direnv.enable = true; # direnv is a shell extension that loads and unloads environment variables depending on the current directory.

            # Whether to configure fish as an interactive shell.
            fish = {
              # friendly interactive shell
              enable = true;
            };

            tmux = {
              # terminal multiplexer
              enable = true;
              enableFzf = true;
              enableMouse = true;
              enableSensible = true;
              enableVim = true;
            };

            vim = {
              # vi improved
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
              enable = false;
              mediakeys.enable = false;
            };

            netbird.enable = true;

            # Auto upgrade nix package and the daemon service.
            nix-daemon.enable = true; # # nix.package = pkgs.nix;

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
            activationScripts.applications.text =
              let
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
              #     NSGlobalDomain = {
              #         TISRomanSwitchState = 1;
              #     };
              #     "com.apple.Safari" = {
              #         "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
              #     };
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
                autohide = true;
                enable-spring-load-actions-on-all-items = true;
                largesize = 128;
                magnification = true;
                mineffect = "suck";
                minimize-to-application = true;
                mouse-over-hilite-stack = true;
                # persistent-apps = [
                #     "${pkgs.alacritty}/Applications/Alacritty.app"
                #     "/Applications/Firefox.app"
                #     "${pkgs.obsidian}/Applications/Obsidian.app"
                #     "/System/Applications/Mail.app"
                #     "/System/Applications/Calendar.app"
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
                GuestEnabled = true;
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
          nix-homebrew.darwinModules.nix-homebrew
          {
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
              mutableTaps = true;

              # Optional: Declarative tap management
              taps = {
                "homebrew/homebrew-bundle" = homebrew-bundle;
                "homebrew/homebrew-cask" = homebrew-cask;
                "homebrew/homebrew-core" = homebrew-core;
                "nikitabobko/homebrew-tap" = homebrew-aerospace;
                "felixkratz/homebrew-formulae" = homebrew-sketchybar;
              };
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."StandAloneComplexs-MacBook-Pro".pkgs;
    };
}
