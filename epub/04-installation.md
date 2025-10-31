# Chapter 4: Installation and Setup

This chapter provides comprehensive guidance for installing and configuring Open Code Agents across different environments and use cases.

## System Requirements

### Minimum Requirements

- **Operating System**: Linux, macOS, or Windows (with WSL2)
- **Go Version**: 1.21 or later (for building from source)
- **Memory**: 512MB RAM minimum, 2GB recommended
- **Storage**: 100MB free disk space
- **Network**: Internet connection for initial setup

### Recommended Requirements

- **Operating System**: Linux (Ubuntu 20.04+) or macOS (12.0+)
- **Go Version**: 1.22 or later
- **Memory**: 4GB RAM or more
- **Storage**: 500MB free disk space
- **Network**: Stable internet connection

### Supported Platforms

| Platform | Architecture | Status | Notes |
|----------|-------------|--------|-------|
| Linux | x86_64 | ✅ Fully Supported | Ubuntu, CentOS, Debian |
| Linux | ARM64 | ✅ Fully Supported | Raspberry Pi, ARM servers |
| macOS | x86_64 | ✅ Fully Supported | Intel Macs |
| macOS | ARM64 | ✅ Fully Supported | Apple Silicon |
| Windows | x86_64 | ⚠️ WSL2 Only | Use Windows Subsystem for Linux |

## Installation Methods

### Method 1: Build from Source (Recommended for Developers)

#### Prerequisites

Install Go 1.21+:
```bash
# On Ubuntu/Debian
sudo apt update
sudo apt install golang-go

# On macOS
brew install go

# On other systems
# Download from https://golang.org/dl/
```

#### Build Process

```bash
# Clone the repository
git clone https://github.com/gsmlg-dev/open-code-agents.git
cd open-code-agents

# Verify Go installation
go version

# Build the CLI tool
go build -o opencode-setup ./cmd/opencode-setup

# Test the installation
./opencode-setup --version
./opencode-setup --help
```

#### Development Build

For development with debug information:
```bash
# Build with debug symbols
go build -gcflags="all=-N -l" -o opencode-setup-debug ./cmd/opencode-setup

# Build race detector version
go build -race -o opencode-setup-race ./cmd/opencode-setup
```

### Method 2: Download Pre-built Binaries

#### Automated Installation Script

```bash
# Download and run installer
curl -fsSL https://raw.githubusercontent.com/gsmlg-dev/open-code-agents/main/setup-to-user.sh | bash

# Or download manually
curl -L https://github.com/gsmlg-dev/open-code-agents/releases/latest/download/opencode-setup-$(uname -s)-$(uname -m).tar.gz | tar xz
chmod +x opencode-setup-$(uname -s)-$(uname -m)
```

#### Manual Download

Visit the [Releases Page](https://github.com/gsmlg-dev/open-code-agents/releases) and download the appropriate binary:

```bash
# Example for Linux x86_64
wget https://github.com/gsmlg-dev/open-code-agents/releases/download/v1.0.0/opencode-setup-linux-amd64.tar.gz
tar xzf opencode-setup-linux-amd64.tar.gz
chmod +x opencode-setup-linux-amd64
sudo mv opencode-setup-linux-amd64 /usr/local/bin/opencode-setup
```

### Method 3: Package Manager Installation

#### Homebrew (macOS)

```bash
# Add tap (if not already added)
brew tap gsmlg-dev/open-code-agents

# Install
brew install open-code-agents

# Verify
opencode-setup --version
```

#### APT (Ubuntu/Debian)

```bash
# Add repository
echo "deb https://packages.gsmlg.dev/ubuntu/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gsmlg-dev.list
curl -fsSL https://packages.gsmlg.dev/gsmlg-dev.gpg | sudo apt-key add -

# Install
sudo apt update
sudo apt install open-code-agents
```

## Configuration Setup

### Initial Configuration

Run the interactive setup:
```bash
opencode-setup init
```

This will guide you through:
- Setting up default preferences
- Configuring AI model access
- Creating workspace directories
- Setting up integrations

### Manual Configuration

Create configuration directory:
```bash
mkdir -p ~/.config/opencode
```

Create basic configuration file:
```json
{
  "version": "1.0.0",
  "settings": {
    "log_level": "info",
    "default_agent": "implementer",
    "auto_save": true,
    "show_hints": true
  },
  "agents": {
    "default_config": {
      "model": "gpt-4",
      "temperature": 0.7,
      "max_tokens": 4000
    }
  },
  "workflows": {
    "new_feature": {
      "agents": ["researcher", "architect", "implementer", "tester", "reviewer"],
      "auto_commit": false
    }
  }
}
```

### Environment Variables

Set up environment variables in your shell profile (`~/.bashrc`, `~/.zshrc`, etc.):

```bash
# Open Code Agents Configuration
export OPENCODE_CONFIG_DIR="$HOME/.config/opencode"
export OPENCODE_LOG_LEVEL="info"
export OPENCODE_DEFAULT_AGENT="implementer"

# AI Model Configuration (if using custom models)
export OPENCODE_API_KEY="your-api-key-here"
export OPENCODE_MODEL_ENDPOINT="https://api.example.com/v1"

# Development Configuration (optional)
export OPENCODE_DEV_MODE="true"
export OPENCODE_DEBUG="false"
```

## Project Setup

### Initializing a New Project

```bash
# Create new project directory
mkdir my-project
cd my-project

# Initialize with Open Code Agents
opencode-setup init --project

# This creates:
# .opencode/
# ├── config.json
# ├── agents/
# └── workflows/
```

### Project Configuration

Create `.opencode/config.json`:
```json
{
  "project": {
    "name": "My Project",
    "type": "web_application",
    "tech_stack": ["node.js", "react", "postgresql"],
    "version": "1.0.0"
  },
  "agents": {
    "implementer": {
      "language": "javascript",
      "framework": "react",
      "style_guide": "airbnb"
    },
    "tester": {
      "framework": "jest",
      "coverage_threshold": 80,
      "test_types": ["unit", "integration", "e2e"]
    },
    "reviewer": {
      "focus_areas": ["security", "performance", "maintainability"],
      "strict_mode": true
    }
  },
  "workflows": {
    "feature": {
      "pre_checks": ["lint", "type_check"],
      "post_checks": ["test", "build"],
      "auto_commit": true
    }
  }
}
```

## Integration Setup

### Git Integration

Configure Git hooks:
```bash
# Install pre-commit hook
opencode-setup install git-hook pre-commit

# Install commit-msg hook
opencode-setup install git-hook commit-msg
```

Example pre-commit hook (`~/.git/hooks/pre-commit`):
```bash
#!/bin/bash
# Open Code Agents pre-commit hook

# Run code review
opencode-setup agents execute reviewer --files "$(git diff --cached --name-only)"

# Run tests if configured
if [ -f "package.json" ]; then
    npm test
fi

# Check exit code
if [ $? -ne 0 ]; then
    echo "❌ Pre-commit checks failed"
    exit 1
fi

echo "✅ Pre-commit checks passed"
```

### IDE Integration

#### VS Code

Install VS Code extension:
```bash
# Install extension
code --install-extension gsmlg.open-code-agents

# Or install manually from marketplace
```

Configure VS Code settings (`.vscode/settings.json`):
```json
{
  "openCodeAgents.enabled": true,
  "openCodeAgents.autoStart": true,
  "openCodeAgents.defaultAgent": "implementer",
  "openCodeAgents.showOutput": true,
  "openCodeAgents.integratedTerminal": true
}
```

Add tasks to `.vscode/tasks.json`:
```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Open Code: Review Current File",
      "type": "shell",
      "command": "opencode-setup",
      "args": [
        "agents", "execute", "reviewer",
        "--files", "${file}"
      ],
      "group": "build"
    },
    {
      "label": "Open Code: Quick Fix",
      "type": "shell",
      "command": "opencode-setup",
      "args": [
        "agents", "execute", "debugger",
        "--files", "${file}"
      ],
      "group": "build"
    }
  ]
}
```

#### JetBrains IDEs

Install plugin from JetBrains Marketplace:
1. Open `File > Settings > Plugins`
2. Search for "Open Code Agents"
3. Install and restart IDE

Configure in `settings.xml`:
```xml
<application>
  <component name="OpenCodeAgentsSettings">
    <option name="executablePath" value="/usr/local/bin/opencode-setup" />
    <option name="defaultAgent" value="implementer" />
    <option name="autoSync" value="true" />
  </component>
</application>
```

### CI/CD Integration

#### GitHub Actions

Create `.github/workflows/opencode-agents.yml`:
```yaml
name: Open Code Agents CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  code-review:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Open Code Agents
      run: |
        curl -fsSL https://raw.githubusercontent.com/gsmlg-dev/open-code-agents/main/setup-to-user.sh | bash
    
    - name: Run Code Review
      run: |
        opencode-setup agents execute reviewer --scope . --output review.md
    
    - name: Upload Review
      uses: actions/upload-artifact@v3
      with:
        name: code-review
        path: review.md
```

#### Jenkins Pipeline

```groovy
pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Setup Open Code Agents') {
            steps {
                sh 'curl -fsSL https://raw.githubusercontent.com/gsmlg-dev/open-code-agents/main/setup-to-user.sh | bash'
            }
        }
        
        stage('Code Analysis') {
            steps {
                sh 'opencode-setup agents execute reviewer --scope . --output analysis.json'
                archiveArtifacts artifacts: 'analysis.json'
            }
        }
    }
}
```

## Verification and Testing

### Basic Verification

```bash
# Check installation
opencode-setup --version

# List available agents
opencode-setup agents list

# List available commands
opencode-setup commands list

# Test basic functionality
opencode-setup agents execute implementer --test-mode
```

### Integration Testing

```bash
# Create test project
mkdir test-project
cd test-project
opencode-setup init --project

# Test workflow
echo "Add a simple hello world function" | opencode-setup commands workflow

# Verify results
ls -la
cat README.md  # Should contain documentation
```

### Performance Testing

```bash
# Run performance benchmark
opencode-setup benchmark --duration 60s --concurrent 5

# Test with large codebase
opencode-setup agents execute reviewer --scope /path/to/large/project --timing
```

## Troubleshooting

### Common Installation Issues

#### Issue: Permission Denied
```bash
# Solution: Make executable
chmod +x opencode-setup

# Or install system-wide
sudo mv opencode-setup /usr/local/bin/
```

#### Issue: Command Not Found
```bash
# Solution: Add to PATH
echo 'export PATH=$PATH:/path/to/opencode-setup' >> ~/.bashrc
source ~/.bashrc
```

#### Issue: Go Version Too Old
```bash
# Solution: Update Go
# Remove old version
sudo rm -rf /usr/local/go

# Install new version
wget https://golang.org/dl/go1.22.0.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz
```

### Configuration Issues

#### Issue: Invalid Configuration File
```bash
# Validate configuration
opencode-setup config validate

# Reset to defaults
opencode-setup config reset
```

#### Issue: Agent Not Found
```bash
# Check available agents
opencode-setup agents list

# Reinstall agents
opencode-setup agents install --all
```

### Performance Issues

#### Issue: Slow Execution
```bash
# Check system resources
opencode-setup system info

# Optimize configuration
opencode-setup config optimize
```

#### Issue: Memory Usage
```bash
# Monitor memory usage
opencode-setup monitor memory

# Reduce concurrent agents
opencode-setup config set max_concurrent_agents 2
```

## Maintenance and Updates

### Updating Open Code Agents

```bash
# Update to latest version
opencode-setup update

# Check for updates
opencode-setup check-updates

# Update specific components
opencode-setup update agents
opencode-setup update workflows
```

### Backup Configuration

```bash
# Backup configuration
cp -r ~/.config/opencode ~/.config/opencode.backup.$(date +%Y%m%d)

# Export configuration
opencode-setup config export > opencode-config.json
```

### Cleanup

```bash
# Clean cache
opencode-setup cleanup cache

# Remove old versions
opencode-setup cleanup old-versions

# Full reset (careful!)
opencode-setup reset --hard
```

## Next Steps

After completing installation and setup:

1. **Explore the System**: Read Chapter 3 to understand the architecture
2. **Try Basic Workflows**: Start with simple single-agent tasks
3. **Configure Your Environment**: Customize settings for your workflow
4. **Integrate with Tools**: Set up IDE and CI/CD integrations
5. **Join the Community**: Get help and share experiences

You're now ready to dive into the world of AI-powered development workflows!
