#!/usr/bin/env bash
# Measures npm tarball size for the React Native SDK and optionally compares
# against the last published version from the npm registry.
#
# Usage:
#   ./scripts/measure_binary_sizes.sh                     # measure only
#   ./scripts/measure_binary_sizes.sh --compare           # measure + compare vs published
#   ./scripts/measure_binary_sizes.sh --output out.json   # also write JSON to file
#   ./scripts/measure_binary_sizes.sh --compare --output out.json
#
# Run this after npm publish (or npm pack locally to test).
# Requires: node, npm, python3, curl

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

COMPARE=false
OUTPUT_FILE=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --compare) COMPARE=true; shift ;;
    --output)  OUTPUT_FILE="$2"; shift 2 ;;
    *) echo "Unknown argument: $1" >&2; exit 1 ;;
  esac
done

# ── helpers ───────────────────────────────────────────────────────────────────

warn() { echo "⚠️  $*" >&2; }

file_bytes() {
  [[ -f "$1" ]] && wc -c < "$1" | tr -d ' ' || echo "null"
}

format_bytes() {
  local bytes="$1"
  [[ "$bytes" == "null" ]] && { echo "not found"; return; }
  local kb=$(( bytes / 1024 ))
  if (( kb >= 1024 )); then
    printf "%.2f MB" "$(echo "scale=2; $kb / 1024" | bc)"
  else
    printf "%d KB" "$kb"
  fi
}

print_row() {
  local label="$1" cur="$2" pub="${3:-}"
  local cur_str delta_str=""
  cur_str="$(format_bytes "$cur")"
  if [[ -n "$pub" ]]; then
    local pub_str
    pub_str="$(format_bytes "$pub")"
    if [[ "$cur" != "null" && "$pub" != "null" ]]; then
      delta_str=$(python3 -c "
c, p = $cur, $pub
diff = c - p
sign = '+' if diff >= 0 else ''
pct = (diff / p * 100) if p else 0
if abs(diff) >= 1048576:
    print(f'{sign}{diff/1048576:.2f} MB ({sign}{pct:.1f}%)')
elif abs(diff) >= 1024:
    print(f'{sign}{diff//1024} KB ({sign}{pct:.1f}%)')
else:
    print(f'{sign}{diff} B ({sign}{pct:.1f}%)')
")
    fi
    printf "  %-40s  %-14s  %-14s  %s\n" "$label" "$cur_str" "$pub_str" "$delta_str"
  else
    printf "  %-40s  %s\n" "$label" "$cur_str"
  fi
}

# ── version + package name ────────────────────────────────────────────────────

VERSION=$(python3 -c "import json; print(json.load(open('$REPO_ROOT/package.json'))['version'])" 2>/dev/null || echo "unknown")
PACKAGE_NAME=$(python3 -c "import json; print(json.load(open('$REPO_ROOT/package.json'))['name'])" 2>/dev/null || echo "@usercentrics/react-native-sdk")
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# ── build tarball ─────────────────────────────────────────────────────────────

cd "$REPO_ROOT"

# Remove any stale tarball from a previous run
rm -f ./*.tgz

echo "Packing npm tarball..." >&2
npm pack --quiet 2>/dev/null

TARBALL=$(ls "$REPO_ROOT"/*.tgz 2>/dev/null | head -1 || true)
[[ -n "$TARBALL" ]] || { warn "npm pack did not produce a .tgz file"; exit 1; }

COMPRESSED_BYTES=$(file_bytes "$TARBALL")
UNCOMPRESSED_BYTES=$(gunzip -c "$TARBALL" | wc -c | tr -d ' ')

# ── fetch published artifact sizes ────────────────────────────────────────────

PUB_VERSION=""
PUB_COMPRESSED="null"
PUB_UNCOMPRESSED="null"

if [[ "$COMPARE" == true ]]; then
  # URL-encode the scoped package name (@scope/pkg → @scope%2Fpkg)
  ENCODED_NAME=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$PACKAGE_NAME', safe='@'))")
  echo "Fetching published sizes from npm registry for ${PACKAGE_NAME}..." >&2

  REGISTRY_DATA=$(curl -sf "https://registry.npmjs.org/${ENCODED_NAME}" 2>/dev/null || true)
  if [[ -n "$REGISTRY_DATA" ]]; then
    # latest tag is the previously published version (we just published a new one,
    # but the registry may already point to it — find the version before ours)
    PUB_VERSION=$(echo "$REGISTRY_DATA" | python3 -c "
import sys, json
d = json.load(sys.stdin)
cur = '$VERSION'
versions = sorted(d.get('versions', {}).keys(), key=lambda v: [int(x) for x in v.split('.')[:3]])
# Return the version immediately preceding the current one, or current if only one
prev = None
for v in versions:
    if v == cur:
        break
    prev = v
print(prev or cur)
" 2>/dev/null || true)

    if [[ -n "$PUB_VERSION" ]]; then
      PUB_COMPRESSED=$(echo "$REGISTRY_DATA" | python3 -c "
import sys, json
d = json.load(sys.stdin)
dist = d.get('versions', {}).get('$PUB_VERSION', {}).get('dist', {})
print(dist.get('size', 'null'))
" 2>/dev/null || echo "null")
      PUB_UNCOMPRESSED=$(echo "$REGISTRY_DATA" | python3 -c "
import sys, json
d = json.load(sys.stdin)
dist = d.get('versions', {}).get('$PUB_VERSION', {}).get('dist', {})
print(dist.get('unpackedSize', 'null'))
" 2>/dev/null || echo "null")
    else
      warn "Could not determine previous published version — skipping comparison"
      COMPARE=false
    fi
  else
    warn "Could not fetch npm registry data — skipping comparison"
    COMPARE=false
  fi
fi

# ── print summary ─────────────────────────────────────────────────────────────

echo ""
if [[ "$COMPARE" == true ]]; then
  echo "Binary Sizes — v${VERSION} vs published v${PUB_VERSION} — ${TIMESTAMP}"
  echo ""
  printf "  %-40s  %-14s  %-14s  %s\n" "" "current" "published" "delta"
  printf "  %-40s  %-14s  %-14s  %s\n" "────────────────────────────────────────" "──────────────" "──────────────" "──────────────────"
else
  echo "Binary Sizes — v${VERSION} — ${TIMESTAMP}"
  echo ""
fi

echo "npm (@usercentrics/react-native-sdk)"
print_row "compressed   (.tgz)"   "$COMPRESSED_BYTES"   ${COMPARE:+"$PUB_COMPRESSED"}
print_row "uncompressed (tar)"    "$UNCOMPRESSED_BYTES" ${COMPARE:+"$PUB_UNCOMPRESSED"}
echo ""

# ── json output ───────────────────────────────────────────────────────────────

JSON=$(python3 - <<PYEOF
import json

def v(b):
    s = str(b).strip()
    return None if s == "null" else int(s)

def entry(cur, pub=None):
    d = {"bytes": v(cur)}
    if pub is not None:
        d["published_bytes"] = v(pub)
        if d["bytes"] is not None and d["published_bytes"] is not None:
            d["delta_bytes"] = d["bytes"] - d["published_bytes"]
    return d

compare = "$COMPARE" == "true"

data = {
    "version": "$VERSION",
    "timestamp": "$TIMESTAMP",
    "published_version": "$PUB_VERSION" if compare else None,
    "npm": {
        "compressed":   entry("$COMPRESSED_BYTES",   "$PUB_COMPRESSED"   if compare else None),
        "uncompressed": entry("$UNCOMPRESSED_BYTES", "$PUB_UNCOMPRESSED" if compare else None),
    },
}

print(json.dumps(data, indent=2))
PYEOF
)

if [[ -n "$OUTPUT_FILE" ]]; then
  echo "$JSON" > "$OUTPUT_FILE"
  echo "JSON written to: $OUTPUT_FILE" >&2
else
  echo "$JSON"
fi
