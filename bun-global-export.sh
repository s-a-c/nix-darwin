#!/usr/bin/env bash
# =====================================================================
# bun-global-export.sh
# Capture top‑level global Bun packages and create a reinstall script
# Works both when --json is unavailable and when output is colored.
# =====================================================================

set -euo pipefail

outfile="${1:-bun-reinstall-global.sh}"
tmp="$(mktemp)"

echo "📦 Gathering global Bun packages..."

# Get raw text (disable colour if Bun respects NO_COLOR)
NO_COLOR=1 bun pm ls --global --all >"$tmp.raw" || true

# Strip ANSI escape codes, tree glyphs, version numbers, paths
# and keep only plausible package names.
sed -E 's/\x1B\[[0-9;]*[A-Za-z]//g' "$tmp.raw" |            # remove colour
  grep -E '^[^ ├└│]' |                                      # top‑level only
  sed -E 's/@[0-9].*$//' |                                  # drop versions
  sed -E 's/^[[:space:]]+//' | sed -E 's/[[:space:]]+$//' | # trim
  grep -v '^$' | sort -u >"$tmp"

if [[ ! -s $tmp ]]; then
  echo "❌  No global Bun packages detected." >&2
  rm -f "$tmp" "$tmp.raw"
  exit 1
fi

count=$(wc -l <"$tmp" | awk '{print $1}')

cat >"$outfile" <<EOF
#!/usr/bin/env bash
# Reinstall all global Bun packages
# (Generated $(date))
bun add --global $(tr '\n' ' ' <"$tmp")
EOF

chmod +x "$outfile"
rm -f "$tmp" "$tmp.raw"

echo "✅  Wrote $count package(s) to $outfile"
echo "👉  Run ./$outfile to reinstall on another system."
