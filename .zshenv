## [xdg] # {{{
## (https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
export XDG_BIN_HOME=${XDG_BIN_HOME:="$HOME/.local/bin"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_STATE_HOME=${XDG_STATE_HOME:="$HOME/.local/state"}
if [[ "$(uname)" == "Darwin" ]]; then
  ## Do something under Mac OS X platform
  export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:="$HOME/Library/Caches/TemporaryItems"}
  :
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
  ## Do something under GNU/Linux platform
  :
elif [[ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]]; then
  ## Do something under 32 bits Windows NT platform
  :
elif [[ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]]; then
  ## Do something under 64 bits Windows NT platform
  :
fi
## }}} [xdg]

export SKIP_GLOBAL_COMPINIT=1

export ZDOTDIR="$HOME"
export ZDOTDIR=${ZDOTDIR:="$XDG_CONFIG_HOME/zsh"}
export ZSH_CACHE_DIR=${ZSH_CACHE_DIR:="$XDG_CACHE_HOME/zsh"}

export SHELL_SESSIONS_DISABLE=1

export HISTDUP=erase
export HISTFILE="$ZDOTDIR/.zsh_history"         ## History filepath
export HISTSIZE=1000000                         ## Maximum events for internal history
export HISTTIMEFORMAT='%F %T %z %a %V '
export SAVEHIST=1200000                         ## Maximum events in history file

export DISPLAY=:0.0
export EDITOR=$(which nvim)
export GH_TOKEN='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'
export LANG='en_GB.UTF-8'
export LC_ALL='en_GB.UTF-8'
export VISUAL=$(which nvim)

## Get color support for 'less'
#export LESS="--RAW-CONTROL-CHARS"
export LESS=' --HILITE-UNREAD --LONG-PROMPT --RAW-CONTROL-CHARS --no-histdups --ignore-case --incsearch --no-init --line-numbers --mouse --quit-if-one-screen --squeeze-blank-lines --status-column --tabs=4 --use-color --window=-4 '

export MY_SESSION_BUS_SOCKET=/tmp/dbus/$USER.session.usock
export DBUS_SESSION_BUS_ADDRESS=unix:path=$MY_SESSION_BUS_SOCKET

export ANTHROPIC_API_KEY='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'
export GOOGLE_AI_API_KRY='AIzaSyCnyklMg7K3KUVBz0_qWtKY7txfQ0LvI20'
export OPENAI_API_KEY='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'
. "/Users/s-a-c/.local/share/cargo/env"
