#!/bin/bash
# Download self-hosted fonts for Digital Bazaar
# Usage: ./scripts/download-fonts.sh

set -e

FONTS_DIR="assets/fonts"
mkdir -p "$FONTS_DIR"

echo "🔤 Downloading fonts..."

# Space Grotesk from Fontsource CDN (jsDelivr)
echo "  → Space Grotesk (English)..."
curl -sL -k "https://cdn.jsdelivr.net/fontsource/fonts/space-grotesk@latest/latin-400-normal.woff2" -o "$FONTS_DIR/SpaceGrotesk-Regular.woff2"
curl -sL -k "https://cdn.jsdelivr.net/fontsource/fonts/space-grotesk@latest/latin-500-normal.woff2" -o "$FONTS_DIR/SpaceGrotesk-Medium.woff2"
curl -sL -k "https://cdn.jsdelivr.net/fontsource/fonts/space-grotesk@latest/latin-700-normal.woff2" -o "$FONTS_DIR/SpaceGrotesk-Bold.woff2"

# Tajawal from Fontsource CDN (jsDelivr)
echo "  → Tajawal (Arabic)..."
curl -sL -k "https://cdn.jsdelivr.net/fontsource/fonts/tajawal@latest/arabic-400-normal.woff2" -o "$FONTS_DIR/Tajawal-Regular.woff2"
curl -sL -k "https://cdn.jsdelivr.net/fontsource/fonts/tajawal@latest/arabic-500-normal.woff2" -o "$FONTS_DIR/Tajawal-Medium.woff2"
curl -sL -k "https://cdn.jsdelivr.net/fontsource/fonts/tajawal@latest/arabic-700-normal.woff2" -o "$FONTS_DIR/Tajawal-Bold.woff2"
curl -sL -k "https://cdn.jsdelivr.net/fontsource/fonts/tajawal@latest/arabic-800-normal.woff2" -o "$FONTS_DIR/Tajawal-ExtraBold.woff2"

echo ""
echo "✅ Fonts downloaded:"
ls -lh "$FONTS_DIR"/*.woff2

echo ""
echo "🎉 Done! Restart Jekyll to see changes."

