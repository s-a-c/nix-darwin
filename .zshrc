##
## This file is sourced by zsh upon start-up. It should contain commands to set
## up aliases, functions, options, key bindings, etc.
##

# vim: ft=zsh sw=2 ts=2 et nu rnu ai si

## [profiling.start]  ## {{{
## Load the zsh-profiler plugin
PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
  zmodload zsh/zprof
  # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
  PS4=$'%D{%M%S%.} %N:%i> '
  exec 3>&2 2>"$HOME/startlog.$$"
  setopt xtrace prompt_subst
fi
## }}}  ## [profiling.start]

## [builtins] ## {{{
## [builtins.colors]
autoload -U colors && colors ## Load Colors
## [builtins.smarturls]
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
## [builtins.keybindings]
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
## }}}  ## [builtins]

## [setopt] ## {{{
## [setopt.cd_pushd]
unsetopt auto_cd         ## Use cd by typing directory name if it's not a command.
setopt auto_pushd        ## Make cd push the old directory onto the directory stack.
setopt cdable_vars       ## Change directory to a path stored in a variable.
unsetopt chase_dots      ## Do not treat `.' specially.
unsetopt chase_links     ## Do not treat symlinks specially.
setopt pushd_ignore_dups ## Don't push multiple copies directory onto the directory stack.
setopt pushd_minus       ## Swap the meaning of cd +1 and cd -1 to the opposite.
unsetopt pushd_silent    ## Don't print the directory stack after pushd or popd.
setopt pushd_to_home     ## Push to home directory when no argument is given to pushd.
## [setopt.completions]
setopt always_to_end       ## Move Cursor To The End Of A Completed Word.
setopt auto_list           ## Automatically List Choices On Ambiguous Completion.
setopt auto_menu           ## Show Completion Menu On A Successive Tab Press.
setopt auto_param_slash    ## If Completed Parameter Is A Directory, Add A Trailing Slash.
setopt complete_in_word    ## Complete From Both Ends Of A Word.
unsetopt flow_control      ## Disable Start/Stop Characters In Shell Editor.
setopt list_packed         ## List Packed Directories First.
setopt menu_complete       ## Do Not Autoselect The First Completion Entry.
setopt no_complete_aliases ## Do Not Complete Alias Names.
setopt path_dirs           ## Perform Path Search Even On Command Names With Slashes.
## [setopt.glob]
unsetopt case_glob  ## Use Case-Insensitve Globbing.
setopt globdots     ## Glob Dotfiles As Well.
setopt extendedglob ## Use Extended Globbing.
## [setopt.history]
setopt append_history notify ## Allow multiple sessions to append to one Zsh command history.
setopt bang_hist             ## Treat the '!' character, especially during Expansion.
setopt beep nomatch
setopt extended_history       ## Show Timestamp In History.
setopt hist_expire_dups_first ## Expire A Duplicate Event First When Trimming History.
setopt hist_find_no_dups      ## Do Not Display A Previously Found Event.
setopt hist_ignore_all_dups   ## Remove older duplicate entries from history.
setopt hist_ignore_dups       ## Do not record an event that was just recorded again.
setopt hist_ignore_space      ## Do Not Record An Event Starting With A Space.
setopt hist_reduce_blanks     ## Remove superfluous blanks from history items.
setopt hist_save_no_dups      ## Do not write a duplicate event to the history file.
setopt hist_verify            ## Do Not Execute Immediately Upon History Expansion.
setopt inc_append_history     ## Write to the history file immediately, not when the shell exits.
setopt share_history          ## Share history between different instances of the shell.
## [setopt.Jobs]
setopt auto_resume    ## Attempt To Resume Existing Job Before Creating A New Process.
unsetopt bg_nice      ## Don't Run All Background Jobs At A Lower Priority.
unsetopt check_jobs   ## Don't Report On Jobs When Shell Exit.
unsetopt hup          ## Don't Kill Jobs On Shell Exit.
setopt long_list_jobs ## List Jobs In The Long Format By Default.
setopt notify         ## Report Status Of Background Jobs Immediately.
## [setopt.general]
setopt brace_ccl            ## Allow Brace Character Class List Expansion.
setopt combining_chars      ## Combine Zero-Length Punctuation Characters ( Accents ) With The Base Character.
setopt correct              ## Try to correct the spelling of commands.
setopt correctall           ## Try to correct the spelling of all arguments in a line.
setopt interactive_comments ## Comments even in interactive shells.
unsetopt mail_warning       ## Don't Print A Warning Message If A Mail File Has Been Accessed.
setopt multios              ## Implicit tees or cats when multiple redirections are attempted.
setopt prompt_subst         ## Substitution of parameters inside the prompt each time the prompt is drawn.
setopt rc_quotes            ## Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
setopt zle
## }}}  ## [setopt]

## [plugins]  ## {{{
## [plugins.enhacd]
export ENHANCD_FILTER="fzf --height 40%:fzy"
export ENHANCD_USE_ABBREV="${ENHANCD_USE_ABBREV:-true}"

## [plugins.fzf]
[[ -n "${commands[fzf]}" ]] && {
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  export FZF_ALT_C_OPTS='--preview-window=right:60%:wrap'
  export FZF_COMPLETION_TRIGGER='**'
  export FZF_CTRL_T_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_OPTS='--preview-window=right:60%:wrap'
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  #export FZF_DEFAULT_COMMAND='rg --files  --hidden --iglob="!.git" --line-number'
  export FZF_DEFAULT_OPTS='--ansi --bind=ctrl-j:down,ctrl-k:up,ctrl-h:preview-up,ctrl-l:preview-down --border --color --cycle --height 40% --ignore-case --layout=reverse --multi --nth=2 --preview="bat --color=always --line-range :500 --style=grid,header,numbers {}" --preview-window=right:60%:wrap --prompt="Q> " --wrap'
  export LESSOPEN='| lessfilter-fzf %s'
  #[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
  eval "$(fzf --zsh)"

  ## [fzf.completion]
  [[ -n "${commands[fzf-share]}" ]] && source "$(fzf-share)/completion.zsh"

  ## [fzf.keybindings]
  [[ -n "${commands[fzf-share]}" ]] && source "$(fzf-share)/key-bindings.zsh"
  bindkey '^T' fzf-file-widget
  bindkey '^R' fzf-history-widget
}

## [atuin]  ## {{{
[[ -n "${commands[atuin]}" ]] && {
  typeset -Ag ATUIN
  typeset -gx ATUIN[HOME_DIR]="${XDG_DATA_HOME:-${HOME}/.local/share}/atuin"
  typeset -gx ATUIN[BIN_DIR]="${XDG_DATA_HOME:-${HOME}/.local/share}/atuin/bin"
  typeset -gx ATUIN_HOME=${ATUIN[HOME_DIR]}
  #_field_prepend PATH "${ATUIN[BIN_DIR]}"
  _path_prepend "${ATUIN[BIN_DIR]}"
  [[ -s "${ATUIN[BIN_DIR]}/env" ]] && source "${ATUIN[BIN_DIR]}/env"
  eval "$(atuin init zsh)"
}
## }}}  ## [atuin]

## [avfs]  ## {{{
## AVFS is a system, which enables all programs to look inside archived or compressed files,
## or access remote files without recompiling the programs or changing the kernel.
## At the moment it supports floppies, tar and gzip files, zip, bzip2, ar and rar files,
## ftp sessions, http, webdav, rsh/rcp, ssh/scp.
## Quite a few other handlers are implemented with the Midnight Commander's external FS.
[ -n "${commands[mountavfs]}" ] && mountavfs
## }}}  ## [avfs]

## [bat]  ## {{{
[[ -n "${commands[bat]}" ]] && {
  bat cache --build
  export BAT_THEME='Visual Studio Dark+'
  ## in your .bashrc/.zshrc/*rc
  alias -g bathelp='bat --plain --language=help'
  abbr -g 'bathelp'='bat --plain --language=help'
  help() {
    "$@" --help 2>&1 | bathelp
  }
  alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
  alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
  abbr -g '-h'='-h 2>&1 | bat --language=help --style=plain'
  abbr -g '--help'='--help 2>&1 | bat --language=help --style=plain'
  ## If you want to preview the different themes on a custom file,
  ##   you can use the following command (you need fzf for this):
  #bat --list-themes | fzf --preview="bat --theme={} --color=always /path/to/file"
}
## }}}  ## [bat]

## [bun]
[[ -n "${commands[bun]}" ]] && {
  export BUN_INSTALL=${BUN_INSTALL:="$XDG_DATA_HOME/bun"}
  #_field_prepend PATH "$BUN_INSTALL/bin"
  _path_prepend "$BUN_INSTALL/bin"
}

## [dircolors]  ## {{{
## + enable color support of ls and also add handy aliases
[[ -n "${commands[dircolors]}" ]] && {
  [[ -s ~/.dircolors ]] && eval "$(dircolors --sh ~/.dircolors)" || eval "$(dircolors --sh)"
}

## [dircolors.256dark]  ## {{{
## The following is a list of the 256 colors for your reference.
## 0-15: 16 basic colors
## 16-231: 6*6*6=216 colors: 16 + 36*r + 6*g + b (0 <= r, g, b <= 5)
## 232-255: grayscale from black to white in 24 steps
##
## 0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15
## 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
## 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
## 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
## 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79
## 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
## 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110
## 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125
## 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140
## 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155
## 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170
## 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185
## 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200
## 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215
## 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230
## 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245
## 246 247 248 249 250 251 252 253 254 255
##
## 0: black
## 1: red
## 2: green
## 3: yellow
## 4: blue
## 5: magenta
## 6: cyan
## 7: white
##
## 8: bright black
## 9: bright red
## 10: bright green
## 11: bright yellow
## 12: bright blue
## 13: bright magenta
## 14: bright cyan
## 15: bright white
##
## 16: dark grey
## 17: light red
## 18: light green
## 19: light yellow
## 20: light blue
## 21: light magenta
## 22: light cyan
## 23: light white
##
## 24: dark red
## 25: dark green
## 26: dark yellow
## 27: dark blue
## 28: dark magenta
## 29: dark cyan
## 30: dark white
## }}}  ## [dircolors.256dark]
## }}}  ## [dircolors]

## [direnv]
[[ -n "${commands[direnv]}" ]] && eval  "$(direnv hook zsh)"

## [dirstack] ## {{{
# # - - - - - - - - - - - - - - - - - - - -
# # cdr, persistent cd
# # - - - - - - - - - - - - - - - - - - - -
DIRSTACKFILE="$ZSH_CACHE_DIR/dirs"

## Make `DIRSTACKFILE` If It 'S Not There.
if [[ ! -a $DIRSTACKFILE ]]; then
  mkdir -p ${DIRSTACKFILE[0,-5]}
  touch $DIRSTACKFILE
fi

[[ -f "$DIRSTACKFILE" ]] && [[ $#dirstack -eq 0 ]] && dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )

chpwd() {
  print -l $PWD ${(u)dirstack} >>$DIRSTACKFILE
  local d="$(sort -u $DIRSTACKFILE 2> /dev/null)"
  echo "$d" > $DIRSTACKFILE
}

DIRSTACKSIZE=40

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
## }}}  ## [dirstack]

## [dotnet] ## {{{
[[ -n "${commands[direnv]}" ]] && {
  export DOTNET_CLI_TELEMETRY_OPTOUT="true"
  export DOTNET_CLI_HOME="${DOTNET_CLI_HOME:="$XDG_DATA_HOME/dotnet"}"
  _path_append $DOTNET_CLI_HOME/.dotnet/tools

  ## This script is copied from (MIT License):
  ## https://raw.githubusercontent.com/dotnet/sdk/main/scripts/register-completions.zsh

  ##compdef dotnet
  _dotnet_completion() {
    local -a completions=("${(@f)$(dotnet complete "${words}")}")
    compadd -a completions
    _files
  }
  compdef _dotnet_completion dotnet
}
## }}}  ## [dotnet]

## [emacs] ## {{{
[[ -n "${commands[emacs]}" ]] && {
  ## Emacs
  ## ==> emacs-plus@30

  ## brew install emacs-plus@30     \
  ##   --with-retro-emacs-logo-icon \
  ##   --with-ctags                 \
  ##   --with-dbus                  \
  ##   --with-debug                 \
  ##   --with-mailutils             \
  ##   --with-xwidgets	             \
  ##   --with-imagemagick           \
  ##   --with-native-comp           \
  ##   --with-poll

  ## Emacs.app was installed to:
  ##   /opt/homebrew/opt/emacs-plus@30

  ## To link the application to default Homebrew App location:
  ##   osascript -e 'tell application "Finder" to make alias file to posix file "/opt/homebrew/opt/emacs-plus@30/Emacs.app" at POSIX file "/Applications" with properties {name:"Emacs.app"}'

  ## Your PATH value was injected into Emacs.app/Contents/Info.plist

  ## Report any issues to https://github.com/d12frosted/homebrew-emacs-plus

  ## To start d12frosted/emacs-plus/emacs-plus@30 now and restart at login:
  ##   brew services start d12frosted/emacs-plus/emacs-plus@30
  ## Or, if you don't want/need a background service you can just run:
  ##   /opt/homebrew/opt/emacs-plus@30/bin/emacs --fg-daemon


  ## Start emacs server
  #alias emacs="$(which emacsclient) -c -a '$(which emacs) --daemon ' &"
  #alias em='emacs -nw '

  _path_append $XDG_CONFIG_HOME/emacs/bin

  ## Emacs 23 daemon capability is a killing feature.
  ## One emacs process handles all your frames whether
  ## you use a frame opened in a terminal via a ssh connection or X frames
  ## opened on the same host.

  ## Benefits are multiple
  ## - You don't have the cost of starting Emacs all the time anymore
  ## - Opening a file is as fast as Emacs does not have anything else to do.
  ## - You can share opened buffered across opened frames.
  ## - Configuration changes made at runtime are applied to all frames.

  ## Require emacs version to be minimum 24
  autoload -Uz is-at-least
  #is-at-least 24 "${${(Az)"$(emacsclient --version 2>/dev/null)"}[2]}" || return 0

  ## Handle $0 according to the standard:
  ## https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html
  #0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
  #0="${${(M)0:#/*}:-$PWD/$0}"

  ## Path to custom emacsclient launcher
  export EMACS_PLUGIN_LAUNCHER="${0:A:h}/emacsclient.sh"

  ## set EDITOR if not already defined.
  #export EDITOR="${EDITOR:-${EMACS_PLUGIN_LAUNCHER}}"

  alias e="$EMACS_PLUGIN_LAUNCHER --no-wait"
  ##alias emacs=e
  ## open terminal emacsclient
  alias te="$EMACS_PLUGIN_LAUNCHER -nw"

  ## same than M-x eval but from outside Emacs.
  alias eeval="$EMACS_PLUGIN_LAUNCHER --eval"
  abbr 'eeval'='"$EMACS_PLUGIN_LAUNCHER" --eval'
  ## create a new X frame
  ##alias eframe='emacsclient --alternate-editor="" --create-frame'
  alias eframe="$EMACS_PLUGIN_LAUNCHER --create-frame --alternate-editor=''"
  abbr 'eframe'='"$EMACS_PLUGIN_LAUNCHER" --create-frame --alternate-editor=""'

  ## Emacs ANSI Term tracking
  [[ -n "$INSIDE_EMACS" ]] && {
    chpwd_emacs() { print -P "\033AnSiTc %d"; }
    print -P "\033AnSiTc %d"    ## Track current working directory
    print -P "\033AnSiTu %n"    ## Track username

    ## add chpwd hook
    autoload -Uz add-zsh-hook
    add-zsh-hook chpwd chpwd_emacs
  }

  ## Write to standard output the path to the file
  ## opened in the current buffer.
  function efile {
    local cmd="(buffer-file-name (window-buffer))"
    local file="$("$EMACS_PLUGIN_LAUNCHER" --eval "$cmd" | tr -d \")"

    if [[ -z "$file" ]]; then
      echo "Can't deduce current buffer filename." >&2
      return 1
    fi

    echo "$file"
  }

  ## Write to standard output the directory of the file
  ## opened in the current buffer
  function ecd {
    local file
    file="$(efile)" || return $?
    echo "${file:h}"
  }
}
## }}}  ## [emacs]

## [eza]  ## {{{
[[ -n "${commands[eza]}" ]] && {
  alias eza='eza --color=always --icons --group-directories-first'
  alias l='eza --long --header --git'
  alias la='eza --long --header --git --all'
  alias ll='eza --long --header --git --all --level=2'
  alias lt='eza --long --header --git --tree'
  alias lta='eza --long --header --git --tree --all'
  alias ltr='eza --long --header --git --tree --reverse'
  alias ltra='eza --long --header --git --tree --reverse --all'
  alias lx='eza --long --header --git --sort=extension'
  alias lxa='eza --long --header --git --sort=extension --all'
  alias lX='eza --long --header --git --sort=extension --reverse'
  alias lXa='eza --long --header --git --sort=extension --reverse --all'
  alias lS='eza --long --header --git --sort=size'
  alias lSa='eza --long --header --git --sort=size --all'
  alias lSr='eza --long --header --git --sort=size --reverse'
  alias lSra='eza --long --header --git --sort=size --reverse --all'
  alias lD='eza --long --header --git --sort=date'
  alias lDa='eza --long --header --git --sort=date --all'
  alias lDr='eza --long --header --git --sort=date --reverse'
  alias lDra='eza --long --header --git --sort=date --reverse --all'
  alias lR='eza --long --header --git --sort=reverse'
  alias lRa='eza --long --header --git --sort=reverse --all'
  alias lRr='eza --long --header --git --sort=reverse --reverse'
  alias lRra='eza --long --header --git --sort=reverse --reverse --all'
  alias lT='eza --long --header --git --sort=type'
  alias lTa='eza --long --header --git --sort=type --all'
  alias lTr='eza --long --header --git --sort=type --reverse'
  alias lTra='eza --long --header --git --sort=type --reverse --all'
  abbr 'eza'='eza --color=always --icons --group-directories-first'
  abbr 'l'='eza --long --header --git'
  abbr 'la'='eza --long --header --git --all'
  abbr 'll'='eza --long --header --git --all --level=2'
  abbr 'lt'='eza --long --header --git --tree'
  abbr 'lta'='eza --long --header --git --tree --all'
  abbr 'ltr'='eza --long --header --git --tree --reverse'
  abbr 'ltra'='eza --long --header --git --tree --reverse --all'
  abbr 'lx'='eza --long --header --git --sort=extension'
  abbr 'lxa'='eza --long --header --git --sort=extension --all'
  abbr 'lX'='eza --long --header --git --sort=extension --reverse'
  abbr 'lXa'='eza --long --header --git --sort=extension --reverse --all'
  abbr 'lS'='eza --long --header --git --sort=size'
  abbr 'lSa'='eza --long --header --git --sort=size --all'
  abbr 'lSr'='eza --long --header --git --sort=size --reverse'
  abbr 'lSra'='eza --long --header --git --sort=size --reverse --all'
  abbr 'lD'='eza --long --header --git --sort=date'
  abbr 'lDa'='eza --long --header --git --sort=date --all'
  abbr 'lDr'='eza --long --header --git --sort=date --reverse'
  abbr 'lDra'='eza --long --header --git --sort=date --reverse --all'
  abbr 'lR'='eza --long --header --git --sort=reverse'
  abbr 'lRa'='eza --long --header --git --sort=reverse --all'
  abbr 'lRr'='eza --long --header --git --sort=reverse --reverse'
  abbr 'lRra'='eza --long --header --git --sort=reverse --reverse --all'
  abbr 'lT'='eza --long --header --git --sort=type'
  abbr 'lTa'='eza --long --header --git --sort=type --all'
  abbr 'lTr'='eza --long --header --git --sort=type --reverse'
  abbr 'lTra'='eza --long --header --git --sort=type --reverse --all'
}
## }}}  ## [eza]

## [ghcup]
[[ -n "${commands[ghcup]}" ]] && {
  export BOOTSTRAP_HASKELL_CABAL_XDG=${BOOTSTRAP_HASKELL_CABAL_XDG:="true"}
  export GHCUP_USE_XDG_DIRS=${GHCUP_USE_XDG_DIRS:="true"}
  export STACK_XDG=${STACK_XDG:="true"}
  [[ -s "$XDG_DATA_HOME/ghcup/env" ]] && source "$XDG_DATA_HOME/ghcup/env"
}
## }}}  ## [ghcup]

## [ghostty]    ## Ghostty shell integration for Zsh. This must be at the top of your zshrc!
[[ -n "${GHOSTTY_RESOURCES_DIR}" ]] && source "${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration"

## [go] ## {{{
[[ -n "${commands[go]}" ]] && {
  export GOBIN=${GOBIN:="$GOPATH/bin"}
  export GOENV=${GOENV:="$XDG_CONFIG_HOME/go"}
  export GOPATH=${GOPATH:="$XDG_DATA_HOME/go"}

  # + Custom go binaries are installed in $GOPATH/bin.
  _path_append "$GOPATH/bin"

  [[ ! -f "$GOPATH/bin/gofumpt" ]] && go install mvdan.cc/gofumpt@latest
  [[ ! -f "$GOPATH/bin/golangci-lint" ]] && go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
  [[ ! -f "$GOPATH/bin/revive" ]] && go install github.com/mgechev/revive@latest
}
## }}}  ## [go]

## [gpg]
#[[ -n "${commands[gpg]}" ]] export GNUPGHOME=${GNUPGHOME:="$XDG_DATA_HOME/gnupg"}

## [gpg-agent]  ## {{{
[[ -n "${commands[gpg-agent]}" ]] && {
  export GPG_AGENT_INFO_FILE="${XDG_RUNTIME_DIR}/gpg-agent-info"
  export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
  export SSH_AGENT_PID_FILE="${XDG_RUNTIME_DIR}/gpg-agent.pid"
  export SSH_AGENT_PID="$(cat $SSH_AGENT_PID_FILE)"
  export SSH_AUTH_SOCK="$(cat $SSH_AUTH_SOCK)"
}
## }}}  ## [gpg-agent]

## [gpgconf]
[[ -n "${commands[gpgconf]}" ]] && export GPG_TTY=$(tty)

## [guile] ## {{{
# [[ -n "${commands[guile]}" ]] && {
#   export GUILE_LOAD_PATH="$(brew --prefix)/share/guile/site/3.0"
#   export GUILE_LOAD_COMPILED_PATH="$(brew --prefix)/lib/guile/3.0/site-ccache"
#   export GUILE_SYSTEM_EXTENSIONS_PATH="$(brew --prefix)/lib/guile/3.0/extensions"
#   export GUILE_LOAD_PATH="${GUILE_LOAD_PATH}:${GUILE_SYSTEM_EXTENSIONS_PATH}"
#   export GUILE_LOAD_PATH="${GUILE_LOAD_PATH}:${GUILE_LOAD_COMPILED_PATH}"
#   export GUILE_LOAD_PATH="${GUILE_LOAD_PATH}:${XDG_DATA_HOME}/guile"
#   export GUILE_LOAD_PATH="${GUILE_LOAD_PATH}:${XDG_DATA_HOME}/guile/site"
#   export GUILE_LOAD_PATH="${GUILE_LOAD_PATH}:${XDG_DATA_HOME}/guile/site-ccache"
#   export GUILE_LOAD_PATH="${GUILE_LOAD_PATH}:${XDG_DATA_HOME}/guile/site-extensions"
#   export GUILE_LOAD_PATH="${GUILE_LOAD_PATH}:${XDG_DATA_HOME}/guile/site-compiled"
#   export GUILE_TLS_CERTIFICATE_DIRECTORY="$(brew --prefix)/etc/gnutls/"
# }
## }}}  ## [guile]

## [gum] ## {{{
## + Uses values configured through environment variables above but can still be overridden with flags.
## + https://github.com/charmbracelet/gum
[[ -n "${commands[gum]}" ]] && {
  export GUM_INPUT_CURSOR_FOREGROUND="#FF0"
  export GUM_INPUT_PROMPT_FOREGROUND="#0FF"
  export GUM_INPUT_PLACEHOLDER="What's up?"
  export GUM_INPUT_PROMPT="* "
  export GUM_INPUT_WIDTH=80
}
# }}} *** GUM

## [homebrew] ## {{{
if [[ ! -n "${commands[brew]}" ]]; then
  #if (( ! $+commands[brew] )); then
  if [[ -n "$BREW_LOCATION" ]]; then
    if [[ ! -x "$BREW_LOCATION" ]]; then
      echo "[zshrc] $BREW_LOCATION is not executable"
      return
    fi
  elif [[ -x /opt/homebrew/bin/brew ]]; then
    BREW_LOCATION="/opt/homebrew/bin/brew"
  elif [[ -x /usr/local/bin/brew ]]; then
    BREW_LOCATION="/usr/local/bin/brew"
  elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    BREW_LOCATION="/home/linuxbrew/.linuxbrew/bin/brew"
  elif [[ -x "$HOME/.linuxbrew/bin/brew" ]]; then
    BREW_LOCATION="$HOME/.linuxbrew/bin/brew"
  else
    return
  fi

  ## Only add Homebrew installation to PATH, MANPATH, and INFOPATH if brew is
  ## not already on the path, to prevent duplicate entries. This aligns with
  ## the behavior of the brew installer.sh post-install steps.
  eval "$($BREW_LOCATION shellenv)"
  unset BREW_LOCATION
fi

[[ -z "$HOMEBREW_PREFIX" ]] && {
  ## Maintain compatability with potential custom user profiles, where we had
  ## previously relied on always sourcing shellenv. OMZ plugins should not rely
  ## on this to be defined due to out of order processing.
  HOMEBREW_PREFIX="$(brew --prefix)" && export HOMEBREW_PREFIX
}
export HOMEBREW_AUTO_UPDATE_SECS="86400"

[[ -d "$HOMEBREW_PREFIX/share/zsh/site-functions" ]] && {
  fpath+=("$HOMEBREW_PREFIX/share/zsh/site-functions")
  #_field_append FPATH "$HOMEBREW_PREFIX/share/zsh/site-functions"
  export FPATH="$FPATH:$HOMEBREW_PREFIX/share/zsh/site-functions"
}

abbr 'bcubc'='brew upgrade --cask && brew cleanup'
abbr 'bcubo'='brew update && brew outdated --cask'
abbr 'brewp'='brew pin'
abbr 'brewsp'='brew list --pinned'
abbr 'bubc'='brew upgrade && brew cleanup'
abbr 'bugbc'='brew upgrade --greedy && brew cleanup'
abbr 'bubo'='brew update && brew outdated'
abbr 'bubu'='bubo && bubc'
abbr 'bubug'='bubo && bugbc'
abbr 'bfu'='brew upgrade --formula'
abbr 'buz'='brew uninstall --zap'

function brews() {
  local formulae="$(brew leaves | xargs brew deps --installed --for-each)"
  local casks="$(brew list --cask 2>/dev/null)"

  local lightblue="$(tput setaf 4)"
  local bold="$(tput bold)"
  local off="$(tput sgr0)"

  echo "${lightblue}==>${off} ${bold}Formulae${off}"
  echo "${formulae}" | sed "s/^\(.*\):\(.*\)$/\1${lightblue}\2${off}/"
  echo "\n${lightblue}==>${off} ${bold}Casks${off}\n${casks}"
}

[[ -n "$HOMEBREW_PREFIX" ]] && {
  ## A note on WASM and LLVM binaries #
  ## In order to compile for WASM, Odin calls out to wasm-ld for linking.
  ## This requires it to be available through your $PATH.
  ## By default, brew does not add any of LLVM’s binaries to your $PATH and you will need to
  ## symlink it to a place where it is able to be found.
  ## You can symlink it to /usr/local/bin by doing ln -s $(brew --prefix llvm)/bin/wasm-ld /usr/local/bin/wasm-ld.
  ##
  ## Alternatively, you can add the entire $(brew --prefix llvm)/bin to your $PATH, but brew does not recommend it.

  #_field_prepend PATH "$HOMEBREW_PREFIX/sbin"
  _path_prepend "$HOMEBREW_PREFIX/sbin"
  #_field_prepend PATH "$HOMEBREW_PREFIX/bin"
  _path_prepend "$HOMEBREW_PREFIX/bin"
}
## }}}  ## [homebrew]

## [julia]  ## {{{
[[ -n "${commands[julia]}" ]] && {
  export JULIA_DEPOT_PATH=${JULIA_DEPOT_PATH:="$XDG_DATA_HOME/julia"}
  export JULIA_LOAD_PATH=${JULIA_LOAD_PATH:="$XDG_DATA_HOME/julia"}
  export JULIA_PKG_SERVER=${JULIA_PKG_SERVER:="https://mirrors.sjtug.sjtu.edu.cn/julia"}
  export JULIA_HISTORY=${JULIA_HISTORY:="$XDG_DATA_HOME/julia/julia_history.jl"}
  export JULIA_NUM_THREADS=${JULIA_NUM_THREADS:="4"}
  export JULIA_EDITOR=${JULIA_EDITOR:="nvim"}
  export JULIA_VIM=${JULIA_VIM:="nvim"}
  export JULIA_VIM_INIT=${JULIA_VIM_INIT:="startinsert"}
  export JULIA_VIM_ARGS=${JULIA_VIM_ARGS:="--nofork"}
  export JULIA_VIM_COLOR=${JULIA_VIM_COLOR:="dark"}
  export JULIA_VIM_THEME=${JULIA_VIM_THEME:="base16-ocean"}
  export JULIA_VIM_FONT=${JULIA_VIM_FONT:="OpenDyslexicM Nerd Font"}
  export JULIA_VIM_FONT_SIZE=${JULIA_VIM_FONT_SIZE:="12"}
  export JULIA_VIM_FONT_WEIGHT=${JULIA_VIM_FONT_WEIGHT:="normal"}
  export JULIA_VIM_FONT_STYLE=${JULIA_VIM_FONT_STYLE:="normal"}
  export JULIA_VIM_FONT_LIGATURES=${JULIA_VIM_FONT_LIGATURES:="true"}
  export JULIA_VIM_FONT_ANTIALIAS=${JULIA_VIM_FONT_ANTIALIAS:="true"}
  export JULIA_VIM_FONT_AUTOHINT=${JULIA_VIM_FONT_AUTOHINT:="true"}
  export JULIA_VIM_FONT_HINTING=${JULIA_VIM_FONT_HINTING:="full"}
  export JULIA_VIM_FONT_HINT_STYLE=${JULIA_VIM_FONT_HINT_STYLE:="hintslight"}
  export JULIA_VIM_FONT_SUBPIXEL=${JULIA_VIM_FONT_SUBPIXEL:="rgb"}
  export JULIA_VIM_FONT_VERTICAL_LIGATURES=${JULIA_VIM_FONT_VERTICAL_LIGATURES:="true"}
  export JULIA_VIM_FONT_HORIZONTAL_LIGATURES=${JULIA_VIM_FONT_HORIZONTAL_LIGATURES:="true"}
  export JULIA_VIM_FONT_VARIABLES=${JULIA_VIM_FONT_VARIABLES:="true"}
  ## [juliaup]  ## {{{
  [[ ! -s "$XDG_CONFIG_HOME/julialang/autocomplete/juliaup.zsh" ]] && {
    mkdir -p "$XDG_CONFIG_HOME/julialang/autocomplete"
    juliaup completions zsh >> "$XDG_CONFIG_HOME/julialang/autocomplete/juliaup.zsh"
  }
  source "$XDG_CONFIG_HOME/julialang/autocomplete/juliaup.zsh"
  ## }}}  ## [juliaup]
}
## }}}  ## [julia]

## [jupyter]
[[ -n "${commands[jupyter]}" ]] && export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"

## [kitty] ## {{{
[[ -n "${commands[kitty]}" ]] && {
  export KITTY_CONFIG_DIRECTORY="${XDG_CONFIG_HOME}/kitty"
  export KITTY_THEME="base16-ocean"

  if [[ "$(uname)" == "Darwin" ]]; then
    ## Do something under Mac OS X platform
    export KITTY_INSTALLATION_DIR="/Applications/kitty.app/Contents/MacOS"
    if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/../Resources/kitty/shell-integration/zsh/kitty.zsh"; then
      source "$KITTY_INSTALLATION_DIR/../Resources/kitty/shell-integration/zsh/kitty.zsh"
    fi
    :
  elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
    ## Do something under GNU/Linux platform
    if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/zsh/kitty.zsh"; then
      source "$KITTY_INSTALLATION_DIR/shell-integration/zsh/kitty.zsh"
    fi
    :
  elif [[ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]]; then
    ## Do something under 32 bits Windows NT platform
    :
  elif [[ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]]; then
    ## Do something under 64 bits Windows NT platform
    :
  fi
}
## }}}  ## [kitty]

## [lesspipe]
## make less more friendly for non-text input files, see lesspipe(1)
[[ -n ${commands[lesspipe.sh]} ]] && export LESSOPEN=' | lesspipe.sh %s'

## [luarocks] ## {{{
[[ -n "${commands[luarocks]}" ]] && {
  export LUA_PATH="$LUA_PATH;$XDG_DATA_HOME/lua/?.lua"
  export LUA_CPATH="$LUA_CPATH;$XDG_DATA_HOME/lua/?.so"
  export LUAROCKS_CONFIG=${LUAROCKS_CONFIG:="$XDG_CONFIG_HOME/luarocks/config-5.4.lua"}
  export LUAROCKS_HOME_TREE=${LUAROCKS_HOME_TREE:="$XDG_DATA_HOME/luarocks"}
  # Luarocks bin path
  [[ -d "$LUAROCKS_HOME_TREE/bin" ]] || [[ $(mkdir -p $LUAROCKS_HOME_TREE/bin) ]] && _path_prepend "$LUAROCKS_HOME_TREE/bin"
}
## }}}  ## [luarocks]

## [nvim] ## {{{
[[ -n "${commands[nvim]}" ]] && {
  ## [nvim.bob]  ## {{{
  ## Bob Neovim version manager configuration
  export BOB_CONFIG=$XDG_CONFIG_HOME/bob/config.json
  [[ -n "${commands[bob]}" ]] && {
    ## Bob neovim path
    [[ -d ${XDG_DATA_HOME}/bob/nvim-bin ]] && _path_prepend "${XDG_DATA_HOME}/bob/nvim-bin"
    bob use stable
    bob sync
    bob update --all
  }
  ## }}}  ## [nvim.bob]

  ## [nvim.lazyman]  ## {{{
  ## git clone https://github.com/doctorfree/nvim-lazyman $XDG_CONFIG_HOME/nvim-Lazyman
  [[ -n "${comands[lazyman]}" ]] && {
    ## Lazyman Neovim configuration
    ## Source the Lazyman shell initialization for aliases and nvims selector
    [[ -s $XDG_CONFIG_HOME/nvim-Lazyman/.lazymanrc ]] && source $XDG_CONFIG_HOME/nvim-Lazyman/.lazymanrc
    ## Source the Lazyman .nvimsbind for nvims key binding
    [[ -r $XDG_CONFIG_HOME/nvim-Lazyman/.nvimsbind ]] && source $XDG_CONFIG_HOME/nvim-Lazyman/.nvimsbind

    ## To easily switch between lazyman installed Neovim configurations,
    ## shell aliases and the 'nvims' and 'neovides' commands have been created.

    ## Aliases like the following are defined in ~/.config/nvim-Lazyman/.lazymanrc
    alias lmvim="source $XDG_DATA_HOME/nvim-Lazyman/bin/activate && NVIM_APPNAME=nvim-Lazyman \nvim"
    abbr 'lmvim'='"source $XDG_DATA_HOME/nvim-Lazyman/bin/activate && NVIM_APPNAME=nvim-Lazyman \nvim"'
  }
}
## }}}  ## [nvim.lazyman]
## }}}  ## [nvim]

## [opam] ## {{{
[[ -n "${commands[opam]}" ]] && {
  export OPAMROOT=${OPAMROOT:="$XDG_DATA_HOME/opam"}
  export OPAMSWITCH=${OPAMSWITCH:="default"}
  _path_prepend "$OPAMROOT/$OPAMSWITCH/bin"
}

## [ocaml] ## {{{
#[[ -n "${commands=ocaml}" ]] && {
  #export CAML_LD_LIBRARY_PATH="$OPAM_SWITCH_PREFIX/lib/stublibs:$OPAM_SWITCH_PREFIX/lib/ocaml/stublibs:$OPAM_SWITCH_PREFIX/lib/ocaml"
  export OCAMLRUNPARAM="b"
  export OCAML_TOPLEVEL_PATH="$XDG_DATA_HOME/ocaml"
  export OCAML_TOPLEVEL_HISTORY="$XDG_DATA_HOME/ocaml/toplevel-history"
  export OPAMROOT="$XDG_DATA_HOME/opam"
#}

## [ocaml.dune] ##
[[ -n "${commands[dune]}" ]] && export DUNE_CACHE="$XDG_CACHE_HOME/dune"

## [ocaml.opam] ## {{{
[[ -n "${commands[opam]}" ]] && {
  ## opam configuration
  ## - shell completion
  ## - environment setup
  ## - opam aliases
  [[ -s "$OPAMROOT/opam-init/init.zsh" ]] && source "$OPAMROOT/opam-init/init.zsh" > /dev/null 2>&1
  [[ -s "$OPAMROOT/opam-init/opam-switch.sh" ]] && source "$OPAMROOT/opam-init/opam-switch.sh" > /dev/null 2>&1
  [[ -s "$OPAMROOT/opam-init/opam-aliases.sh" ]] && source "$OPAMROOT/opam-init/opam-aliases.sh" > /dev/null 2>&1

  export OPAM_SWITCH_PREFIX="$OPAMROOT/default"
  #export OCAML_TOPLEVEL_PATH="$OPAM_SWITCH_PREFIX/lib/toplevel"

  typeset -agx _OPAM_SWITCH_DEFAULT=(core core_bench dune js_of_ocaml js_of_ocaml-ppx merlin ocaml-lsp-server ocamlformat ocp-indent odoc opam-client opam-installer tuareg user-setup utop)
  typeset -agx _OPAM_SWITCH_JANESTREET=(async base base_quickcheck bonsai core core_unix dune incr_dom incremental patdiff ppx_jane)
  typeset -agx _OPAM_SWITCH_OCSIGEN=(logs-async ocsigen-start ocsipersist-pgsql-config ocsipersist-sqlite-config pgx_lwt riot)
  typeset -agx _OPAM_SWITCH_REASON=(dune melange reason reason-react reason-react-ppx)
  _OPAM_SWITCH_REASON+=($_OPAM_SWITCH_JANESTREET)
  _OPAM_SWITCH_OCSIGEN+=($_OPAM_SWITCH_JANESTREET)

  unset _OPAM_SWITCH && typeset -Agx _OPAM_SWITCH
  typeset -gx _OPAM_SWITCH[reason]=$_OPAM_SWITCH_REASON
  typeset -gx _OPAM_SWITCH[ocsigen]=$_OPAM_SWITCH_OCSIGEN
  typeset -gx _OPAM_SWITCH[janestreet]=$_OPAM_SWITCH_JANESTREET
  typeset -gx _OPAM_SWITCH[default]=$_OPAM_SWITCH_DEFAULT

  function opam_switches() {
    for switch in $(opam switch list -s); do
      echo "\n<><> opam install --switch $switch \"$@\" <><><><><><><><>\n"
      opam install --switch $switch "$@"
    done
  }

  ## ENVIRONMENT
  # Opam makes use of the environment variables listed here. Boolean variables should be set to "0", "no", "false" or the empty string to disable, "1", "yes" or "true" to enable.
  export OPAMALLPARENS=true # surround all filters with parenthesis.
  # OPAMASSUMEDEPEXTS see option ‘--assume-depexts'.
  # OPAMAUTOREMOVE see remove option ‘--auto-remove'.
  # OPAMBESTEFFORT see option ‘--best-effort'.
  # OPAMBESTEFFORTPREFIXCRITERIA sets the string that must be prepended to the criteria when the ‘--best-effort' option is set, and is expected to maximise the ‘opam-query' property in the solution.
  # OPAMBUILDDOC Removed in 2.1.
  # OPAMBUILDTEST Removed in 2.1.
  # OPAMCLI see option ‘--cli'.
  export OPAMCOLOR=always # when set to always or never, sets a default value for the ‘--color' option.
  # OPAMCONFIRMLEVEL see option ‘--confirm-level‘. OPAMCONFIRMLEVEL has priority over OPAMYES and OPAMNO.
  # OPAMCRITERIA specifies user preferences for dependency solving. The default value depends on the solver version, use ‘config report' to know the current setting. See also option --criteria.
  # OPAMCUDFFILE save the cudf graph to file-actions-explicit.dot.
  # OPAMCUDFTRIM controls the filtering of unrelated packages during CUDF preprocessing.
  # OPAMCURL can be used to select a given 'curl' program. See OPAMFETCH for more options.
  # OPAMDEBUG see options ‘--debug' and ‘--debug-level'.
  # OPAMDEBUGSECTIONS if set, limits debug messages to the space-separated list of sections. Sections can optionally have a specific debug level (for example, CLIENT:2 or CLIENT CUDF:2), but otherwise use ‘--debug-level'.
  # OPAMDIGDEPTH defines how aggressive the lookup for conflicts during CUDF preprocessing is.
  # OPAMDOWNLOADJOBS sets the maximum number of simultaneous downloads.
  # OPAMDROPWORKINGDIR overrides packages previously updated with --working-dir on update. Without this variable set, opam would keep them unchanged unless explicitly named on the command-line.
  # OPAMDRYRUN see option ‘--dry-run'.
  # OPAMEDITOR sets the editor to use for opam file editing, overrides $EDITOR and $VISUAL.
  # OPAMERRLOGLEN sets the number of log lines printed when a sub-process fails. 0 to print all.
  # OPAMEXTERNALSOLVER see option ‘--solver'.
  # OPAMFAKE see option ‘--fake'.
  # OPAMFETCH specifies how to download files: either ‘wget', ‘curl' or a custom command where variables %{url}%, %{out}%, %{retry}%, %{compress}% and %{checksum}% will be replaced. Overrides the 'download-command' value from the main config file.
  # OPAMFIXUPCRITERIA same as OPAMUPGRADECRITERIA, but specific to fixup and reinstall.
  # OPAMIGNORECONSTRAINTS see install option ‘--ignore-constraints-on'.
  # OPAMIGNOREPINDEPENDS see option ‘--ignore-pin-depends'.
  # OPAMINPLACEBUILD see option ‘--inplace-build'.
  # OPAMJOBS sets the maximum number of parallel workers to run.
  # OPAMJSON log json output to the given file (use character ‘%' to index the files).
  # OPAMKEEPBUILDDIR see install option ‘--keep-build-dir'.
  # OPAMKEEPLOGS tells opam to not remove some temporary command logs and some backups. This skips some finalisers and may also help to get more reliable backtraces.
  # OPAMLOCKED combination of ‘--locked' and ‘--lock-suffix' options.
  # OPAMLOGS logdir sets log directory, default is a temporary directory in /tmp
  # OPAMMAKECMD set the system make command to use.
  # OPAMMERGEOUT merge process outputs, stderr on stdout.
  # OPAMNO answer no to any question asked, see options ‘--no‘ and ‘--confirm-level‘. OPAMNO is ignored if either OPAMCONFIRMLEVEL or OPAMYES is set.
  # OPAMNOAGGREGATE with ‘opam admin check', don't aggregate packages.
  # OPAMNOASPCUD Deprecated.
  # OPAMNOAUTOUPGRADE disables automatic internal upgrade of repositories in an earlier format to the current one, on 'update' or 'init'.
  # OPAMNOCHECKSUMS enables option --no-checksums when available.
  # OPAMNODEPEXTS disables system dependencies handling, see option ‘--no-depexts'.
  # OPAMNOENVNOTICE Internal.
  # OPAMNOSELFUPGRADE see option ‘--no-self-upgrade'
  # OPAMPINKINDAUTO sets whether version control systems should be detected when pinning to a local path. Enabled by default since 1.3.0.
  # OPAMPRECISETRACKING fine grain tracking of directories.
  # OPAMPREPRO set this to false to disable CUDF preprocessing. Less efficient, but might help debugging solver issue.
  # OPAMREPOSITORYTARRING internally store the repositories as tar.gz files. This can be much faster on filesystems that don't cope well with scanning large trees but have good caching in /tmp. However this is slower in the general case.
  # OPAMREQUIRECHECKSUMS Enables option ‘--require-checksums' when available (e.g. for ‘opam install').
  # OPAMRETRIES sets the number of tries before failing downloads.
  # OPAMREUSEBUILDDIR see option ‘--reuse-build-dir'.
  # OPAMROOT see option ‘--root'. This is automatically set by ‘opam env --root=DIR --set-root'.
  # OPAMROOTISOK don't complain when running as root.
  # OPAMSAFE see option ‘--safe'.
  # OPAMSHOW see option ‘--show'.
  # OPAMSKIPUPDATE see option ‘--skip-updates'.
  # OPAMSKIPVERSIONCHECKS bypasses some version checks. Unsafe, for compatibility testing only.
  # OPAMSOLVERALLOWSUBOPTIMAL (default ‘true') allows some solvers to still return a solution when they reach timeout; while the solution remains assured to be consistent, there is no guarantee in this case that it fits the expected optimisation criteria. If ‘true', opam willcontinue with a warning, if ‘false' a timeout is an error. Currently only the builtin-z3 backend handles this degraded case.
  # OPAMSOLVERTIMEOUT change the time allowance of the solver. Default is 60.0, set to 0 for unlimited. Note that all solvers may not support this option.
  export OPAMSTATS=false # display stats at the end of command. # true _may_ be useful for debugging but _can_ disturb batch processing.
  export OPAMSTATUSLINE=always # display a dynamic status line showing what's currently going on on the terminal. (one of one of always, never or auto)
  # OPAMSTRICT fail on inconsistencies (file reading, switch import, etc.).
  # OPAMSWITCH see option ‘--switch'. Automatically set by ‘opam env --switch=SWITCH --set-switch'.
  # OPAMUNLOCKBASE see install option ‘--unlock-base'.
  # OPAMUPGRADECRITERIA specifies user preferences for dependency solving when performing an upgrade. Overrides OPAMCRITERIA in upgrades if both are set. See also option --criteria.
  # OPAMUSEINTERNALSOLVER see option ‘--use-internal-solver'.
  # OPAMUSEOPENSSL Removed in 2.2.
  export OPAMUTF8=always # use UTF8 characters in output (one of one of always, never or auto). By default ‘auto', which is determined from the locale).
  # OPAMUTF8MSGS use extended UTF8 characters (camels) in opam messages. Implies OPAMUTF8. This is set by default on macOS only.
  # OPAMVALIDATIONHOOK if set, uses the ‘%{hook%}' command to validate an opam repository update.
  # OPAMVERBOSE see option ‘--verbose'.
  # OPAMVERBOSEON see option --verbose-on
  # OPAMVERSIONLAGPOWER do not use.
  # OPAMWITHDEVSETUP see install option ‘--with-dev-setup'.
  # OPAMWITHDOC see install option ‘--with-doc'.
  # OPAMWITHTEST see install option ‘--with-test.
  # OPAMWORKINGDIR see option ‘--working-dir'.
  # OPAMYES see options ‘--yes' and ‘--confirm-level‘. OPAMYES has priority over OPAMNO and is ignored if OPAMCONFIRMLEVEL is set.
  # OPAMVAR_var overrides the contents of the variable var when substituting ‘%{var}%‘ strings in ‘opam‘ files.
  # OPAMVAR_package_var overrides the contents of the variable package:var when substituting ‘%{package:var}%‘ strings in ‘opam‘ files.


  [[ -r $OPAMROOT/opam-init/init.sh ]] && source $OPAMROOT/opam-init/init.sh >/dev/null 2>/dev/null || true

  #opam switch ocsigen && eval $(opam env --switch=ocsigen --set-switch)
}
## }}}  ## [ocaml.opam]
## }}}  ## [ocaml]

## [rust] ## {{{
export RUSTUP_HOME=${RUSTUP_HOME:="$XDG_DATA_HOME/rustup"}
export CARGO_HOME=${CARGO_HOME:="$XDG_DATA_HOME/cargo"}
export CARGO_TARGET_DIR="$CARGO_HOME/target"

[[ -n "${commands[rustup]}" ]] && {
  [[ ! -n "${commands[rustc]}" ]] && {
    #echo "[zshrc] rustc not found, please install it from https://www.rust-lang.org/tools/install"
    echo "[zshrc] rustc not found, using rustup to install `stable`"
    rustup toolchain install stable
    rustup default stable
  }
  _path_prepend "$CARGO_HOME/bin" && rehash
  ## + rustup
  ## + avoid https://github.com/rust-analyzer/rust-analyzer/issues/4172
  ##
  ## NOTE: Has to be defined after PATH update to locate .cargo directory.
  [[ -n "${commands[rustc]}" ]] && export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

  ## configure rust environment
  [[ -s "$CARGO_HOME/env" ]] && source "$CARGO_HOME/env"
  ## - autocomplete
  ## - cargo audit
  ## - cargo clippy
  ## - cargo edit
  ## - cargo fmt
  ## - cargo-nextest
  ## - rust-analyzer

  [[ ! -d "$XDG_CACHE_HOME/zsh/completions" ]] && mkdir -p "$XDG_DATA_HOME/zsh/completions"
  [[ ! -s "$XDG_CACHE_HOME/zsh/completions/_cargo" ]]  && rustup completions zsh cargo  >> "$XDG_CACHE_HOME/zsh/completions/_cargo"
  [[ ! -s "$XDG_CACHE_HOME/zsh/completions/_rustup" ]] && rustup completions zsh rustup >> "$XDG_CACHE_HOME/zsh/completions/_rustup"

  [[ -z "${commands[cargo-audit]}" ]]    && cargo install cargo-audit --features=fix --locked
  [[ -z "${commands[cargo-clippy]}" ]]   && rustup component add clippy
  [[ -z "${commands[cargo-fmt]}" ]]      && rustup component add rustfmt
  [[ -z "${commands[cargo-nextest]}" ]]  && cargo install cargo-nextest
  [[ -z "${commands[cargo-upgrade]}" ]]  && cargo install cargo-edit
  [[ -z "${commands[rust-analyzer]}" ]]  && rustup component add rust-analyzer
  [[ -z "${commands[starship]}" ]]       && cargo install starship --locked
}
## }}}  ## [rustup]
## }}}  ## [rust]

## [starship]
[ -n "${commands[starship]}" ] && eval "$(starship init zsh)"

## [tldr] ## {{{
[[ -n ${commands[tldr]} ]] && {
  tldr-command-line() {
    # if there is no command typed, use the last command
    [[ -z "$BUFFER" ]] && zle up-history

    # if typed command begins with tldr, do nothing
    [[ "$BUFFER" = tldr\ * ]] && return

    # get command and possible subcommand
    # http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion-Flags
    local -a args
    args=(${${(Az)BUFFER}[1]} ${${(Az)BUFFER}[2]})

    BUFFER="tldr ${args[1]}"
  }

  zle -N tldr-command-line
  # Defined shortcut keys: [Esc]tldr
  bindkey "\e"tldr tldr-command-line
}
## }}}  ## [tldr]

## [zoxide] ## {{{
if [[ -n ${commands[zoxide]} ]]; then
  export _ZO_ECHO=1
  export _ZO_RESOLVE_SYMLINKS=1
  eval "$(zoxide init --cmd ${ZOXIDE_CMD_OVERRIDE:-z} --hook pwd zsh)"
else
  echo '[zshrc] zoxide not found, please install it from https://github.com/ajeetdsouza/zoxide'
fi
# }}} *** ZOXIDE Shell integrations
## }}}  ## [zoxide]

## [iterm2_shell_integration]
## https://iterm2.com/documentation-shell-integration.html
## curl -L https://iterm2.com/shell_integration/zsh -o "$XDG_CONFIG_HOME/zsh/iterm2_shell_integration.zsh"
[[ -s "$XDG_CONFIG_HOME/zsh/iterm2_shell_integration.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/iterm2_shell_integration.zsh"

## [my_fpath]
[[ -d "$XDG_DATA_HOME/zsh/functions" ]] && {
  fpath+=("$XDG_DATA_HOME/zsh/functions")
  #_field_append FPATH "$XDG_DATA_HOME/zsh/functions"
  export FPATH="$FPATH:$XDG_DATA_HOME/zsh/functions"
}

## [my_path]
#_field_prepend PATH "$HOME/sbin"
_path_prepend "$HOME/sbin"
#_field_prepend PATH "$HOME/bin"
_path_prepend "$HOME/bin"
#_field_prepend PATH "$HOME/.local/sbin"
_path_prepend "$HOME/.local/sbin"
#_field_prepend PATH "$HOME/.local/bin"
_path_prepend "$HOME/.local/bin"

## [ssh]
#ssh-add --apple-use-keychain ~/.ssh/id_ed25519

## [update-all]
[[ -s "$XDG_CONFIG_HOME/zsh/update-all.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/update-all.zsh"

## [zshrc.local]
[[ -s "$ZDOTDIR/.zshrc.local" ]] && source "$ZDOTDIR/.zshrc.local"

## [zshrc.d]
[[ -d "$ZDOTDIR/.zshrc.d" ]] && {
  for file in "${ZDOTDIR}"/.zshrc.d/*; do
    [[ -r "$file" ]] && source "$file"
  done
}

## [plugins.sheldon]
[[ -n "${commands[sheldon]}" ]] && eval "$(sheldon source)"

## [my_zstyle] ## {{{
## zstyle configuration
## - https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html#The-zsh_002fzutil-Module
## - https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html#The-zsh_002fzstyle-Module
## - https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html#The-zsh_002fzsh-Module
## - https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html#The-zsh_002fzle-Module
## - https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html#The-zsh_002fcompctl-Module
## - https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html#The-zsh_002fcompwid-Module
## - https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html#The-zsh_002fcomplist-Module
## - https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html#The-zsh_002fcompcore-Module
## - https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html#The-zsh_002fcompctl-Module

## Fuzzy matching of completions
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'
## Pretty completions
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' rehash true
## Do menu-driven completion
zstyle ':completion:*' menu select
## Color completion for some things
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
## fzf-tab
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
## }}}  ## [my_zstyle]

## [splash_screen]  ## {{{
if [[ -n "${commands[lolcat]}" ]]; then
  [[ -n "${commands[fastfetch]}" ]] && fastfetch | lolcat
  [[ -n "${commands[colorscript]}" ]] && colorscript random | lolcat
else
  [[ -n "${commands[fastfetch]}" ]] && fastfetch
  [[ -n "${commands[colorscript]}" ]] && colorscript random
fi
## }}}  ## [splash_screen]


## [herd] ## {{{
## Herd injected PHP 8.4 configuration.
export HERD_PHP_84_INI_SCAN_DIR="/Users/s-a-c/Library/Application Support/Herd/config/php/84/"

## Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="/Users/s-a-c/Library/Application Support/Herd/config/php/83/"

## Herd injected PHP 8.2 configuration.
export HERD_PHP_82_INI_SCAN_DIR="/Users/s-a-c/Library/Application Support/Herd/config/php/82/"

## Herd injected PHP binary.
export PATH="/Users/s-a-c/Library/Application Support/Herd/bin/":$PATH

## Herd injected NVM configuration
## [herd.nvm]  ## {{{
export NVM_DIR="/Users/s-a-c/Library/Application Support/Herd/config/nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -n "$NVM_RC_VERSION" ]] && {
  ## Load nvm bash_completion
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
  ## Load nvm zsh_completion
  [[ -s "$NVM_DIR/zsh_completion" ]] && source "$NVM_DIR/zsh_completion"

  function _omz_load_nvm_completion {
    local _nvm_completion
    # Load nvm bash completion
    for _nvm_completion in "$NVM_DIR/bash_completion" "$NVM_DIR/etc/bash_completion.d/nvm"; do
      if [[ -f "$_nvm_completion" ]]; then
        # Load bashcompinit
        autoload -U +X bashcompinit && bashcompinit
        # Bypass compinit call in nvm bash completion script. See:
        # https://github.com/nvm-sh/nvm/blob/4436638/bash_completion#L86-L93
        ZSH_VERSION= source "$_nvm_completion"
        break
      fi
    done
    unfunction _omz_load_nvm_completion
  }

  function _omz_setup_autoload {
    if ! zstyle -t ':omz:plugins:nvm' autoload; then
      unfunction _omz_setup_autoload
      return
    fi

    # Autoload nvm when finding a .nvmrc file in the current directory
    # Adapted from: https://github.com/nvm-sh/nvm#zsh
    function load-nvmrc {
      local nvmrc_path="$(nvm_find_nvmrc)"
      local nvm_silent=""
      zstyle -t ':omz:plugins:nvm' silent-autoload && nvm_silent="--silent"

      if [[ -n "$nvmrc_path" ]]; then
        local nvmrc_node_version=$(nvm version $(command cat "$nvmrc_path" | tr -dc '[:print:]'))

        if [[ "$nvmrc_node_version" = "N/A" ]]; then
          nvm install
        elif [[ "$nvmrc_node_version" != "$(nvm version)" ]]; then
          nvm use $nvm_silent
        fi
      elif [[ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ]] && [[ "$(nvm version)" != "$(nvm version default)" ]]; then
        [[ -z $nvm_silent ]] && echo "Reverting to nvm default version"

        nvm use default $nvm_silent
      fi
    }

    autoload -U add-zsh-hook
    add-zsh-hook chpwd load-nvmrc

    load-nvmrc
    unfunction _omz_setup_autoload
  }

  if zstyle -t ':omz:plugins:nvm' lazy; then
    # Call nvm when first using nvm, node, npm, pnpm, yarn, corepack or other commands in lazy-cmd
    zstyle -a ':omz:plugins:nvm' lazy-cmd nvm_lazy_cmd
    nvm_lazy_cmd=(nvm node npm npx pnpm yarn corepack $nvm_lazy_cmd) # default values
    eval "
      function $nvm_lazy_cmd {
        for func in $nvm_lazy_cmd; do
          if (( \$+functions[\$func] )); then
            unfunction \$func
          fi
        done
        # Load nvm if it exists in \$NVM_DIR
        [[ -f \"\$NVM_DIR/nvm.sh\" ]] && source \"\$NVM_DIR/nvm.sh\"
        _omz_load_nvm_completion
        _omz_setup_autoload
        \"\$0\" \"\$@\"
      }
    "
    unset nvm_lazy_cmd
  else
    source "$NVM_DIR/nvm.sh"
    _omz_load_nvm_completion
    _omz_setup_autoload
  fi
}
## }}}  ## [herd.nvm]

[[ -f "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh" ]] && builtin source "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh"
## }}}  ## [herd]

rehash

## [profiling.end]  ## {{{
[[ "$PROFILE_STARTUP" == true ]] && {
  unset PROFILE_STARTUP
  unsetopt xtrace prompt_subst
  exec 2>&3 3>&-
  zprof
}
## }}}  ## [profiling.end]
