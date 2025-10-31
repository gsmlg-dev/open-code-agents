#!/bin/bash
set -e

VERSION="$1"
if [ -z "$VERSION" ]; then
    VERSION="$(date +%Y%m%d)-$(git rev-parse --short HEAD 2>/dev/null || echo 'dev')"
fi

EPUB_NAME="open-code-agents-${VERSION}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
BUILD_DIR="$PROJECT_ROOT/build"

echo "🚀 Building Open Code Agents EPUB Documentation"
echo "Version: $VERSION"
echo "Project Root: $PROJECT_ROOT"

# Clean previous builds
rm -rf "$BUILD_DIR"
rm -f "$PROJECT_ROOT/"*.epub "$PROJECT_ROOT/"*.pdf
mkdir -p "$BUILD_DIR"

# Generate content
echo "📝 Generating EPUB content..."
"$SCRIPT_DIR/generate-epub-content.sh" "$VERSION"

# Create cover image
echo "🎨 Creating cover image..."
"$SCRIPT_DIR/create-cover.sh" "$VERSION"

# Check if Pandoc is available
if ! command -v pandoc &> /dev/null; then
    echo "❌ Pandoc not found. Please install Pandoc:"
    echo "  macOS: brew install pandoc"
    echo "  Ubuntu: sudo apt install pandoc"
    echo "  Or download from: https://pandoc.org/installing.html"
    exit 1
fi

# Get Pandoc version
PANDOC_VERSION=$(pandoc --version | head -n1 | cut -d' ' -f2)
echo "📚 Using Pandoc v$PANDOC_VERSION"

# Build EPUB with Pandoc
echo "📚 Building EPUB..."
cd "$PROJECT_ROOT"

pandoc \
    --from=markdown \
    --to=epub3 \
    --metadata-file=epub/metadata.yaml \
    --css=epub/style.css \
    --toc \
    --toc-depth=3 \
    --number-sections \
    --standalone \
    -o "${EPUB_NAME}.epub" \
    epub/*.md

# Create stable name
cp "${EPUB_NAME}.epub" "open-code-agents-latest.epub"

# Optional: Also build PDF if LaTeX is available
if command -v xelatex &> /dev/null; then
    echo "📄 Building PDF version..."
    pandoc \
        --from=markdown \
        --to=pdf \
        --metadata-file=epub/metadata.yaml \
        --pdf-engine=xelatex \
        --toc \
        --toc-depth=3 \
        --number-sections \
        --standalone \
        -o "${EPUB_NAME}.pdf" \
        epub/*.md
    
    if [ $? -eq 0 ]; then
        echo "✅ PDF built successfully: ${EPUB_NAME}.pdf"
    else
        echo "⚠️  PDF build failed, but EPUB was successful"
    fi
fi

echo "✅ EPUB Build Complete!"
echo "📄 Generated files:"
ls -lh "${EPUB_NAME}.epub" "open-code-agents-latest.epub" "${EPUB_NAME}.pdf" 2>/dev/null || true

echo "🔗 Version: $VERSION"
echo "📖 EPUB: ${EPUB_NAME}.epub"
echo "📖 Latest: open-code-agents-latest.epub"
if [ -f "${EPUB_NAME}.pdf" ]; then
    echo "📄 PDF: ${EPUB_NAME}.pdf"
fi
