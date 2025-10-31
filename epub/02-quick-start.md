# Chapter 2: Quick Start Guide

This chapter gets you up and running with Open Code Agents quickly. We'll cover installation, basic usage, and your first agent workflow.

## Installation Methods

### Method 1: Build from Source

Open Code Agents is written in Go, making it easy to build from source:

```bash
# Clone the repository
git clone https://github.com/gsmlg-dev/open-code-agents.git
cd open-code-agents

# Build the CLI tool
go build ./cmd/opencode-setup

# Verify the installation
./opencode-setup --help
```

### Method 2: Download Pre-built Binary

For convenience, pre-built binaries are available:

```bash
# Download the latest binary for your platform
curl -L https://github.com/gsmlg-dev/open-code-agents/releases/download/latest/opencode-setup-linux-amd64.tar.gz | tar xz

# Make executable
chmod +x opencode-setup-linux-amd64

# Move to PATH (optional)
sudo mv opencode-setup-linux-amd64 /usr/local/bin/opencode-setup
```

Available platforms:
- `opencode-setup-linux-amd64.tar.gz` - Linux (x86_64)
- `opencode-setup-linux-arm64.tar.gz` - Linux (ARM64)
- `opencode-setup-macos-amd64.tar.gz` - macOS (Intel)
- `opencode-setup-macos-arm64.tar.gz` - macOS (Apple Silicon)

## Basic Commands and Usage

### Exploring Available Options

```bash
# Show main help
./opencode-setup --help

# List all available agents
./opencode-setup agents list

# List all available commands
./opencode-setup commands list

# Show available workflows
./opencode-setup commands workflow
```

### Your First Agent Workflow

Let's start with a simple example: implementing a new feature.

#### Step 1: Initialize Workflow

```bash
./opencode-setup commands workflow
```

You'll see an interactive menu:
```
Available Workflows:
1. new-feature      - Complete feature development
2. bug-fix         - Bug investigation and resolution
3. code-improvement - Code refactoring and optimization

Select workflow: 1
```

#### Step 2: Provide Context

```
Enter feature description: Add user authentication with JWT tokens
```

#### Step 3: Follow Agent Sequence

The system will automatically orchestrate:

1. **Researcher**: Investigates JWT authentication best practices
2. **Architect**: Designs the authentication system
3. **Implementer**: Writes the authentication code
4. **Tester**: Creates comprehensive tests
5. **Reviewer**: Ensures code quality
6. **Documenter**: Creates documentation

Each agent will:
- Analyze the current state
- Perform their specialized task
- Provide handoff to the next agent
- Document their work

## Understanding the CLI Interface

### Command Structure

The CLI follows a consistent structure:

```bash
./opencode-setup <category> <action> [options]
```

Categories:
- `agents` - Manage and execute individual agents
- `commands` - Execute predefined workflows
- `config` - Configure the system
- `help` - Get help and documentation

### Common Options

```bash
# Verbose output
./opencode-setup agents execute implementer --verbose

# Specify configuration file
./opencode-setup commands workflow --config ./my-config.json

# Dry run (show what would happen)
./opencode-setup agents execute architect --dry-run

# Interactive mode (default)
./opencode-setup commands workflow --interactive

# Non-interactive mode
./opencode-setup commands workflow --non-interactive
```

## Setting Up Your Environment

### Configuration Files

Open Code Agents uses JSON configuration files:

#### User-wide Configuration
Location: `~/.config/opencode/config.json`

```json
{
  "default_agent": "implementer",
  "workflows": {
    "my-feature": "new-feature"
  },
  "settings": {
    "log_level": "info",
    "auto_save": true,
    "show_hints": true,
    "max_history": 100
  }
}
```

#### Project-specific Configuration
Location: `.opencode/config.json` in project root

```json
{
  "project_name": "My Web App",
  "tech_stack": ["node.js", "react", "postgresql"],
  "agents": {
    "implementer": {
      "language": "javascript",
      "framework": "react"
    },
    "tester": {
      "framework": "jest",
      "coverage_threshold": 80
    }
  }
}
```

### Environment Variables

```bash
# Set default log level
export OPENCODE_LOG_LEVEL=debug

# Set configuration directory
export OPENCODE_CONFIG_DIR=/path/to/config

# Enable verbose mode
export OPENCODE_VERBOSE=true
```

## Your First Custom Agent

Let's try executing a single agent directly:

### Example: Code Review

```bash
# Review the current directory
./opencode-setup agents execute reviewer --scope ./src

# Review specific files
./opencode-setup agents execute reviewer --files ./src/auth.js ./src/user.js

# Review with specific criteria
./opencode-setup agents execute reviewer --criteria security,performance
```

### Example: Bug Investigation

```bash
# Debug a specific issue
./opencode-setup agents execute debugger \
  --issue "Login fails with valid credentials" \
  --context "After recent authentication update"
```

## Tips for Success

### 1. **Start Small**
Begin with simple, well-defined tasks to understand how agents work.

### 2. **Provide Clear Context**
The more specific your input, the better the results:
- ✅ Good: "Add JWT authentication with refresh tokens"
- ❌ Poor: "Add auth"

### 3. **Review Agent Outputs**
Always review what each agent produces before proceeding to the next step.

### 4. **Use Version Control**
Commit changes after each major agent completion:
```bash
git add .
git commit -m "feat: implementer - add authentication middleware"
```

### 5. **Learn Patterns**
Pay attention to how agents hand off work and what information they need.

## Troubleshooting Common Issues

### Installation Problems

**Issue**: `command not found: opencode-setup`
```bash
# Solution: Add to PATH or use full path
export PATH=$PATH:/path/to/opencode-setup
# or
./path/to/opencode-setup commands list
```

**Issue**: Permission denied
```bash
# Solution: Make executable
chmod +x opencode-setup
```

### Runtime Issues

**Issue**: Agent asks too many questions
```bash
# Solution: Provide more context upfront
./opencode-setup agents execute implementer \
  --context "React app with TypeScript, using Material-UI"
```

**Issue**: Workflow fails midway
```bash
# Solution: Check logs and resume
./opencode-setup commands workflow --resume --step implementer
```

## Next Steps

Congratulations! You now have:
- ✅ Installed Open Code Agents
- ✅ Explored the CLI interface
- ✅ Run your first agent workflow
- ✅ Configured your environment

In the next chapter, we'll dive deeper into the system architecture to understand how everything works under the hood.

## Quick Reference

| Task | Command |
|------|---------|
| List agents | `./opencode-setup agents list` |
| Execute agent | `./opencode-setup agents execute <agent>` |
| List workflows | `./opencode-setup commands workflow` |
| Run workflow | `./opencode-setup commands workflow` |
| Show help | `./opencode-setup --help` |
| Check version | `./opencode-setup --version` |

Keep this reference handy as you explore the system!
