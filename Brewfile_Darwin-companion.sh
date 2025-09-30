#!/usr/bin/env bash
set -euo pipefail

# Bun
export BUN_INSTALL="${BUN_INSTALL:-${XDG_DATA_HOME:-${HOME/.local/share}}/bun}"
[[ ! -d "$BUN_INSTALL" ]] ]]; then
    mkdir -p "$BUN_INSTALL"
    curl -fsSL https://bun.sh/install | bash -s -- --prefix="$BUN_INSTALL"
    export PATH="$BUN_INSTALL/bin:$PATH"
fi

# Python tools via uv/uvx
if ! command -v uvx >/dev/null 2>&1; then
    echo "uv not found; installing with Homebrew..."
    brew install uv
fi

uvx bash-unit || true # if you prefer the PyPI version instead of the brew one, skip because brew provides it
uvx yamlscript || true

# Go tools
if command -v go >/dev/null 2>&1; then
    go install github.com/TheZoraiz/ascii-image-converter@latest
fi

# Rust tools
if command -v cargo >/dev/null 2>&1; then
    cargo install clipse || true
fi

# Manual installs
if [[ ! -d "$HOME/.local/share/taoup" ]]; then
    git clone https://github.com/globalcitizen/taoup "$HOME/.local/share/taoup"
fi

if [[ ! -d "$HOME/.local/share/ble.sh" ]]; then
    git clone https://github.com/akinomyoga/ble.sh "$HOME/.local/share/ble.sh"
    pushd "$HOME/.local/share/ble.sh" >/dev/null
    make install PREFIX="$HOME/.local"
    popd >/dev/null
fi
