#!/bin/bash
# Download self-hosted assets for Digital Bazaar
# - Fonts: Space Grotesk (English), IBM Plex Sans Arabic (Arabic)
# - JavaScript: Mermaid.js (diagrams)
# Usage: ./scripts/download-assets.sh

set -e

FONTS_DIR="assets/fonts"
mkdir -p "$FONTS_DIR"

echo "🔤 Downloading fonts..."

# Space Grotesk from Fontsource CDN (jsDelivr)
echo "  → Space Grotesk (English)..."
curl -sL -k "https://cdn.jsdelivr.net/fontsource/fonts/space-grotesk@latest/latin-400-normal.woff2" -o "$FONTS_DIR/SpaceGrotesk-Regular.woff2"
curl -sL -k "https://cdn.jsdelivr.net/fontsource/fonts/space-grotesk@latest/latin-500-normal.woff2" -o "$FONTS_DIR/SpaceGrotesk-Medium.woff2"
curl -sL -k "https://cdn.jsdelivr.net/fontsource/fonts/space-grotesk@latest/latin-700-normal.woff2" -o "$FONTS_DIR/SpaceGrotesk-Bold.woff2"

# IBM Plex Sans Arabic from Fontsource CDN (jsDelivr)
echo "  → IBM Plex Sans Arabic (Arabic)..."
curl -sL -k "https://cdn.jsdelivr.net/fontsource/fonts/ibm-plex-sans-arabic@latest/arabic-400-normal.woff2" -o "$FONTS_DIR/IBMPlexSansArabic-Regular.woff2"
curl -sL -k "https://cdn.jsdelivr.net/fontsource/fonts/ibm-plex-sans-arabic@latest/arabic-500-normal.woff2" -o "$FONTS_DIR/IBMPlexSansArabic-Medium.woff2"
curl -sL -k "https://cdn.jsdelivr.net/fontsource/fonts/ibm-plex-sans-arabic@latest/arabic-700-normal.woff2" -o "$FONTS_DIR/IBMPlexSansArabic-Bold.woff2"

echo ""
echo "✅ Fonts downloaded:"
ls -lh "$FONTS_DIR"/*.woff2

# Download Mermaid.js for diagrams (pinned version)
MERMAID_VERSION="11.12.2"
JS_DIR="assets/js"
mkdir -p "$JS_DIR"
echo ""
echo "📊 Downloading Mermaid.js v${MERMAID_VERSION}..."
curl -sL -k "https://cdn.jsdelivr.net/npm/mermaid@${MERMAID_VERSION}/dist/mermaid.min.js" -o "$JS_DIR/mermaid-${MERMAID_VERSION}.min.js"
echo "✅ Mermaid.js downloaded:"
ls -lh "$JS_DIR/mermaid-${MERMAID_VERSION}.min.js"

echo ""
echo "🎉 Done! Restart Jekyll to see changes."

