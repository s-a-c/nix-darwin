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
    homebrew-services = {
      url = "github:homebrew/homebrew-services";
      flake = false;
    };
    shivammathur-php = {
      url = "github:shivammathur/homebrew-php";
      flake = false;
    };
    shivammathur-extensions = {
      url = "github:shivammathur/homebrew-extensions";
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
      homebrew-services,
      shivammathur-php,
      shivammathur-extensions,
      ...
    }:
    let
      # The platform the configuration will be used on.
      hostPlatform = "aarch64-darwin";
      configuration =
        homebrew-args:
        {
          pkgs,
          config,
          lib,
          ...
        }:
        {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [
            pkgs.any-nix-shell
            # pkgs.ascii-image-converter # go install github.com/TheZoraiz/ascii-image-converter@latest
            # pkgs.bash_unit
            # pkgs.bash-preexec
            # pkgs.blesh
            # pkgs.bun  # curl -fsSL https://bun.com/install | bash #
            # pkgs.cacert
            pkgs.checkbashisms
            # pkgs.clipse
            pkgs.devbox
            # pkgs.dwt1-shell-color-scripts
            pkgs.komorebi
            # pkgs.lazycli
            # pkgs.lazysql
            pkgs.lemonade
            # pkgs.lldb
            pkgs.lorri
            pkgs.mkalias
            pkgs.nix-zsh-completions
            pkgs.nixd
            pkgs.nixfmt-rfc-style
            pkgs.nsxiv
            # pkgs.phpactor
            pkgs.procps
            # pkgs.shfmt
            pkgs.sqlar
            pkgs.sysz
            pkgs.taoup
            pkgs.tigerbeetle
            pkgs.tclPackages.tix
            # pkgs.vivid
            pkgs.vim
            pkgs.yamlscript
            pkgs.yt-dlg
            pkgs.zef
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
            open-dyslexic
            overpass
          ];

          homebrew = {
            enable = true;
            global = {
              autoUpdate = true;
              brewfile = true;
            };
            onActivation = {
              autoUpdate = true;
              cleanup = "zap";
              extraFlags = [ "--verbose" ];
              upgrade = true;
            };
            masApps = {
              #"Amazon Kindle" = 302584613;
              #"Amazon Prime Video" = 545519333;
              "Apple Configurator" = 1037126344;
              "Apple Develooper" = 640199958;
              "Apple GarageBand" = 682658836;
              "Apple Keynote" = 409183694;
              "Apple Numbers" = 409203825;
              "Apple Pages" = 409201541;
              "Apple Shazam: Identify Songs" = 897118787;
              "Apple Swift Playgrounds" = 1496833156;
              "Apple Testflight" = 899247664;
              "Apple Transporter" = 1450874784;
              #"LanguageTool - Grammar Checker" = 1534275760;
              #"Messenger" = 1480068668;
              "Safari: Black Menu for Wikipedia" = 1543803288;
              "Safari: Dark Readert Pro" = 1438243180;
              "Safari: DuckDuckGo Privacy" = 1482920575;
              "Safari: G App Launcher" = 1543803459;
              "Safari: Inkscape Editor for Graphics" = 6443424132;
              "Safari: LanguageTool" = 1534275760;
              "Safari: Notion Web Clipper" = 1559269364;
              "Safari: Refined GitHub" = 1519867270;
              "Safari: SingleFile" = 6444322545;
              "Safari: Raindrop.io" = 1549370672;
              "Safari: Wayback Machine" = 1472432422;
              "Safari: Web Translator for DeepL" = 6443492610;
              #"Slack" = 803453959;
              "Smart JSON Editor" = 1268962404;
              "Testflight" = 899247664;
              "Ultra CharMap" = 520265986;
              #"Windows App" = 1295203466;
              "Xcode" = 497799835;
              "Xcode: XCFormat" = 1165321484;
              "Xcode: Text Toolset" = 1157225201;
              "Xcode: Comment Wrapper" = 1377998565;
              "Xcode: NamingTranslator" = 1218784832;
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
                name = "atlassian/homebrew-acli";
                clone_target = "https://github.com/atlassian/homebrew-acli.git";
              }
              {
                name = "aerospace/homebrew";
                clone_target = "https://github.com/nikitabobko/homebrew-tap.git";
                force_auto_update = true;
              }
              {
                name = "charmbracelet/homebrew";
                clone_target = "https://github.com/charmbracelet/homebrew-tap.git";
                force_auto_update = true;
              }
              #{
              #  name = "benjiwolff/neovim-nightly";
              #  clone_target = "https://github.com/benjiwolff/homebrew-neovim-nightly.git";
              #  force_auto_update = true;
              #}
              {
                name = "felixkratz/sketchybar";
                clone_target = "https://github.com/felixkratz/homebrew-formulae.git";
                force_auto_update = true;
              }
              {
                name = "jetbrains/utils";
                clone_target = "https://github.com/jetbrains/homebrew-utils.git";
                force_auto_update = true;
              }
              {
                name = "netbirdio/tap";
                clone_target = "https://github.com/netbirdio/homebrew-tap.git";
                force_auto_update = true;
              }
              {
                name = "jackielii/tap";
                clone_target = "https://github.com/jackielii/homebrew-tap.git";
                force_auto_update = true;
              }
              {
                name = "withgraphite/tap";
                clone_target = "https://github.com/withgraphite/homebrew-tap.git";
                force_auto_update = true;
              }
              {
                name = "shivammathur/php";
                clone_target = "https://github.com/shivammathur/homebrew-php.git";
                force_auto_update = true;
              }
              {
                name = "shivammathur/extensions";
                clone_target = "https://github.com/shivammathur/homebrew-extensions.git";
                force_auto_update = true;
              }
            ];
            casks = [
              ## ==> Casks
              "affinity"
              "alfred"
              # "aerospace/homebrew/aerospace"
              "balenaetcher"
              "beyond-compare"
              "bbedit"
              "bitwarden"
              "blender-benchmark"
              "blender"
              "block-goose"
              "brewservicesmenubar"
              "chatgpt"
              "claude"
              "claude-code"
              "cmake-app"
              "codex"
              "crossover"
              "cursor"
              "cutter"
              "devtoys"
              "docker-desktop"
              "dotnet-sdk"
              "duckduckgo"
              "dyalog"
              "emacs-app"
              "emojipedia"
              "expressvpn"
              "flutter"
              "font-alegreya-sans-sc"
              "font-alegreya-sans"
              "font-alegreya-sc"
              "font-fira-code-nerd-font"
              "font-fira-code"
              "font-fira-mono-nerd-font"
              "font-fontawesome"
              "font-geist-mono-nerd-font"
              "font-iosevka-nerd-font"
              "font-iosevka-term-nerd-font"
              "font-iosevka-term-slab-nerd-font"
              "font-jetbrains-mono-nerd-font"
              "font-jetbrains-mono"
              "font-open-dyslexic-nerd-font"
              "font-open-dyslexic"
              "font-overpass-nerd-font"
              "font-recursive-mono-nerd-font"
              "font-sf-mono"
              "font-sf-pro"
              "font-symbols-only-nerd-font"
              "font-zed-mono-nerd-font"
              "font-zen-loop"
              "font-zed-sans"
              "font-zen-antique-soft"
              "font-zen-dots"
              "git-credential-manager"
              "github"
              # "gitkraken-cli"
              # "gitkraken"
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
              "iterm2"
              "itermai"
              "jellyfin-media-player"
              "jellyfin"
              "jetbrains-gateway"
              "jetbrains-space"
              "jetbrains-toolbox"
              "jupyterlab-app"
              "karabiner-elements" "showyedge"
              "kate"
              "keycast"
              "kitty"
              "kodi"
              "languagetool-desktop"
              "lapce"
              "launchcontrol"
              "launchpad-manager"
              "legcord"
              "libreoffice-language-pack"
              "libreoffice"
              "linear-linear"
              "livebook"
              "logitech-g-hub"
              "logseq"
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
              "stolendata-mpv"
              "musescore"
              "neovide-app"
              # "benjiwolff/neovim-nightly/neovim-nightly"
              "netbirdio/tap/netbird-ui"
              "nextcloud"
              "notesollama"
              "notion-calendar"
              "notion-enhanced"
              "notion"
              "obsidian"
              "ollama-app"
              "ollamac"
              "onedrive"
              "onyx"
              # "opera@beta"
              # "oracle-jdk-javadoc"
              "oracle-jdk"
              "orbstack"
              "orion"
              # "paragon-extfs"
              "pgadmin4"
              "podman-desktop"
              "porting-kit"
              "postman"
              "postman-agent"
              "postman-cli"
              "powershell"
              "qownnotes"
              "quarto"
              "r-app"
              "racket"
              "raycast"
              "rstudio"
              "scribus"
              "setapp"
              "sf-symbols"
              "skim"
              "sloth"
              "sqlitemanager"
              "sqlitestudio"
              "steam"
              "steamcmd"
              "streamlabs"
              "swiftdefaultappsprefpane"
              "swiftformat-for-xcode"
              "tailscale-app"
              "tex-live-utility"
              "texstudio"
              "the-unarchiver"
              "vivid-app"
              # "visual-studio-code"
              "visual-studio-code@insiders"
              "vmware-fusion"
              "wakatime"
              "warp"
              "wavebox"
              "wezterm"
              "whatsapp"
              "windows-app"
              "wireshark-app"
              "xcodeclangformat"
              "youtube-downloader"
              "ytmdesktop-youtube-music"
              "yubico-yubikey-manager"
              "zen"
              "zenmap"
              "zoom"
              "zotero@beta"
            ];
            brews = [
              ## ==> Formulae
              "acli"
              "age"
              "age-plugin-se"
              "age-plugin-yubikey"
              "agg"
              "aom"
              "armadillo"
              # "TheZoraiz/ascii-image-converter/ascii-image-converter" # go install github.com/TheZoraiz/ascii-image-converter@latest
              "asciidoc"
              "asciidoctor"
              "asciidoctorj"
              "asciinema"
              "asciiquarium"
              "aspell"
              "atuin"
              "autoconf"
              "autoconf-archive"
              "autoenv"
              "autogen"
              "automake"
              "bash_unit"
              "bash-preexec"
              "bat"
              "bat-extras"
              "bats-core"
              "bdw-gc"
              "bear"
              "bfg"
              "binutils"
              "block-goose-cli"
              "bob"
              "boost"
              "bottom"
              "brotli"
              "btop"
              "buf"
              "bzip2"
              "c-ares"
              "c2048"
              "ca-certificates"
              "caddy"
              "cairo"
              "carapace"
              "cargo-about"
              "cargo-all-features"
              "cargo-audit"
              "cargo-auditable"
              "cargo-binstall"
              "cargo-binutils"
              "cargo-bloat"
              "cargo-bundle"
              "cargo-c"
              "cargo-cache"
              "cargo-careful"
              "cargo-chef"
              "cargo-clone"
              "cargo-component"
              "cargo-crev"
              "cargo-cyclonedx"
              "cargo-deny"
              "cargo-depgraph"
              "cargo-deps"
              "cargo-dist"
              "cargo-docset"
              "cargo-edit"
              "cargo-expand"
              "cargo-flamegraph"
              "cargo-fuzz"
              "cargo-geiger"
              "cargo-generate"
              "cargo-hack"
              "cargo-instruments"
              "cargo-llvm-cov"
              "cargo-llvm-lines"
              "cargo-make"
              "cargo-msrv"
              "cargo-nextest"
              "cargo-outdated"
              "cargo-public-api"
              "cargo-release"
              "cargo-run-bin"
              "cargo-shear"
              "cargo-shuttle"
              "cargo-sort"
              "cargo-spellcheck"
              "cargo-sweep"
              "cargo-udeps"
              "cargo-update"
              "cargo-watch"
              "cargo-zigbuild"
              "cbonsai"
              "ccache"
              "ccls"
              "chafa"
              "charmbracelet/homebrew/charm"
              # "charmbracelet/homebrew/confettysh"  # Formula does not exist in tap
              "charmbracelet/homebrew/crush"
              "charmbracelet/homebrew/freeze"
              "charmbracelet/homebrew/glow"
              "charmbracelet/homebrew/gum"
              "charmbracelet/homebrew/markscribe"
              "charmbracelet/homebrew/melt"
              "charmbracelet/homebrew/mods"
              "charmbracelet/homebrew/pop"
              "charmbracelet/homebrew/sequin"
              "charmbracelet/homebrew/skate"
              "charmbracelet/homebrew/soft-serve"
              "charmbracelet/homebrew/vhs"
              "charmbracelet/homebrew/wishlist"
              "chezmoi"
              "chruby"
              "clang-build-analyzer"
              "clang-format"
              "clang-uml"
              "clangql"
              "clipboard"
              "clojure"
              "clojure-lsp"
              "clojurescript"
              "cmatrix"
              "colima"
              "coreutils"
              "cowsay"
              "cpanminus"
              "croc"
              "curl"
              "curlie"
              "deno"
              "dialog"
              "diff-so-fancy"
              "docker"
              "docker-compose"
              "dooit"
              "dotenv-linter"
              "duf"
              "dust"
              "duti"
              "e2fsprogs"
              "editorconfig"
              "editorconfig-checker"
              "elixir"
              "elixir-ls"
              "erlang"
              "erlang_ls"
              "evil-helix"
              "exercism"
              "exiftool"
              "eza"
              "fastfetch"
              "fd"
              "ffmpeg"
              "ffmpeg2theora"
              "ffmpegthumbnailer"
              "figlet"
              "findutils"
              "fish"
              "fisher"
              "fizsh"
              "flyctl"
              "fnm"
              "fontconfig"
              "fortune"
              "freetype"
              "fribidi"
              "fzf"
              "fzf-make"
              "gawk"
              "gcc"
              "gdu"
              "gemini-cli"
              "gettext"
              "gh"
              "ghcup"
              "ghostscript"
              "giflib"
              "gifsicle"
              "gist"
              "git"
              "git-extras"
              "git-filter-repo"
              "git-flow"
              "git-gui"
              "git-lfs"
              "git-plus"
              "git-tools"
              "gitui"
              "gleam"
              "glib"
              "gmime"
              "gmp"
              "gnu-getopt"
              "gnu-sed"
              "gnupg"
              "gnuplot"
              "gnutls"
              "go"
              "gopls"
              "gpa"
              "gpatch"
              "gpg-tui"
              "gpgme"
              "withgraphite/tap/graphite"
              "graphite2"
              "graphviz"
              "greed"
              "grep"
              "gsl"
              "guile"
              "harfbuzz"
              "hdf5"
              "highway"
              "icu4c@77"
              "ifstat"
              "ijq"
              "imagemagick"
              "imath"
              "imlib2"
              "isl"
              "jasper"
              "jbig2dec"
              "jj"
              "jpeg-turbo"
              "jpeg-xl"
              "jpegoptim"
              "jq"
              "json-c"
              "juliaup"
              "ktlint"
              "kubectl"
              "kubernetes-cli"
              "kubetui"
              "leptonica"
              "lazydocker"
              "lazygit"
              "lazyjj"
              "lazysql"
              "less"
              "lesspipe"
              "lilypond"
              "libarchive"
              "libassuan"
              "libavif"
              "libb2"
              "libcaca"
              "libde265"
              "libdeflate"
              "libevent"
              "libgcrypt"
              "libgit2"
              # "libgit2@1.7"
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
              "lolcat"
              "lpeg"
              "lsd"
              "lua"
              "lua-language-server"
              "luacheck"
              "luajit"
              "luarocks"
              "luv"
              "lynis"
              "lynx"
              "lz4"
              "lzo"
              "m4"
              "make"
              "markdown-oxide"
              "marksman"
              "mas"
              "mediainfo"
              "micro"
              "mmv"
              "mongosh"
              "mpc"
              {
                name = "mpd";
                link = true;
                restart_service = false;
                start_service = false;
              }
              "mpdecimal"
              "mpfr"
              "mplayer"
              "msgpack"
              "nasm"
              "nbsdgames"
              "ncdu"
              "ncurses"
              "neofetch"
              "neomutt"
              # {
              #     name = "neovim";
              #     link = false;
              #     restart_service = false;
              #     start_service = false;
              # }
              "nethack"
              "nettle"
              "newsboat"
              "ninja"
              "ninvaders"
              "notcurses"
              "notmuch"
              "nowplaying-cli"
              "npth"
              "nudoku"
              "nushell"
              "nvm"
              "opencode"
              "openexr"
              "openjpeg"
              "openssh"
              "openssl@3"
              "optipng"
              "ormolu"
              "p11-kit"
              "pango"
              "parallel"
              "pcre"
              "pcre2"
              "perl"
              {
                name = "shivammathur/php/php@8.4";
                #args = [ "--force" ];
                link = true;
                restart_service = false;
                start_service = false;
              }
              "shivammathur/extensions/apcu@8.4"
              "shivammathur/extensions/event@8.4"
              {
                name = "shivammathur/extensions/expect@8.4";
                link = false;
                restart_service = false;
                start_service = false;
              }  # avoid link conflict with core expect
              "shivammathur/extensions/igbinary@8.4"
              "shivammathur/extensions/imagick@8.4"
              "shivammathur/extensions/msgpack@8.4"
              "shivammathur/extensions/opentelemetry@8.4"
              "shivammathur/extensions/pcov@8.4"
              "shivammathur/extensions/pecl_http@8.4"
              "shivammathur/extensions/psr@8.4"
              "shivammathur/extensions/raphf@8.4"
              "shivammathur/extensions/redis@8.4"
              "shivammathur/extensions/uuid@8.4"
              "shivammathur/extensions/xdebug@8.4"
              "shivammathur/extensions/yaml@8.4"
              "shivammathur/extensions/zstd@8.4"
              {
                name = "shivammathur/php/php@8.5";
                #args = [ "--force" ];
                link = false;
                restart_service = false;
                start_service = false;
              }
              "shivammathur/extensions/apcu@8.5"
              {
                name = "shivammathur/extensions/expect@8.5";
                link = false;
                restart_service = false;
                start_service = false;
              }  # avoid link conflict with core expect
              "shivammathur/extensions/expect@8.5"
              "shivammathur/extensions/igbinary@8.5"
              "shivammathur/extensions/imagick@8.5"
              "shivammathur/extensions/msgpack@8.5"
              "shivammathur/extensions/opentelemetry@8.5"
              "shivammathur/extensions/pcov@8.5"
              "shivammathur/extensions/pecl_http@8.5"
              "shivammathur/extensions/psr@8.5"
              "shivammathur/extensions/raphf@8.5"
              "shivammathur/extensions/redis@8.5"
              "shivammathur/extensions/uuid@8.5"
              "shivammathur/extensions/xdebug@8.5"
              "shivammathur/extensions/yaml@8.5"
              "shivammathur/extensions/zstd@8.5"
              "pinentry"
              "pinentry-mac"
              "pipx"
              "pixman"
              "pkg-config"
              "pngpaste"
              "pngquant"
              "podman-tui"
              "portaudio"
              "poppler"
              "posting"
              "prettier"
              "procs"
              "proctools"
              "progress"
              "progressline"
              "pycparser"
              "python-build"
              "python-gdbm@3.14"
              "python-launcher"
              "python-lsp-server"
              "python-markdown"
              "python-matplotlib"
              "python-packaging"
              "python-setuptools"
              "python-tabulate"
              "python-tk@3.14"
              "python@3.14"
              "uv"
              "jetbrains/utils/qodana"
              "rakudo-star"
              "readline"
              "rebar3"
              "ripgrep-all"
              "rlwrap"
              "rtmpdump"
              "ruby"
              "ruby-build"
              "ruby-completion"
              "ruby-install"
              "rubyfmt"
              "rustup"
              "sassc"
              "sbcl"
              "screen"
              "screenfetch"
              "screenresolution"
              "semgrep"
              "shared-mime-info"
              "sheldon"
              "shellcheck"
              "shellharden"
              "shellspec"
              "shfmt"
              "felixkratz/sketchybar/sketchybar"
              "felixkratz/sketchybar/borders"
              "felixkratz/sketchybar/svim"
              "jackielii/tap/skhd-zig"
              "spatialite-gui"
              "spatialite-tools"
              "speedtest-cli"
              "sql-language-server"
              "sqlcipher"
              "sqldiff"
              "sqlite"
              "sqlite-analyzer"
              "sqlite-utils"
              "starship"
              "stow"
              "stylelint"
              "stylua"
              "supervisor"
              "svgo"
              "swift-format"
              "switchaudio-osx"
              "tailwindcss"
              "tailwindcss-language-server"
              "talloc"
              "tcl-tk"
              "tealdeer"
              "teller"
              "terraform"
              "tesseract"
              "texi2html"
              "texinfo"
              "texlab"
              "texlive"
              "tig"
              "tmux"
              "tokyo-cabinet"
              "trash-cli"
              "tree"
              "tree-sitter"
              "tree-sitter-cli"
              "unar"
              "unbound"
              "unibilium"
              "unzip"
              "vivid"
              "w3m"
              "webp"
              "wget"
              "wimlib"
              "wireguard-go"
              "wireguard-tools"
              "x265"
              "xapian"
              "xclip"
              "xdg-ninja"
              "xh"
              "xorgproto"
              "xsel"
              "xxh"
              "xz"
              "yaml-language-server"
              "yamlfmt"
              "yamllint"
              "yazi"
              "ykpers"
              "yq"
              "yt-dlp"
              "yubico-piv-tool"
              "yubikey-agent"
              "z3"
              "zellij"
              "zig"
              "zigmod"
              "zlib"
              "zoxide"
              "zsh-lovers"
              "zsh"
              "zshdb"
              "zstd"
            ];
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
            hostPlatform = hostPlatform;
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

            # vim = {
            #   # vi improved
            #   enable = true;
            #   enableSensible = true;
            #   package = pkgs.vim;
            # };
            # Note: vim module disabled due to vim_configurable deprecation.
            # vim is installed via environment.systemPackages instead.

            zsh = {
              enable = false;
              enableFzfCompletion = false;
              enableFzfGit = false;
              enableFzfHistory = false;
              enableSyntaxHighlighting = false;
            };
          };

          ## security.pam.enableSudoTouchIdAuth = true;

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

            karabiner-elements.enable = true;

            mopidy = {
              enable = false;
              mediakeys.enable = false;
            };

            netbird.enable = true;

            # Auto upgrade nix package and the daemon service.    -- deprecated
            ## nix-daemon.enable = true; # # nix.package = pkgs.nix;

            postgresql = {
              enable = true;
              enableTCPIP = true;
              package = pkgs.postgresql_18.withPackages (ps: [
                ps.postgis
                ps.pg_partman
                ps.pgvector
                ps.timescaledb
                ps.pg_cron
                ps.hypopg
                ps.pgaudit
                ps.pg_hint_plan
                ps.rum
              ]);
              initdbArgs = [
                "--locale=en_GB.UTF-8"
                "--encoding=UTF8"
              ];
              settings = {
                shared_preload_libraries = "pg_stat_statements,pgaudit,pg_cron,timescaledb,auto_explain,pg_hint_plan";
              };
            };

            sketchybar.enable = false;

            spacebar.enable = false;

            #spotifyd.enable = true;

            tailscale.enable = true;
          };

          system = {
            activationScripts.applications.text =
              let
                env = pkgs.buildEnv {
                  name = "system-applications";
                  paths = config.environment.systemPackages;
                  pathsToLink = [
		    "/Applications"
		  ];
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
              #                                 NSGlobalDomain = {
              #                                                                 TISRomanSwitchState = 1;
              #                                 };
              #                                 "com.apple.Safari" = {
              #                                                                 "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
              #                                 };
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
              #alf = {
              #    allowdownloadsignedenabled = 1;
              #    globalstate = 1;
              #    loggingenabled = 1;
              #    stealthenabled = 1;
              #};
              dock = {
                appswitcher-all-displays = true;
                autohide = true;
                enable-spring-load-actions-on-all-items = true;
                largesize = 64;
                magnification = true;
                mineffect = "suck";
                minimize-to-application = true;
                mouse-over-hilite-stack = true;
                # persistent-apps = [
                #                                 "${pkgs.alacritty}/Applications/Alacritty.app"
                #                                 "/Applications/Firefox.app"
                #                                 "${pkgs.obsidian}/Applications/Obsidian.app"
                #                                 "/System/Applications/Mail.app"
                #                                 "/System/Applications/Calendar.app"
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

            # To continue using these options, set `system.primaryUser` to the name
            # of the user you have been using to run `darwin-rebuild`. In the long
            # run, this setting will be deprecated and removed after all the
            # functionality it is relevant for has been adjusted to allow
            # specifying the relevant user separately, moved under the
            # `users.users.*` namespace, or migrated to Home Manager.
            #
            # If you run into any unexpected issues with the migration, please
            # open an issue at <https://github.com/nix-darwin/nix-darwin/issues/new>
            # and include as much information as possible.
            primaryUser = "s-a-c";

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
          (
            { config, ... }:
            {
              homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
            }
          )
          (configuration {
            inherit
              homebrew-bundle
              homebrew-cask
              homebrew-core
              homebrew-services
              shivammathur-extensions
              ;
          })
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              # Automatically migrate existing Homebrew installations
              autoMigrate = true;

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
                "homebrew/homebrew-services" = homebrew-services;
                "shivammathur/homebrew-php" = shivammathur-php;
                "shivammathur/homebrew-extensions" = shivammathur-extensions;
              };
            };
          }
        ];
      };

    };
}
