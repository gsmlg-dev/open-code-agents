# EPUB Generation and Publishing

This document explains how to generate and publish EPUB versions of the Open Code Agents documentation.

## Overview

The Open Code Agents project includes automated EPUB generation using Pandoc and GitHub Actions for continuous publishing.

## Quick Start

### Local EPUB Generation

Generate EPUB documentation locally:

```bash
# Build EPUB with version
./scripts/build-epub.sh [version]

# Build with auto-generated version
./scripts/build-epub.sh

# Example with specific version
./scripts/build-epub.sh "v1.0.0"
```

### Prerequisites

- **Pandoc** (v3.5+ recommended)
- **ImageMagick** (for cover image conversion)
- **Bash** shell

#### Install Dependencies

```bash
# macOS
brew install pandoc imagemagick librsvg

# Ubuntu/Debian
sudo apt update
sudo apt install pandoc librsvg2-bin imagemagick

# Other platforms
# Download from https://pandoc.org/installing.html
```

## Generated Files

The build process creates:

- `open-code-agents-{version}.epub` - Versioned EPUB file
- `open-code-agents-latest.epub` - Always latest version
- `open-code-agents-{version}.pdf` - PDF version (if LaTeX available)

## Automated Publishing

### GitHub Actions Workflow

The project includes `.github/workflows/build-and-publish.yml` that automatically:

1. **Triggers on:**
   - Push to `main`/`master` branches
   - Tag pushes (`v*`)
   - Pull requests
   - Manual workflow dispatch

2. **Build Process:**
   - Sets up Pandoc environment
   - Generates EPUB content
   - Builds EPUB with metadata and styling
   - Creates cover image automatically
   - Validates output

3. **Publishing:**
   - Creates GitHub Release for tags
   - Uploads EPUB and PDF files
   - Updates GitHub Pages with latest version
   - Cross-platform builds (macOS, Windows, Linux)

### Release Types

- **Tagged Releases:** Full releases with version numbers
- **Main Branch:** Development builds with date versions
- **Pull Requests:** Preview builds for testing

## EPUB Structure

### Content Organization

```
epub/
├── metadata.yaml          # EPUB metadata and title info
├── style.css             # Custom styling for better readability
├── cover.png             # Auto-generated cover image
├── cover.svg             # SVG source for cover
└── *.md                  # Chapter files (01-21)
```

### Chapter Structure

The EPUB includes 21 chapters organized into 5 parts:

1. **Introduction** (Chapters 1-4)
   - Introduction to Open Code Agents
   - Quick Start Guide
   - System Architecture
   - Installation and Setup

2. **The Agents** (Chapters 5-12)
   - Individual agent deep-dives
   - Capabilities and use cases
   - Best practices for each agent

3. **Workflows and Commands** (Chapters 13-15)
   - Workflow orchestration
   - Command reference
   - Custom command creation

4. **Advanced Topics** (Chapters 16-18)
   - Integration strategies
   - Performance optimization
   - Security considerations

5. **Reference** (Chapters 19-21)
   - Quick reference guide
   - Best practices summary
   - Troubleshooting guide

### Metadata

The EPUB includes comprehensive metadata:

```yaml
---
title: "Open Code Agents: Complete Guide to AI-Powered Development Workflows"
author: "Open Code Agents Project"
language: en-US
rights: "MIT License"
publisher: "Open Code Agents"
description: "Comprehensive guide to using specialized AI agents for automated software development workflows"
tags: ["AI", "Development", "Automation", "CLI", "Workflows"]
published: 2025-01-31T12:00:00Z
version: "2025.01.01"
identifier: "open-code-agents-2025.01.01"
---
```

## Styling

### Custom CSS

The EPUB includes custom styling for:

- **Professional Typography**: System fonts with fallbacks
- **Responsive Design**: Optimized for various screen sizes
- **Code Highlighting**: Syntax-colored code blocks
- **Agent-Specific Styles**: Special styling for different content types
- **Navigation**: Clear table of contents and headers
- **Readability**: Optimized line height and contrast

### Cover Design

Auto-generated cover includes:

- **Title and Subtitle**: Clear hierarchy
- **Version Information**: Dynamic version display
- **Visual Elements**: Decorative circles and gradients
- **Professional Layout**: Clean, modern design
- **Multiple Formats**: SVG source with PNG conversion

## Development Workflow

### Content Updates

1. **Update Markdown Files**: Edit content in `epub/` directory
2. **Regenerate Content**: Run `scripts/generate-epub-content.sh`
3. **Build EPUB**: Run `scripts/build-epub.sh`
4. **Test Locally**: Verify EPUB with e-reader software
5. **Commit Changes**: Version control for tracking

### Version Management

- **Semantic Versioning**: Use `vX.Y.Z` format for releases
- **Date Versions**: Auto-generated for development builds
- **Git Integration**: Automatic version from git tags/commits

### Quality Assurance

- **EPUB Validation**: Check structure and compliance
- **Content Review**: Verify all chapters included
- **Link Testing**: Ensure internal links work
- **Format Testing**: Test on multiple e-readers

## Troubleshooting

### Common Issues

**Pandoc Not Found**
```bash
# Install Pandoc
brew install pandoc  # macOS
sudo apt install pandoc  # Ubuntu
```

**Cover Generation Fails**
```bash
# Install ImageMagick
brew install imagemagick  # macOS
sudo apt install imagemagick  # Ubuntu
```

**EPUB Validation Errors**
```bash
# Check EPUB structure
unzip -l open-code-agents-*.epub

# Validate with epubcheck (if available)
epubcheck open-code-agents-*.epub
```

### Build Failures

1. **Check Dependencies**: Ensure Pandoc and ImageMagick installed
2. **Verify Content**: Check all markdown files are present
3. **Review Logs**: Check build script output for errors
4. **Clean Build**: Remove old files before rebuilding

## Advanced Usage

### Custom Styling

Edit `epub/style.css` to customize:

- **Color Scheme**: Modify theme colors
- **Typography**: Adjust fonts and spacing
- **Layout**: Change page structure
- **Agent Styles**: Add custom agent-specific styling

### Metadata Customization

Edit `epub/metadata.yaml` to modify:

- **Title and Author**: Update project information
- **Subject Tags**: Add relevant categories
- **Publication Info**: Modify publisher and rights
- **Identifier**: Change unique identifier

### Content Addition

Add new chapters by:

1. **Create Markdown File**: Add `XX-chapter-title.md` to `epub/`
2. **Update Content Script**: Add to chapter list in generation script
3. **Regenerate**: Run content generation and build
4. **Update TOC**: Modify table of contents if needed

## Automation Features

### GitHub Pages Integration

- **Latest Version**: Automatically updates `open-code-agents-latest.epub`
- **Download Page**: Direct download from GitHub Pages
- **Version History**: Access to all release versions

### Release Automation

- **Semantic Releases**: Automatic version detection from tags
- **Changelog Generation**: Git-based change history
- **Asset Management**: Multiple file format uploads
- **Cross-Platform**: Build verification on multiple OS

### CI/CD Pipeline

- **Pull Request Testing**: Preview builds for PR testing
- **Branch Protection**: Automated testing before merge
- **Release Promotion**: Staged releases to production
- **Artifact Retention**: Configurable build artifact storage

## Performance Optimization

### Build Performance

- **Parallel Processing**: Multi-threaded EPUB generation
- **Caching**: Dependency and content caching
- **Incremental Builds**: Only rebuild changed content
- **Resource Optimization**: Compressed images and assets

### File Size Optimization

- **Image Compression**: Optimized cover images
- **Content Minification**: Efficient CSS and markup
- **Font Optimization**: Subset fonts for smaller size
- **Structure Optimization**: Efficient EPUB internal structure

## Integration Options

### External Tools

- **Calibre Integration**: Automatic library import
- **Kindle Direct**: Send to Kindle devices
- **Distribution Platforms**: Upload to major eBook stores
- **Reading Apps**: Integration with popular e-readers

### API Integration

- **Webhook Support**: Automated build notifications
- **REST API**: Programmatic EPUB generation
- **GraphQL Support**: Modern API interface
- **Authentication**: Secure build and release access

## Contributing

### Content Contributions

1. **Fork Repository**: Create your own copy
2. **Content Branch**: Create branch for changes
3. **Edit Content**: Update or add chapters
4. **Test Build**: Verify EPUB generation works
5. **Submit PR**: Create pull request for review

### Build System Improvements

- **Script Enhancement**: Improve build automation
- **Workflow Updates**: Optimize GitHub Actions
- **Tool Updates**: Update Pandoc and dependencies
- **Documentation**: Keep this guide current

---

For more information, see the main project README or open an issue on GitHub.