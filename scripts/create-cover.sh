#!/bin/bash
set -e

# Create a simple SVG cover image and convert to PNG
# Usage: ./scripts/create-cover.sh [version]

VERSION="$1"
if [ -z "$VERSION" ]; then
    VERSION="$(date +%Y%m%d)-dev"
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
COVER_SVG="$PROJECT_ROOT/epub/cover.svg"
COVER_PNG="$PROJECT_ROOT/epub/cover.png"

echo "🎨 Creating cover image for version $VERSION"

# Create SVG cover
cat > "$COVER_SVG" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<svg width="1200" height="1600" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#3498db;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#2c3e50;stop-opacity:1" />
    </linearGradient>
  </defs>
  
  <!-- Background -->
  <rect width="1200" height="1600" fill="url(#bg)"/>
  
  <!-- White content area -->
  <rect x="100" y="100" width="1000" height="1400" fill="white" rx="20"/>
  
  <!-- Title -->
  <text x="600" y="400" font-family="Arial, sans-serif" font-size="72" font-weight="bold" text-anchor="middle" fill="#2c3e50">
    Open Code Agents
  </text>
  
  <!-- Subtitle -->
  <text x="600" y="500" font-family="Arial, sans-serif" font-size="36" text-anchor="middle" fill="#34495e">
    Complete Guide to AI-Powered
  </text>
  <text x="600" y="550" font-family="Arial, sans-serif" font-size="36" text-anchor="middle" fill="#34495e">
    Development Workflows
  </text>
  
  <!-- Version -->
  <text x="600" y="700" font-family="Arial, sans-serif" font-size="24" text-anchor="middle" fill="#7f8c8d">
    Version $VERSION
  </text>
  
  <!-- Decorative elements -->
  <circle cx="600" cy="900" r="80" fill="#3498db" opacity="0.2"/>
  <circle cx="500" cy="950" r="60" fill="#e74c3c" opacity="0.2"/>
  <circle cx="700" cy="950" r="60" fill="#2ecc71" opacity="0.2"/>
  
  <!-- Bottom text -->
  <text x="600" y="1300" font-family="Arial, sans-serif" font-size="28" text-anchor="middle" fill="#34495e">
    Open Source AI Development Tools
  </text>
  
  <!-- Date -->
  <text x="600" y="1400" font-family="Arial, sans-serif" font-size="20" text-anchor="middle" fill="#95a5a6">
    $(date +%Y)
  </text>
</svg>
EOF

# Convert SVG to PNG using available tools
if command -v rsvg-convert &> /dev/null; then
    echo "Converting SVG to PNG with rsvg-convert..."
    rsvg-convert -w 1200 -h 1600 "$COVER_SVG" "$COVER_PNG"
elif command -v convert &> /dev/null; then
    echo "Converting SVG to PNG with ImageMagick..."
    convert -background none -size 1200x1600 "$COVER_SVG" "$COVER_PNG"
elif command -v inkscape &> /dev/null; then
    echo "Converting SVG to PNG with Inkscape..."
    inkscape --export-png="$COVER_PNG" --export-width=1200 --export-height=1600 "$COVER_SVG"
else
    echo "⚠️  Warning: Could not convert SVG to PNG. SVG file created at $COVER_SVG"
    echo "Install rsvg-convert, ImageMagick, or Inkscape for PNG conversion"
    # Create a simple placeholder PNG using base64 if needed
    echo "Creating minimal placeholder PNG..."
    echo "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==" | base64 -d > "$COVER_PNG"
fi

echo "✅ Cover created: $COVER_PNG"