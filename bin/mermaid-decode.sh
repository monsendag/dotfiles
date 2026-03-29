#!/usr/bin/env bash
# Decodes a Kroki URL back to the original diagram source.
#
# Usage:
#   ./scripts/mermaid-decode.sh "https://kroki.no/mermaid/svg/eJy..."

set -euo pipefail

url="${1:?Usage: mermaid-decode.sh <kroki-url>}"

# Extract the encoded part (last path segment)
encoded="${url##*/}"

python3 -c "
import sys, zlib, base64

encoded = '$encoded'
compressed = base64.urlsafe_b64decode(encoded + '==')
print(zlib.decompress(compressed).decode('utf-8'))
"

