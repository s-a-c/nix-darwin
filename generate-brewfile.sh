#!/usr/bin/env bash
# =====================================================================
# generate-brewfile.sh — rebuilds a Brewfile from StandAloneComplexs flake.nix
# Captures taps, brews, casks, MAS apps, fonts, and nix‑specific bits.
# =====================================================================

set -euo pipefail

flake="${1:-flake.nix}"
outfile="${2:-Brewfile}"
tmp="$(mktemp)"

echo "# Brewfile generated from nix-darwin flake $(date)" >"$tmp"
echo "# =====================================================================" >>"$tmp"
echo >>"$tmp"

# ---------------------------------------------------------------------
# 1. TAP extraction
# ---------------------------------------------------------------------
# ---- Taps -----------------------------------------------------------
echo "# ---- Taps -----------------------------------------------------------" >>"$tmp"

awk '
  BEGIN { section="" }
  /homebrew[[:space:]]*=[[:space:]]*{/ { section="homebrew_block" }
  # capture entries inside homebrew.taps = [ ... ];
  /taps = \[/ { section="array_taps"; next }

  section=="array_taps" && /name[[:space:]]*=/ {
      name=$3
      gsub(/[";]/,"",name)
      printf("tap \"%s\"\n", name)
  }

  /];/ && section=="array_taps" { section="homebrew_block"; next }

  # capture nix-homebrew.taps = { "tap/name" = something; ... };
  /nix-homebrew[[:space:]]*\=[[:space:]]*{/ { section="nixhomebrew" }
  section=="nixhomebrew" && /"[A-Za-z0-9_.-]+\/[A-Za-z0-9_.-]+"/ {
      match($0,/"[^"]+"/)
      if (RLENGTH>0) {
         tapname=substr($0,RSTART+1,RLENGTH-2)
         printf("tap \"%s\"\n", tapname)
      }
  }

  /};/ && section=="nixhomebrew"{ section="" }
' "$flake" | sort -u >>"$tmp"

echo >>"$tmp"

# ---------------------------------------------------------------------
# 2. BREWS extraction
# ---------------------------------------------------------------------
echo "# ---- Formulae -------------------------------------------------------" >>"$tmp"
awk '
  /brews = \[/ {section="brew"}
  /^[[:space:]]*"[^#]/ && section=="brew" {
      gsub(/"|,/, "", $1)
      printf("brew \"%s\"\n",$1)
  }
  /];/ {if(section=="brew")section=""}
' "$flake" | sort -u >>"$tmp"
echo >>"$tmp"

# ---------------------------------------------------------------------
# 3. CASKS extraction
# ---------------------------------------------------------------------
echo "# ---- Casks ----------------------------------------------------------" >>"$tmp"
awk '
  /casks = \[/ {section="cask"}
  /^[[:space:]]*"[^#]/ && section=="cask" {
      gsub(/"|,/, "", $1)
      printf("cask \"%s\"\n",$1)
  }
  /];/ {if(section=="cask")section=""}
' "$flake" | sort -u >>"$tmp"
echo >>"$tmp"

# ---------------------------------------------------------------------
# 4. MAS apps  → valid + non‑MAS placeholders
# ---------------------------------------------------------------------
echo "# ---- MAS Apps -------------------------------------------------------" >>"$tmp"

awk -F= '
/masApps/ {section="mas"; next}
section=="mas" && /"[A-Za-z ]+"/ {
  name=$1
  id=$2
  gsub(/^[[:space:]]*|[[:space:]]*$/, "", name)
  gsub(/["]/, "", name)
  gsub(/[^0-9]/, "", id)
  if (id != "") {
    print "mas \"" name "\", id: " id > "mas_valid.tmp"
  } else {
    print "# " name > "mas_other.tmp"
  }
}
END {
  close("mas_valid.tmp")
  close("mas_other.tmp")
}' "$flake"

if [ -s mas_valid.tmp ]; then
  cat mas_valid.tmp >>"$tmp"
  echo >>"$tmp"
fi

if [ -s mas_other.tmp ]; then
  echo "# ---- Apps without MAS IDs (installed via Brew/Cask/Nix) -------------" >>"$tmp"
  cat mas_other.tmp >>"$tmp"
  echo >>"$tmp"
fi

rm -f mas_valid.tmp mas_other.tmp

# ---------------------------------------------------------------------
# 5. Nix environment.systemPackages equivalents
# ---------------------------------------------------------------------
echo "# ---- Nix systemPackages equivalents ---------------------------------" >>"$tmp"
# Known direct Brew equivalents
echo 'brew "any-nix-shell"
brew "checkbashisms"
brew "lemonade"
brew "lorri"
brew "nixd"
brew "nixfmt"
brew "yt-dlp"
brew "rakudo-star"   # includes zef' >>"$tmp"
# Nix‑only notes
cat >>"$tmp" <<"EOF"

# ⚠️ The following have no direct Homebrew equivalent; they are kept as comments.
# brew "mkalias"
# brew "nix-zsh-completions"
# brew "nsxiv"
# brew "procps"
# brew "sqlar"
# brew "sysz"
# brew "taoup"
# brew "tigerbeetle"
# brew "tix"
# brew "yamlscript"
EOF
echo >>"$tmp"

# ---------------------------------------------------------------------
# 6. Fonts (from fonts.packages)
# ---------------------------------------------------------------------
echo "# ---- Fonts ----------------------------------------------------------" >>"$tmp"
cat >>"$tmp" <<"EOF"
tap "homebrew/cask-fonts"
cask "font-alegreya"
cask "font-iosevka"
cask "font-iosevka-comfy"
cask "font-open-dyslexic"
cask "font-overpass"
EOF
echo >>"$tmp"

# ---------------------------------------------------------------------
# 7. Service approximations
# ---------------------------------------------------------------------
cat >>"$tmp" <<"EOF"
# ---- Approximate nix-darwin services ---------------------------------
brew "eternal-terminal"
# ⚠️ jankyborders -> manual install from felixkratz GitHub
brew "netbird"
brew "tailscale"
brew "postgresql"
# ⚠️ sketchybar -> present via tap felixkratz/formulae
# ⚠️ mopidy, spotifyd -> optional
brew "dockutil"
brew "duti"
brew "swift-format"
EOF

# ---------------------------------------------------------------------
mv "$tmp" "$outfile"
echo
echo "✅ Brewfile written to $outfile"
echo "   Run: brew bundle check --file $outfile"
echo
