#!/bin/bash
set -e

VERSION="$1"
if [ -z "$VERSION" ]; then
    VERSION="$(date +%Y%m%d)-dev"
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
EPUB_DIR="$PROJECT_ROOT/epub"

echo "📚 Generating EPUB Content for Open Code Agents"
echo "Version: $VERSION"

# Clean epub directory
rm -f "$EPUB_DIR"/*.md

# Generate metadata
echo "📋 Creating metadata..."
cat > "$EPUB_DIR/metadata.yaml" << METADATA
---
title: "Open Code Agents: Complete Guide to AI-Powered Development Workflows"
author: "Open Code Agents Project"
language: en-US
rights: "MIT License"
publisher: "Open Code Agents"
description: "Comprehensive guide to using specialized AI agents for automated software development workflows"
tags: ["AI", "Development", "Automation", "CLI", "Workflows"]
published: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
version: "$VERSION"
...

METADATA

# Generate CSS styling
echo "🎨 Creating CSS styles..."
cat > "$EPUB_DIR/style.css" << 'EOF'
/* Open Code Agents EPUB Styles */
body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
    line-height: 1.6;
    color: #333;
    max-width: 800px;
    margin: 0 auto;
    padding: 1em;
}

h1, h2, h3, h4, h5, h6 {
    color: #2c3e50;
    margin-top: 1.5em;
    margin-bottom: 0.8em;
    line-height: 1.3;
}

h1 {
    border-bottom: 3px solid #3498db;
    padding-bottom: 0.3em;
    font-size: 2.5em;
}

h2 {
    border-bottom: 2px solid #3498db;
    padding-bottom: 0.2em;
    font-size: 2em;
}

h3 {
    font-size: 1.5em;
    color: #34495e;
}

h4 {
    font-size: 1.3em;
    color: #34495e;
}

p {
    margin-bottom: 1em;
}

code {
    background-color: #f8f9fa;
    padding: 0.2em 0.4em;
    border-radius: 3px;
    font-family: "SFMono-Regular", Consolas, "Liberation Mono", Menlo, monospace;
    font-size: 0.9em;
    color: #e74c3c;
}

pre {
    background-color: #f8f9fa;
    border: 1px solid #e9ecef;
    border-radius: 5px;
    padding: 1em;
    overflow-x: auto;
    margin: 1em 0;
}

pre code {
    background-color: transparent;
    padding: 0;
    border-radius: 0;
    color: #333;
}

blockquote {
    border-left: 4px solid #3498db;
    margin: 1em 0;
    padding: 0.5em 1.5em;
    background-color: #f8f9fa;
    color: #6c757d;
}

table {
    border-collapse: collapse;
    width: 100%;
    margin: 1em 0;
}

th, td {
    border: 1px solid #dee2e6;
    padding: 0.75em;
    text-align: left;
}

th {
    background-color: #f8f9fa;
    font-weight: bold;
}

ul, ol {
    padding-left: 2em;
    margin-bottom: 1em;
}

li {
    margin-bottom: 0.5em;
}

a {
    color: #3498db;
    text-decoration: none;
}

a:hover {
    text-decoration: underline;
}

/* Agent-specific styling */
.agent-role {
    background-color: #e8f4fd;
    border-left: 4px solid #3498db;
    padding: 1em;
    margin: 1em 0;
    border-radius: 0 5px 5px 0;
}

.workflow-step {
    background-color: #f0f8f0;
    border: 1px solid #28a745;
    border-radius: 5px;
    padding: 1em;
    margin: 1em 0;
}

.best-practice {
    background-color: #fff3cd;
    border-left: 4px solid #ffc107;
    padding: 1em;
    margin: 1em 0;
}

.example-box {
    background-color: #f8f9fa;
    border: 1px solid #6c757d;
    border-radius: 5px;
    padding: 1em;
    margin: 1em 0;
}

.toc {
    background-color: #f8f9fa;
    border: 1px solid #dee2e6;
    border-radius: 5px;
    padding: 1em;
    margin: 1em 0;
}

.toc ul {
    padding-left: 1em;
}

.toc li {
    list-style-type: none;
    margin-bottom: 0.3em;
}

EOF

# Generate chapters
echo "📖 Generating chapters..."

# Chapter 1: Introduction
echo "Creating Chapter 1: Introduction..."
cat > "$EPUB_DIR/01-introduction.md" << 'CHAPTER_EOF'
# Chapter 1: Introduction to Open Code Agents

## What Are Open Code Agents?

Open Code Agents is a revolutionary CLI tool that brings the power of specialized AI personas to software development workflows. Imagine having a team of expert developers—each with their own specialized skills—ready to tackle any development challenge you throw at them. That's exactly what Open Code Agents provides.

## The Problem: Managing Complex Development Workflows

Modern software development is complex. A single feature might require:

- **Research** into best practices and technologies
- **Architectural design** to ensure scalability
- **Implementation** with clean, maintainable code
- **Testing** to guarantee reliability
- **Review** to maintain quality standards
- **Documentation** for future maintainers

Traditionally, developers must wear all these hats simultaneously, leading to:
- Context switching and cognitive overload
- Inconsistent quality across different domains
- Longer development cycles
- Increased risk of mistakes

## The Solution: Specialized AI Personas

Open Code Agents solves this problem by providing **8 specialized AI agents**, each an expert in their domain:

| Agent | Specialization | Primary Role |
|-------|----------------|-------------|
| **Architect** | System Design | High-level architectural planning |
| **Implementer** | Code Development | Writing production-quality code |
| **Tester** | Quality Assurance | Creating comprehensive test suites |
| **Debugger** | Issue Resolution | Analyzing and fixing bugs |
| **Reviewer** | Code Review | Evaluating code quality |
| **Refactorer** | Code Improvement | Improving code structure |
| **Documenter** | Documentation | Creating comprehensive docs |
| **Researcher** | Investigation | Researching technologies |

Each agent embodies years of expertise in their specific domain, following established best practices and workflows.

## Benefits of Agent-Based Development

### 1. **Focused Expertise**
Each agent focuses exclusively on their domain, ensuring:
- Deep understanding of best practices
- Consistent application of standards
- Reduced cognitive load for developers

### 2. **Workflow Orchestration**
Agents collaborate through structured handoffs:
- Clear communication patterns
- Context preservation between stages
- Quality gates at each transition

### 3. **Consistency and Quality**
Standardized workflows ensure:
- Repeatable results
- Measurable quality metrics
- Reduced human error

### 4. **Scalability**
Handle projects of any size:
- Small tasks: Single agent execution
- Medium features: Multi-agent workflows
- Large projects: Complex orchestration patterns

## Who This Book Is For

This book is designed for:

### **Developers**
- Want to improve development efficiency
- Need consistent code quality
- Looking to automate repetitive tasks

### **Team Leads**
- Managing development workflows
- Ensuring code quality standards
- Optimizing team productivity

### **DevOps Engineers**
- Automating development pipelines
- Integrating AI tools into workflows
- Scaling development processes

### **Technical Managers**
- Understanding modern development practices
- Evaluating AI-assisted development
- Planning team capabilities

## How to Use This Book

### **For Beginners**
Start with Chapters 1-3 to understand:
- Core concepts and philosophy
- Installation and setup
- Basic usage patterns

### **For Practitioners**
Dive into Chapters 4-12 for:
- Detailed agent capabilities
- Workflow patterns
- Integration strategies

### **For Advanced Users**
Explore Chapters 13-21 for:
- Custom command creation
- Advanced configuration
- System integration

### **Reference Material**
Use Part 5 (Chapters 19-21) as:
- Quick reference for commands
- Agent capability matrix
- Best practices summary

## The Journey Ahead

This book will take you on a comprehensive journey through the Open Code Agents ecosystem:

1. **Understanding the System**: Learn architecture and philosophy
2. **Mastering the Agents**: Deep dive into each specialized agent
3. **Orchestrating Workflows**: Combine agents for complex tasks
4. **Advanced Integration**: Extend and customize the system
5. **Reference Material**: Quick guides and best practices

By the end of this book, you'll be able to:
- Choose the right agent for any task
- Design efficient multi-agent workflows
- Create custom commands and automation
- Integrate Open Code Agents into your existing processes
- Scale development workflows for teams and projects

## Getting Started

Ready to begin? The next chapter will guide you through:
- Installing Open Code Agents
- Setting up your environment
- Running your first agent workflow
- Understanding the CLI interface

Let's embark on this journey to transform your development workflow with the power of specialized AI agents.
CHAPTER_EOF

# Chapter 2: Quick Start Guide
echo "Creating Chapter 2: Quick Start Guide..."
cat > "$EPUB_DIR/02-quick-start.md" << 'CHAPTER_EOF'
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
CHAPTER_EOF

# Chapter 3: System Architecture
echo "Creating Chapter 3: System Architecture..."
cat > "$EPUB_DIR/03-architecture.md" << 'CHAPTER_EOF'
# Chapter 3: System Architecture

This chapter explores the technical architecture of Open Code Agents, understanding how the system is designed and how the components work together.

## Core Components

### 1. CLI Interface (`cmd/`)
The command-line interface serves as the entry point for all interactions:

```
cmd/
├── opencode-setup/
│   └── main.go          # Main CLI entry point
```

**Key Features:**
- Command parsing and routing
- Interactive menu system
- Configuration management
- Error handling and logging

### 2. Agent System (`pkg/agent/`)
The heart of the system, managing AI agent execution:

```
pkg/agent/
├── engine.go           # Agent execution engine
└── engine_test.go      # Test suite
```

**Core Capabilities:**
- Agent lifecycle management
- Context preservation
- Handoff coordination
- State management

### 3. Configuration Management (`pkg/config/`)
Handles system and project configuration:

```
pkg/config/
├── config.go           # Configuration structures
└── agents.go           # Agent definitions
```

**Configuration Types:**
- Global user settings
- Project-specific settings
- Agent configurations
- Workflow definitions

### 4. CLI Commands (`pkg/cli/`)
Implements all CLI commands and subcommands:

```
pkg/cli/
├── root.go            # Root command setup
├── agents.go          # Agent management commands
├── commands.go        # Workflow commands
├── mcp.go             # MCP integration
└── skills.go          # Skill management
```

### 5. Orchestrator (`pkg/orchestrator/`)
Manages complex multi-agent workflows:

```
pkg/orchestrator/
├── workflow.go        # Workflow orchestration
└── workflow_test.go   # Workflow tests
```

**Workflow Features:**
- Agent sequencing
- Context passing
- Error recovery
- Progress tracking

## Agent Architecture

### Agent Definition Structure

Each agent is defined with:

```go
type Agent struct {
    Name        string            // Agent identifier
    Role        string            // Professional role
    Description string            // Capabilities description
    Skills      []string          // Available skills
    Config      AgentConfig       // Agent-specific settings
}
```

### Agent Execution Model

1. **Initialization**: Load agent configuration and context
2. **Analysis**: Understand the task and current state
3. **Execution**: Perform the specialized task
4. **Validation**: Ensure quality and completeness
5. **Handoff**: Prepare context for next agent

### Context Management

Agents share context through a structured format:

```go
type Context struct {
    Project      ProjectInfo       // Project details
    Task         TaskInfo          // Current task
    History      []AgentResult     // Previous agent results
    State        map[string]interface{} // Current state
    Metadata     ContextMetadata   // Additional context
}
```

## Workflow Orchestration

### Workflow Definition

Workflows are defined as sequences of agents:

```yaml
workflows:
  new-feature:
    agents:
      - name: researcher
        role: investigate_requirements
      - name: architect
        role: design_solution
      - name: implementer
        role: implement_feature
      - name: tester
        role: create_tests
      - name: reviewer
        role: review_code
      - name: documenter
        role: document_changes
```

### Execution Flow

1. **Workflow Selection**: User chooses appropriate workflow
2. **Agent Initialization**: Set up initial context
3. **Sequential Execution**: Run agents in defined order
4. **Context Passing**: Transfer state between agents
5. **Quality Gates**: Validate completion at each step
6. **Completion**: Final validation and cleanup

## Data Flow Architecture

### Input Processing

```
User Input → CLI Parser → Command Router → Agent Engine
```

### Agent Execution Flow

```
Context → Agent → Analysis → Execution → Result → Updated Context
```

### Output Generation

```
Agent Result → Formatter → CLI Output → File System/Console
```

## Configuration Architecture

### Configuration Hierarchy

1. **System Defaults**: Built-in default configurations
2. **Global Config**: User-wide settings (`~/.config/opencode/`)
3. **Project Config**: Project-specific settings (`.opencode/`)
4. **Runtime Config**: Command-line overrides

### Configuration Merging

Configurations are merged with precedence:
```
Runtime > Project > Global > System Defaults
```

## Integration Points

### Model Context Protocol (MCP)

Open Code Agents integrates with MCP for:
- External tool integration
- Extended agent capabilities
- Third-party service connections

### Embed System

Static resources are embedded in the binary:
```
embed/
├── agents/           # Agent definitions
└── resources/        # Static resources
```

### Installer System

Automated installation and setup:
```
pkg/installer/
└── agents.go         # Agent installation logic
```

## Error Handling Architecture

### Error Types

1. **Configuration Errors**: Invalid settings or missing files
2. **Agent Errors**: Agent execution failures
3. **Workflow Errors**: Workflow orchestration issues
4. **System Errors**: Infrastructure problems

### Error Recovery Strategies

1. **Graceful Degradation**: Continue with reduced functionality
2. **Retry Logic**: Automatic retry for transient failures
3. **User Intervention**: Prompt for manual resolution
4. **Rollback**: Revert partial changes on failure

## Performance Considerations

### Caching Strategy

- **Agent Definitions**: Cache loaded agent configurations
- **Configuration**: Cache parsed configuration files
- **Context**: Preserve context between agent executions

### Resource Management

- **Memory**: Efficient context storage and sharing
- **CPU**: Optimize agent execution parallelization
- **I/O**: Minimize file system operations

### Scalability Design

- **Modular Architecture**: Easy addition of new agents
- **Plugin System**: Extensible capability framework
- **Distributed Execution**: Future support for remote agents

## Security Architecture

### Isolation

- **Agent Sandboxing**: Limited access to system resources
- **Context Validation**: Sanitize all inputs and outputs
- **Permission Controls**: Granular access controls

### Data Protection

- **Sensitive Data**: Encrypt sensitive configuration values
- **Audit Logging**: Track all agent actions
- **Access Controls**: Role-based access to features

## Testing Architecture

### Test Organization

```
pkg/
├── agent/
│   └── engine_test.go      # Agent engine tests
└── orchestrator/
    └── workflow_test.go    # Workflow tests
```

### Test Types

1. **Unit Tests**: Individual component testing
2. **Integration Tests**: Component interaction testing
3. **End-to-End Tests**: Complete workflow testing
4. **Performance Tests**: Load and stress testing

## Future Architecture Considerations

### Distributed Agents

- **Remote Execution**: Support for cloud-based agents
- **Load Balancing**: Distribute work across multiple instances
- **Fault Tolerance**: Handle network failures and timeouts

### Advanced Features

- **Learning System**: Agents learn from previous executions
- **Adaptive Workflows**: Dynamic workflow adjustment
- **Collaborative Editing**: Real-time multi-user support

### Integration Expansion

- **IDE Plugins**: Direct integration with development environments
- **CI/CD Integration**: Native pipeline integration
- **API Access**: RESTful API for external tool integration

## Summary

The Open Code Agents architecture is designed for:

- **Modularity**: Clear separation of concerns
- **Extensibility**: Easy addition of new capabilities
- **Reliability**: Robust error handling and recovery
- **Performance**: Efficient resource utilization
- **Security**: Comprehensive security measures

This architecture enables the system to scale from simple single-agent tasks to complex multi-agent workflows while maintaining reliability and performance.
CHAPTER_EOF

# Chapter 4: Installation and Setup
echo "Creating Chapter 4: Installation and Setup..."
cat > "$EPUB_DIR/04-installation.md" << 'CHAPTER_EOF'
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
CHAPTER_EOF

# Chapter 5: The Architect Agent
echo "Creating Chapter 5: The Architect Agent..."
cat > "$EPUB_DIR/05-architect.md" << 'CHAPTER_EOF'
# Chapter 5: The Architect Agent

The Architect agent is your strategic system design partner, specializing in creating robust, scalable, and maintainable software architectures. This chapter explores how to leverage the Architect agent for optimal system design.

## Role and Responsibilities

### Primary Focus Areas

The Architect agent excels at:

- **System Design**: Creating high-level architectural blueprints
- **Technology Selection**: Choosing appropriate technologies and frameworks
- **Scalability Planning**: Designing systems that can grow with demand
- **Integration Strategy**: Planning how components interact
- **Security Architecture**: Designing secure system foundations
- **Performance Optimization**: Planning for optimal system performance

### Core Responsibilities

1. **Requirements Analysis**: Understanding business and technical requirements
2. **Architecture Design**: Creating comprehensive system designs
3. **Technology Evaluation**: Assessing and recommending technologies
4. **Documentation**: Creating architectural documentation
5. **Risk Assessment**: Identifying potential architectural risks
6. **Compliance**: Ensuring architectural standards compliance

## When to Use the Architect Agent

### Ideal Scenarios

Use the Architect agent when:

#### **New System Design**
```
Scenario: Building a new e-commerce platform
Input: "Design a scalable e-commerce platform for 100k daily users"
Output: Complete system architecture with microservices, database design, and infrastructure recommendations
```

#### **System Expansion**
```
Scenario: Expanding existing application
Input: "Our monolithic app needs to handle 10x current load. Plan the migration to microservices"
Output: Migration strategy, service decomposition plan, and timeline
```

#### **Technology Migration**
```
Scenario: Legacy system modernization
Input: "Migrate our PHP monolith to a modern stack. Recommend architecture and approach"
Output: Modernization roadmap, technology stack, and implementation strategy
```

#### **Performance Optimization**
```
Scenario: System performance issues
Input: "Our API response times are increasing. Analyze and redesign for better performance"
Output: Performance analysis and architectural improvements
```

### Not Ideal For

- **Implementation Details**: Use the Implementer agent for coding
- **Bug Fixes**: Use the Debugger agent for troubleshooting
- **Code Reviews**: Use the Reviewer agent for code quality
- **Testing**: Use the Tester agent for test creation

## Architect Agent Capabilities

### Design Patterns Expertise

The Architect agent has deep knowledge of:

#### **Architectural Patterns**
- Microservices Architecture
- Event-Driven Architecture
- Domain-Driven Design (DDD)
- Service-Oriented Architecture (SOA)
- Serverless Architecture
- Hexagonal Architecture

#### **Design Patterns**
- Repository Pattern
- Factory Pattern
- Observer Pattern
- Strategy Pattern
- Command Pattern
- Decorator Pattern

#### **Integration Patterns**
- API Gateway
- Message Broker
- Event Sourcing
- CQRS (Command Query Responsibility Segregation)
- Saga Pattern
- Circuit Breaker

### Technology Stack Assessment

The Architect agent evaluates technologies across:

#### **Frontend Technologies**
- React, Vue.js, Angular
- Next.js, Nuxt.js
- State management solutions
- CSS frameworks and methodologies
- Progressive Web App (PWA) technologies

#### **Backend Technologies**
- Node.js, Python, Go, Java, .NET
- Framework selection (Express, Django, Gin, Spring Boot)
- Database technologies (SQL vs NoSQL)
- Message queue systems
- Container orchestration

#### **Infrastructure Technologies**
- Cloud providers (AWS, GCP, Azure)
- Container technologies (Docker, Kubernetes)
- Serverless platforms
- CDN and caching solutions
- Monitoring and observability

## Using the Architect Agent

### Basic Usage

#### **Command Line Interface**
```bash
# Basic architecture design
opencode-setup agents execute architect \
  --task "Design a REST API for user management" \
  --context "Node.js, Express, PostgreSQL"

# Technology recommendation
opencode-setup agents execute architect \
  --task "Recommend tech stack for real-time chat app" \
  --requirements "scalable, low-latency, 10k concurrent users"

# System redesign
opencode-setup agents execute architect \
  --task "Redesign monolith to microservices" \
  --scope "user authentication, order processing, inventory"
```

#### **Interactive Mode**
```bash
# Start interactive architecture session
opencode-setup agents execute architect --interactive

# Example interaction:
> What would you like to design?
I need to design a file sharing service

> What are the key requirements?
- Support for 1M users
- File sizes up to 10GB
- Real-time collaboration
- Mobile and web apps

> Any technology preferences?
We prefer Node.js and cloud-native solutions
```

### Advanced Usage

#### **Configuration-Driven Architecture**
```bash
# Create architecture configuration
cat > arch-config.json << EOF
{
  "project": {
    "type": "saas_application",
    "scale": "enterprise",
    "users": "100000+",
    "availability": "99.9%"
  },
  "requirements": {
    "performance": {
      "response_time": "<200ms",
      "throughput": "10000 req/s"
    },
    "security": {
      "authentication": "oauth2",
      "encryption": "aes256"
    },
    "scalability": {
      "horizontal_scaling": true,
      "auto_scaling": true
    }
  },
  "constraints": {
    "budget": "moderate",
    "timeline": "6 months",
    "team_size": "8 developers"
  }
}
EOF

# Use configuration for architecture design
opencode-setup agents execute architect \
  --config arch-config.json \
  --output architecture-plan.md
```

#### **Multi-Phase Architecture**
```bash
# Phase 1: High-level design
opencode-setup agents execute architect \
  --task "Design system architecture" \
  --phase "high_level" \
  --output phase1-architecture.md

# Phase 2: Detailed design
opencode-setup agents execute architect \
  --task "Detail component design" \
  --phase "detailed" \
  --input phase1-architecture.md \
  --output phase2-architecture.md

# Phase 3: Implementation plan
opencode-setup agents execute architect \
  --task "Create implementation roadmap" \
  --phase "implementation" \
  --input phase2-architecture.md \
  --output implementation-plan.md
```

## Input and Output Examples

### Input Examples

#### **Simple Request**
```
Design a microservices architecture for an e-commerce platform
```

#### **Detailed Request**
```
Design a scalable e-commerce platform with the following requirements:
- 100k daily active users
- Support for product catalog, shopping cart, payments, user accounts
- Mobile app and web frontend
- Real-time inventory updates
- PCI compliance for payments
- Technology preference: Node.js, React, PostgreSQL, Redis
- Deployment: AWS with auto-scaling
```

#### **Context-Rich Request**
```
We need to redesign our legacy monolithic application. Current issues:
- Single database bottleneck
- Difficult to deploy individual features
- Technology stack is outdated (PHP 5.6, MySQL 5.5)
- No automated testing or deployment

Requirements for new architecture:
- Microservices approach
- CI/CD pipeline
- Modern technology stack
- 99.9% uptime requirement
- Support for 10x growth in users
- Team of 12 developers with varying skill levels
```

### Output Examples

#### **Architecture Overview**
```markdown
# E-Commerce Platform Architecture

## System Overview
- **Architecture Pattern**: Microservices with API Gateway
- **Technology Stack**: Node.js, React, PostgreSQL, Redis, Docker
- **Infrastructure**: AWS EKS, RDS, ElastiCache, CloudFront
- **Scalability**: Horizontal auto-scaling with load balancing

## Core Services
1. **User Service**: Authentication, authorization, profile management
2. **Product Service**: Catalog management, search, recommendations
3. **Order Service**: Cart management, order processing, payment integration
4. **Inventory Service**: Stock management, real-time updates
5. **Notification Service**: Email, SMS, push notifications

## Data Architecture
- **Primary Database**: PostgreSQL with read replicas
- **Caching Layer**: Redis for session and product data
- **Search Engine**: Elasticsearch for product search
- **File Storage**: S3 for images and documents
```

#### **Component Diagram**
```mermaid
graph TB
    Client[Web/Mobile Client] --> Gateway[API Gateway]
    Gateway --> Auth[User Service]
    Gateway --> Product[Product Service]
    Gateway --> Order[Order Service]
    Gateway --> Inventory[Inventory Service]
    
    Auth --> UserDB[(User DB)]
    Product --> ProductDB[(Product DB)]
    Order --> OrderDB[(Order DB)]
    Inventory --> InventoryDB[(Inventory DB)]
    
    Product --> Cache[Redis Cache]
    Product --> Search[Elasticsearch]
    
    Gateway --> Queue[Message Queue]
    Order --> Queue
    Inventory --> Queue
```

#### **Technology Recommendations**
```markdown
## Technology Stack Recommendations

### Backend Services
- **Runtime**: Node.js 18+ with TypeScript
- **Framework**: Express.js with middleware architecture
- **Database**: PostgreSQL 14+ with connection pooling
- **ORM**: Prisma for type-safe database access
- **Authentication**: JWT with refresh tokens

### Frontend Applications
- **Web**: React 18 with Next.js 13
- **Mobile**: React Native with Expo
- **State Management**: Redux Toolkit with RTK Query
- **UI Components**: Material-UI (MUI)

### Infrastructure
- **Containerization**: Docker with multi-stage builds
- **Orchestration**: Kubernetes with Helm charts
- **CI/CD**: GitHub Actions with ArgoCD
- **Monitoring**: Prometheus + Grafana + Jaeger
```

## Best Practices for Architect Agent

### Providing Good Input

#### **✅ Good Input Examples**
```
Design a task management system for:
- 50k users
- Real-time collaboration
- Mobile and web apps
- Technology: Python, Django, PostgreSQL
- Deployment: AWS with auto-scaling
```

#### **❌ Poor Input Examples**
```
Design an app
```

### Structuring Requirements

Use the following structure for best results:

```markdown
## Project Context
[Brief description of the project and business goals]

## Functional Requirements
[List of features and capabilities]

## Non-Functional Requirements
[Performance, security, scalability requirements]

## Technical Constraints
[Technology preferences, team skills, budget limitations]

## Business Constraints
[Timeline, team size, regulatory requirements]
```

### Reviewing Architect Output

When reviewing the Architect agent's output:

1. **Validate Requirements**: Ensure all requirements are addressed
2. **Check Feasibility**: Verify the proposed solution is achievable
3. **Assess Trade-offs**: Understand the decisions and alternatives
4. **Review Integration**: Ensure components work together properly
5. **Plan Implementation**: Create actionable next steps

## Integration with Other Agents

### Typical Workflow Sequence

1. **Researcher** (optional): Research requirements and best practices
2. **Architect**: Design system architecture
3. **Implementer**: Implement based on architectural design
4. **Tester**: Create tests for the implemented system
5. **Reviewer**: Review implementation against architecture
6. **Documenter**: Document the final system

### Handoff Patterns

#### **Architect → Implementer**
The Architect provides:
- System design documents
- Component specifications
- API contracts
- Database schemas
- Technology recommendations

#### **Architect → Reviewer**
The Architect provides:
- Architecture principles
- Design decisions documentation
- Trade-off analysis
- Compliance requirements

## Common Use Cases

### **Use Case 1: Startup MVP Architecture**

**Input**: "Design MVP architecture for social media app"

**Output**:
- Monolithic architecture for rapid development
- Simple database design
- Basic authentication system
- Deployment on single server
- Migration path to microservices

### **Use Case 2: Enterprise System Integration**

**Input**: "Integrate three legacy systems into unified platform"

**Output**:
- API Gateway pattern
- Message broker for async communication
- Data synchronization strategy
- Security integration approach
- Phased migration plan

### **Use Case 3: Performance Optimization**

**Input**: "Optimize architecture for 100x traffic growth"

**Output**:
- Caching strategy
- Database optimization
- Load balancing configuration
- CDN implementation
- Auto-scaling policies

## Troubleshooting

### Common Issues

#### **Issue: Vague Requirements**
**Problem**: Insufficient detail leads to generic architecture
**Solution**: Provide detailed requirements and constraints

#### **Issue: Technology Mismatch**
**Problem**: Recommended technologies don't fit team skills
**Solution**: Include team capabilities and learning curve considerations

#### **Issue: Over-Engineering**
**Problem**: Complex architecture for simple requirements
**Solution**: Focus on YAGNI (You Aren't Gonna Need It) principle

#### **Issue: Missing Constraints**
**Problem**: Architecture ignores budget or timeline constraints
**Solution**: Clearly specify all business and technical constraints

### Getting Better Results

1. **Provide Context**: Include business goals and constraints
2. **Specify Scale**: Define expected user load and growth
3. **List Technologies**: Include current stack and preferences
4. **Define Timeline**: Specify development and deployment timeline
5. **Team Assessment**: Describe team skills and experience level

## Advanced Features

### **Architecture Patterns Library**
```bash
# Browse available patterns
opencode-setup agents execute architect --list-patterns

# Apply specific pattern
opencode-setup agents execute architect \
  --pattern "microservices" \
  --context "e-commerce platform"
```

### **Technology Comparison**
```bash
# Compare technologies
opencode-setup agents execute architect \
  --task "Compare databases for high-write workload" \
  --compare "postgresql,mongodb,cassandra"
```

### **Cost Estimation**
```bash
# Estimate infrastructure costs
opencode-setup agents execute architect \
  --task "Estimate AWS costs for proposed architecture" \
  --duration "monthly" \
  --region "us-east-1"
```

## Summary

The Architect agent is your strategic partner for:

- **System Design**: Creating robust, scalable architectures
- **Technology Selection**: Making informed technology decisions
- **Strategic Planning**: Planning for growth and evolution
- **Risk Mitigation**: Identifying and addressing architectural risks

By providing clear requirements and context, you can leverage the Architect agent to create designs that serve your project's needs both now and in the future.

The key to success with the Architect agent is providing detailed, structured input and carefully reviewing the output to ensure it meets all your requirements and constraints.
CHAPTER_EOF

# Chapter 6: The Implementer Agent
echo "Creating Chapter 6: The Implementer Agent..."
cat > "$EPUB_DIR/06-implementer.md" << 'CHAPTER_EOF'
# Chapter 6: The Implementer Agent

The Implementer agent is your expert code craftsman, specializing in writing clean, maintainable, and production-ready code. This chapter explores how to effectively use the Implementer agent for high-quality software development.

## Role and Responsibilities

### Primary Focus Areas

The Implementer agent excels at:

- **Code Development**: Writing clean, efficient, and maintainable code
- **Best Practices**: Following industry coding standards and patterns
- **Problem Solving**: Translating requirements into working solutions
- **Code Organization**: Structuring code for readability and maintainability
- **Performance Optimization**: Writing efficient and performant code
- **Testing Integration**: Creating code that's easily testable

### Core Responsibilities

1. **Requirement Analysis**: Understanding functional and non-functional requirements
2. **Code Implementation**: Writing production-quality code
3. **Design Patterns**: Applying appropriate design patterns
4. **Error Handling**: Implementing robust error handling
5. **Documentation**: Writing clear code comments and documentation
6. **Integration**: Ensuring code integrates well with existing systems

## When to Use the Implementer Agent

### Ideal Scenarios

Use the Implementer agent when:

#### **Feature Implementation**
```
Scenario: Adding new functionality to an application
Input: "Implement user authentication with JWT tokens, including login, logout, and token refresh"
Output: Complete authentication module with proper error handling and security measures
```

#### **API Development**
```
Scenario: Creating REST API endpoints
Input: "Create REST API for user management with CRUD operations, validation, and error responses"
Output: Complete API controller with middleware, validation, and proper HTTP status codes
```

#### **Component Development**
```
Scenario: Building reusable UI components
Input: "Create a reusable data table component with sorting, filtering, and pagination for React"
Output: Fully functional React component with TypeScript types and comprehensive props
```

#### **Algorithm Implementation**
```
Scenario: Implementing complex business logic
Input: "Implement a recommendation algorithm based on user behavior and collaborative filtering"
Output: Optimized algorithm with proper data structures and edge case handling
```

### Not Ideal For

- **System Architecture**: Use the Architect agent for high-level design
- **Testing Strategy**: Use the Tester agent for comprehensive test planning
- **Code Review**: Use the Reviewer agent for quality assessment
- **Bug Investigation**: Use the Debugger agent for troubleshooting

## Implementer Agent Capabilities

### Programming Languages Expertise

The Implementer agent has deep knowledge of:

#### **Web Development**
- **JavaScript/TypeScript**: Node.js, Express, React, Vue, Angular
- **Python**: Django, Flask, FastAPI, pandas, NumPy
- **Go**: Gin, Echo, standard library, concurrency patterns
- **Java**: Spring Boot, Jakarta EE, Maven/Gradle
- **PHP**: Laravel, Symfony, Composer

#### **Mobile Development**
- **React Native**: Cross-platform mobile apps
- **Flutter**: Dart-based mobile development
- **Swift**: iOS native development
- **Kotlin**: Android native development

#### **Systems Programming**
- **Rust**: Systems programming with memory safety
- **C++**: High-performance systems development
- **C**: Low-level system programming

#### **Data Science**
- **Python**: pandas, NumPy, scikit-learn, TensorFlow
- **R**: Statistical analysis and visualization
- **SQL**: Database queries and optimization

### Framework and Library Expertise

#### **Frontend Frameworks**
- React, Vue.js, Angular, Svelte
- Next.js, Nuxt.js, Gatsby
- Material-UI, Ant Design, Bootstrap
- Redux, MobX, Zustand

#### **Backend Frameworks**
- Express.js, FastAPI, Django, Flask
- Spring Boot, ASP.NET Core
- Gin, Echo (Go)
- Laravel, Symfony (PHP)

#### **Database Technologies**
- PostgreSQL, MySQL, MongoDB
- Redis, Cassandra, DynamoDB
- Prisma, SQLAlchemy, TypeORM
- GraphQL, REST APIs

### Development Patterns and Practices

#### **Code Organization**
- Modular architecture
- Clean code principles
- SOLID principles
- Design patterns implementation
- Separation of concerns

#### **Error Handling**
- Graceful error handling
- Proper logging
- User-friendly error messages
- Recovery strategies
- Input validation

#### **Performance Optimization**
- Efficient algorithms
- Memory management
- Database query optimization
- Caching strategies
- Async/await patterns

## Using the Implementer Agent

### Basic Usage

#### **Command Line Interface**
```bash
# Basic feature implementation
opencode-setup agents execute implementer \
  --task "Implement user registration with email verification" \
  --language "javascript" \
  --framework "express"

# API endpoint creation
opencode-setup agents execute implementer \
  --task "Create REST API endpoints for product management" \
  --context "Node.js, Express, PostgreSQL, Prisma"

# Component development
opencode-setup agents execute implementer \
  --task "Create reusable modal component" \
  --language "typescript" \
  --framework "react" \
  --library "material-ui"
```

#### **Interactive Mode**
```bash
# Start interactive implementation session
opencode-setup agents execute implementer --interactive

# Example interaction:
> What would you like to implement?
I need to implement a file upload service

> What are the requirements?
- Support multiple file types
- Progress tracking
- File size limits
- Cloud storage integration

> Any specific technologies?
Node.js with Express and AWS S3
```

### Advanced Usage

#### **Specification-Driven Development**
```bash
# Create implementation specification
cat > feature-spec.json << EOF
{
  "feature": "user_authentication",
  "requirements": {
    "login": {
      "method": "POST",
      "endpoint": "/api/auth/login",
      "input": ["email", "password"],
      "output": ["token", "user", "expires_in"]
    },
    "register": {
      "method": "POST",
      "endpoint": "/api/auth/register",
      "input": ["email", "password", "name"],
      "output": ["user", "message"]
    },
    "refresh": {
      "method": "POST",
      "endpoint": "/api/auth/refresh",
      "input": ["refresh_token"],
      "output": ["token", "expires_in"]
    }
  },
  "security": {
    "password_hashing": "bcrypt",
    "jwt_secret": "env_variable",
    "token_expiry": "24h"
  },
  "validation": {
    "email": "required|email",
    "password": "required|min:8"
  }
}
EOF

# Implement from specification
opencode-setup agents execute implementer \
  --spec feature-spec.json \
  --output auth-module/
```

#### **Incremental Implementation**
```bash
# Phase 1: Basic structure
opencode-setup agents execute implementer \
  --task "Create basic user model and database schema" \
  --phase "structure" \
  --output models/user.js

# Phase 2: Core functionality
opencode-setup agents execute implementer \
  --task "Implement user CRUD operations" \
  --phase "core" \
  --input models/user.js \
  --output controllers/userController.js

# Phase 3: API endpoints
opencode-setup agents execute implementer \
  --task "Create API routes for user management" \
  --phase "api" \
  --input controllers/userController.js \
  --output routes/users.js
```

#### **Test-Driven Implementation**
```bash
# Generate tests first
opencode-setup agents execute tester \
  --task "Create tests for user authentication" \
  --output tests/auth.test.js

# Implement to pass tests
opencode-setup agents execute implementer \
  --task "Implement authentication to satisfy tests" \
  --test-driven true \
  --tests tests/auth.test.js \
  --output auth/
```

## Input and Output Examples

### Input Examples

#### **Simple Request**
```
Implement a REST API for managing blog posts with CRUD operations
```

#### **Detailed Request**
```
Implement a user management system with the following features:
- User registration with email verification
- Login with JWT authentication
- Password reset functionality
- Profile management with avatar upload
- Role-based access control (admin, user, moderator)

Technical requirements:
- Node.js with Express framework
- PostgreSQL database with Prisma ORM
- Input validation with Joi
- Error handling middleware
- Logging with Winston
- Unit tests with Jest

Security requirements:
- Password hashing with bcrypt
- Rate limiting on auth endpoints
- CORS configuration
- Input sanitization
```

#### **API Specification**
```
Create REST API endpoints for product management:

GET /api/products - List all products (paginated)
GET /api/products/:id - Get product by ID
POST /api/products - Create new product (admin only)
PUT /api/products/:id - Update product (admin only)
DELETE /api/products/:id - Delete product (admin only)

Product schema:
- id: UUID (primary key)
- name: string (required, max 255 chars)
- description: text (optional)
- price: decimal (required, min 0)
- category: string (required)
- stock: integer (required, min 0)
- created_at: timestamp
- updated_at: timestamp

Validation:
- Name and price are required
- Price must be positive
- Stock cannot be negative
- Category must be from predefined list
```

### Output Examples

#### **Complete API Implementation**
```javascript
// controllers/productController.js
const { Product } = require('../models');
const { validationResult } = require('express-validator');
const logger = require('../utils/logger');

class ProductController {
  // GET /api/products
  async getProducts(req, res) {
    try {
      const page = parseInt(req.query.page) || 1;
      const limit = parseInt(req.query.limit) || 10;
      const offset = (page - 1) * limit;

      const { count, rows: products } = await Product.findAndCountAll({
        limit,
        offset,
        order: [['created_at', 'DESC']]
      });

      res.json({
        products,
        pagination: {
          page,
          limit,
          total: count,
          pages: Math.ceil(count / limit)
        }
      });
    } catch (error) {
      logger.error('Error fetching products:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  }

  // GET /api/products/:id
  async getProductById(req, res) {
    try {
      const product = await Product.findByPk(req.params.id);
      
      if (!product) {
        return res.status(404).json({ error: 'Product not found' });
      }

      res.json(product);
    } catch (error) {
      logger.error('Error fetching product:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  }

  // POST /api/products
  async createProduct(req, res) {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ 
          error: 'Validation failed', 
          details: errors.array() 
        });
      }

      const product = await Product.create(req.body);
      
      logger.info(`Product created: ${product.id}`);
      res.status(201).json(product);
    } catch (error) {
      logger.error('Error creating product:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  }

  // PUT /api/products/:id
  async updateProduct(req, res) {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ 
          error: 'Validation failed', 
          details: errors.array() 
        });
      }

      const product = await Product.findByPk(req.params.id);
      
      if (!product) {
        return res.status(404).json({ error: 'Product not found' });
      }

      await product.update(req.body);
      
      logger.info(`Product updated: ${product.id}`);
      res.json(product);
    } catch (error) {
      logger.error('Error updating product:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  }

  // DELETE /api/products/:id
  async deleteProduct(req, res) {
    try {
      const product = await Product.findByPk(req.params.id);
      
      if (!product) {
        return res.status(404).json({ error: 'Product not found' });
      }

      await product.destroy();
      
      logger.info(`Product deleted: ${product.id}`);
      res.status(204).send();
    } catch (error) {
      logger.error('Error deleting product:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  }
}

module.exports = new ProductController();
```

#### **React Component Implementation**
```tsx
// components/DataTable.tsx
import React, { useState, useEffect, useMemo } from 'react';
import {
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  TablePagination,
  TextField,
  InputAdornment,
  IconButton
} from '@mui/material';
import { Search, ArrowUpward, ArrowDownward } from '@mui/icons-material';

interface Column<T> {
  id: keyof T;
  label: string;
  sortable?: boolean;
  filterable?: boolean;
  render?: (value: any, row: T) => React.ReactNode;
}

interface DataTableProps<T> {
  data: T[];
  columns: Column<T>[];
  rowsPerPage?: number;
  searchable?: boolean;
  className?: string;
}

function DataTable<T extends Record<string, any>>({
  data,
  columns,
  rowsPerPage = 10,
  searchable = true,
  className
}: DataTableProps<T>) {
  const [page, setPage] = useState(0);
  const [rowsPerPageState, setRowsPerPageState] = useState(rowsPerPage);
  const [searchTerm, setSearchTerm] = useState('');
  const [sortColumn, setSortColumn] = useState<keyof T | null>(null);
  const [sortDirection, setSortDirection] = useState<'asc' | 'desc'>('asc');

  // Filter and sort data
  const filteredAndSortedData = useMemo(() => {
    let filtered = data;

    // Apply search filter
    if (searchTerm && searchable) {
      filtered = data.filter(row =>
        columns.some(column => {
          const value = row[column.id];
          return value && 
                 value.toString().toLowerCase().includes(searchTerm.toLowerCase());
        })
      );
    }

    // Apply sorting
    if (sortColumn) {
      filtered = [...filtered].sort((a, b) => {
        const aValue = a[sortColumn];
        const bValue = b[sortColumn];
        
        if (aValue === null || aValue === undefined) return 1;
        if (bValue === null || bValue === undefined) return -1;
        
        let comparison = 0;
        if (aValue > bValue) comparison = 1;
        if (aValue < bValue) comparison = -1;
        
        return sortDirection === 'desc' ? -comparison : comparison;
      });
    }

    return filtered;
  }, [data, searchTerm, sortColumn, sortDirection, columns, searchable]);

  // Paginate data
  const paginatedData = useMemo(() => {
    const startIndex = page * rowsPerPageState;
    return filteredAndSortedData.slice(startIndex, startIndex + rowsPerPageState);
  }, [filteredAndSortedData, page, rowsPerPageState]);

  const handleSort = (column: keyof T) => {
    if (sortColumn === column) {
      setSortDirection(sortDirection === 'asc' ? 'desc' : 'asc');
    } else {
      setSortColumn(column);
      setSortDirection('asc');
    }
  };

  const handleChangePage = (event: unknown, newPage: number) => {
    setPage(newPage);
  };

  const handleChangeRowsPerPage = (event: React.ChangeEvent<HTMLInputElement>) => {
    setRowsPerPageState(parseInt(event.target.value, 10));
    setPage(0);
  };

  return (
    <Paper className={className}>
      {searchable && (
        <TextField
          fullWidth
          variant="outlined"
          placeholder="Search..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          InputProps={{
            startAdornment: (
              <InputAdornment position="start">
                <Search />
              </InputAdornment>
            ),
          }}
          sx={{ p: 2, pb: 1 }}
        />
      )}
      
      <TableContainer>
        <Table>
          <TableHead>
            <TableRow>
              {columns.map((column) => (
                <TableCell key={column.id.toString()}>
                  {column.sortable ? (
                    <IconButton
                      size="small"
                      onClick={() => handleSort(column.id)}
                      sx={{ fontWeight: 'bold' }}
                    >
                      {column.label}
                      {sortColumn === column.id && (
                        sortDirection === 'asc' ? <ArrowUpward /> : <ArrowDownward />
                      )}
                    </IconButton>
                  ) : (
                    column.label
                  )}
                </TableCell>
              ))}
            </TableRow>
          </TableHead>
          <TableBody>
            {paginatedData.map((row, index) => (
              <TableRow key={index}>
                {columns.map((column) => (
                  <TableCell key={column.id.toString()}>
                    {column.render 
                      ? column.render(row[column.id], row)
                      : row[column.id]
                    }
                  </TableCell>
                ))}
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>
      
      <TablePagination
        rowsPerPageOptions={[5, 10, 25, 50]}
        component="div"
        count={filteredAndSortedData.length}
        rowsPerPage={rowsPerPageState}
        page={page}
        onPageChange={handleChangePage}
        onRowsPerPageChange={handleChangeRowsPerPage}
      />
    </Paper>
  );
}

export default DataTable;
```

## Best Practices for Implementer Agent

### Providing Good Input

#### **✅ Good Input Examples**
```
Implement a REST API for user management with:
- CRUD operations for users
- JWT authentication
- Input validation with Joi
- Error handling middleware
- PostgreSQL database with Prisma ORM
- Unit tests with Jest
```

#### **❌ Poor Input Examples**
```
Make a user API
```

### Structuring Requirements

Use the following structure for best results:

```markdown
## Feature Description
[Clear description of what needs to be implemented]

## Functional Requirements
[List of specific features and capabilities]

## Technical Requirements
[Programming language, frameworks, libraries]

## Non-Functional Requirements
[Performance, security, scalability requirements]

## Integration Requirements
[How it should integrate with existing code]

## Testing Requirements
[What tests should be included]
```

### Reviewing Implementation Output

When reviewing the Implementer agent's output:

1. **Functionality**: Does it meet all requirements?
2. **Code Quality**: Is the code clean and maintainable?
3. **Error Handling**: Are edge cases properly handled?
4. **Security**: Are security best practices followed?
5. **Performance**: Is the code efficient?
6. **Testing**: Are adequate tests included?

## Integration with Other Agents

### Typical Workflow Sequence

1. **Architect**: Design system architecture
2. **Implementer**: Implement based on architectural design
3. **Tester**: Create comprehensive tests
4. **Reviewer**: Review code quality and architecture compliance
5. **Documenter**: Create documentation

### Handoff Patterns

#### **Implementer → Tester**
The Implementer provides:
- Complete implementation code
- Usage examples
- Test requirements documentation
- Edge case documentation

#### **Implementer → Reviewer**
The Implementer provides:
- Source code with comments
- Implementation decisions documentation
- Trade-off analysis
- Performance considerations

## Common Use Cases

### **Use Case 1: API Development**

**Input**: "Create REST API for blog post management"

**Output**:
- Express.js controller with CRUD operations
- Input validation middleware
- Error handling
- Database integration
- API documentation

### **Use Case 2: Component Development**

**Input**: "Build reusable data table component for React"

**Output**:
- TypeScript React component
- Props interface definition
- Sorting and filtering functionality
- Pagination support
- Storybook stories

### **Use Case 3: Business Logic Implementation**

**Input**: "Implement order processing logic with payment integration"

**Output**:
- Order processing service
- Payment gateway integration
- Inventory management
- Notification system
- Error handling and recovery

## Troubleshooting

### Common Issues

#### **Issue: Incomplete Requirements**
**Problem**: Missing requirements lead to incomplete implementation
**Solution**: Provide detailed specifications and examples

#### **Issue: Technology Mismatch**
**Problem**: Implementation uses different technology than expected
**Solution**: Clearly specify technology stack and preferences

#### **Issue: Missing Error Handling**
**Problem**: Code lacks proper error handling
**Solution**: Specify error handling requirements and edge cases

#### **Issue: No Tests**
**Problem**: Implementation lacks test coverage
**Solution**: Request specific testing requirements

### Getting Better Results

1. **Be Specific**: Provide detailed requirements and constraints
2. **Include Examples**: Show expected input/output formats
3. **Specify Standards**: Define coding standards and patterns to follow
4. **Request Tests**: Always ask for appropriate test coverage
5. **Provide Context**: Include information about existing codebase

## Advanced Features

### **Code Generation from OpenAPI**
```bash
# Generate API client from OpenAPI spec
opencode-setup agents execute implementer \
  --task "Generate API client from OpenAPI specification" \
  --openapi-spec api.yaml \
  --language "typescript" \
  --output src/api/
```

### **Database Migration Generation**
```bash
# Generate database migrations
opencode-setup agents execute implementer \
  --task "Create database migrations for user schema changes" \
  --database "postgresql" \
  --orm "prisma" \
  --output prisma/migrations/
```

### **Performance Optimization**
```bash
# Optimize existing code
opencode-setup agents execute implementer \
  --task "Optimize slow database queries" \
  --input src/models/user.js \
  --profile true \
  --output optimized/
```

## Summary

The Implementer agent is your expert code craftsman for:

- **Feature Development**: Building complete, working features
- **Code Quality**: Writing clean, maintainable code
- **Best Practices**: Following industry standards and patterns
- **Integration**: Ensuring code works well with existing systems

By providing detailed requirements and technical specifications, you can leverage the Implementer agent to create high-quality, production-ready code that meets your exact needs.

The key to success with the Implementer agent is providing clear, comprehensive specifications and reviewing the output to ensure it meets all your requirements and quality standards.
CHAPTER_EOF

# Chapter 7: The Tester Agent
echo "Creating Chapter 7: The Tester Agent..."
cat > "$EPUB_DIR/07-tester.md" << 'CHAPTER_EOF'
# Chapter 7: The Tester Agent

The Tester agent is your quality assurance expert, specializing in creating comprehensive test suites that ensure software reliability and maintainability. This chapter explores how to leverage the Tester agent for robust testing strategies.

## Role and Responsibilities

### Primary Focus Areas

The Tester agent excels at:

- **Test Strategy**: Designing comprehensive testing approaches
- **Test Implementation**: Writing automated tests across all levels
- **Test Coverage**: Ensuring thorough coverage of functionality
- **Quality Assurance**: Establishing quality gates and standards
- **Performance Testing**: Creating performance and load tests
- **Test Automation**: Setting up automated testing pipelines

### Core Responsibilities

1. **Test Planning**: Designing test strategies and test plans
2. **Test Implementation**: Writing unit, integration, and end-to-end tests
3. **Test Data Management**: Creating and managing test data
4. **Test Environment Setup**: Configuring test environments
5. **Regression Testing**: Ensuring new changes don't break existing functionality
6. **Test Reporting**: Creating comprehensive test reports and metrics

## When to Use the Tester Agent

### Ideal Scenarios

Use the Tester agent when:

#### **New Feature Testing**
```
Scenario: Testing a new user authentication system
Input: "Create comprehensive tests for JWT authentication with login, logout, and token refresh"
Output: Complete test suite covering authentication flows, edge cases, and security scenarios
```

#### **API Testing**
```
Scenario: Testing REST API endpoints
Input: "Create integration tests for product management API with CRUD operations"
Output: API tests covering all endpoints, error cases, and data validation
```

#### **Component Testing**
```
Scenario: Testing React components
Input: "Create unit tests for reusable data table component with sorting and filtering"
Output: Component tests covering user interactions, props validation, and edge cases
```

#### **Performance Testing**
```
Scenario: Load testing critical endpoints
Input: "Create performance tests for user registration endpoint handling 1000 concurrent users"
Output: Load tests with performance benchmarks and bottleneck identification
```

### Not Ideal For

- **Code Implementation**: Use the Implementer agent for writing production code
- **Architecture Design**: Use the Architect agent for system design
- **Bug Fixing**: Use the Debugger agent for troubleshooting
- **Code Review**: Use the Reviewer agent for quality assessment

## Tester Agent Capabilities

### Testing Types Expertise

The Tester agent has deep knowledge of:

#### **Unit Testing**
- Test structure and organization
- Mock and stub creation
- Assertion libraries
- Test doubles and fakes
- Boundary value testing
- Equivalence partitioning

#### **Integration Testing**
- API testing
- Database integration
- External service integration
- Message queue testing
- Component integration
- Service orchestration

#### **End-to-End Testing**
- User journey testing
- Cross-browser testing
- Mobile app testing
- Workflow testing
- UI automation
- Visual regression testing

#### **Performance Testing**
- Load testing
- Stress testing
- Spike testing
- Volume testing
- Scalability testing
- Performance profiling

### Testing Frameworks and Tools

#### **JavaScript/TypeScript**
- **Jest**: Popular testing framework
- **Mocha**: Flexible testing framework
- **Vitest**: Fast unit test framework
- **Cypress**: End-to-end testing
- **Playwright**: Modern E2E testing
- **Testing Library**: Component testing utilities

#### **Python**
- **Pytest**: Powerful testing framework
- **Unittest**: Built-in testing framework
- **Robot Framework**: Acceptance testing
- **Locust**: Load testing
- **Selenium**: Web automation

#### **Java**
- **JUnit**: Standard testing framework
- **TestNG**: Advanced testing framework
- **Mockito**: Mocking framework
- **Rest-Assured**: API testing
- **Selenide**: Web automation

#### **Go**
- **Testing package**: Built-in testing
- **Testify**: Assertion toolkit
- **Ginkgo**: BDD testing framework
- **Gomega**: Matcher library

### Testing Strategies and Patterns

#### **Test Pyramid**
- Unit tests (70%)
- Integration tests (20%)
- End-to-end tests (10%)

#### **Testing Patterns**
- Arrange-Act-Assert pattern
- Given-When-Then pattern
- Page Object Model
- Data-Driven Testing
- Behavior-Driven Development

#### **Quality Gates**
- Code coverage thresholds
- Performance benchmarks
- Security scanning
- Accessibility testing
- Usability testing

## Using the Tester Agent

### Basic Usage

#### **Command Line Interface**
```bash
# Basic test creation
opencode-setup agents execute tester \
  --task "Create tests for user authentication service" \
  --type "unit,integration" \
  --framework "jest"

# API testing
opencode-setup agents execute tester \
  --task "Create integration tests for product API" \
  --type "integration" \
  --framework "supertest"

# Component testing
opencode-setup agents execute tester \
  --task "Create tests for React data table component" \
  --type "unit" \
  --framework "react-testing-library"
```

#### **Interactive Mode**
```bash
# Start interactive testing session
opencode-setup agents execute tester --interactive

# Example interaction:
> What would you like to test?
I need to test the user registration API

> What type of tests?
Unit tests for validation logic and integration tests for API endpoints

> Any specific requirements?
Cover success cases, validation errors, and edge cases
```

### Advanced Usage

#### **Comprehensive Test Suite Generation**
```bash
# Create test specification
cat > test-requirements.json << EOF
{
  "feature": "user_management",
  "components": [
    {
      "name": "userController",
      "type": "unit",
      "framework": "jest",
      "coverage_target": 90
    },
    {
      "name": "userAPI",
      "type": "integration",
      "framework": "supertest",
      "endpoints": [
        "POST /api/users/register",
        "POST /api/users/login",
        "GET /api/users/profile",
        "PUT /api/users/profile"
      ]
    },
    {
      "name": "userWorkflow",
      "type": "e2e",
      "framework": "cypress",
      "scenarios": [
        "user_registration_flow",
        "login_and_profile_update",
        "password_reset_flow"
      ]
    }
  ],
  "test_data": {
    "valid_users": 10,
    "invalid_emails": 5,
    "edge_cases": ["duplicate_email", "weak_password", "missing_fields"]
  },
  "performance": {
    "load_test": true,
    "concurrent_users": 100,
    "duration": "5m"
  }
}
EOF

# Generate comprehensive test suite
opencode-setup agents execute tester \
  --spec test-requirements.json \
  --output tests/
```

#### **Test-Driven Development Support**
```bash
# Generate failing tests first
opencode-setup agents execute tester \
  --task "Create TDD tests for shopping cart functionality" \
  --tdd true \
  --output tests/cart.test.js

# Implementation will be done by Implementer agent
opencode-setup agents execute implementer \
  --task "Implement shopping cart to satisfy tests" \
  --test-driven true \
  --tests tests/cart.test.js
```

#### **Regression Test Generation**
```bash
# Analyze code changes and generate regression tests
opencode-setup agents execute tester \
  --task "Generate regression tests for recent changes" \
  --changes "git diff HEAD~1 HEAD" \
  --focus "critical_paths" \
  --output tests/regression/
```

## Input and Output Examples

### Input Examples

#### **Simple Request**
```
Create unit tests for user authentication service
```

#### **Detailed Request**
```
Create comprehensive tests for e-commerce shopping cart system:

Unit Tests:
- Cart item addition/removal
- Price calculation with discounts
- Inventory validation
- Coupon code validation

Integration Tests:
- Cart API endpoints
- Payment integration
- Inventory service integration
- User session management

E2E Tests:
- Complete shopping flow
- Multi-item cart management
- Payment processing
- Order confirmation

Requirements:
- Jest for unit tests
- Supertest for API tests
- Cypress for E2E tests
- 90% code coverage target
- Performance testing for cart operations
```

#### **API Testing Specification**
```
Create integration tests for user management API:

Endpoints to test:
POST /api/users/register
- Valid registration
- Duplicate email
- Invalid email format
- Weak password rejection
- Missing required fields

POST /api/users/login
- Valid credentials
- Invalid email
- Invalid password
- Non-existent user
- Account locked

GET /api/users/profile
- Authenticated user
- Invalid token
- Expired token

PUT /api/users/profile
- Valid update
- Invalid data
- Unauthorized access

Requirements:
- Use Supertest framework
- Test database with fixtures
- Mock external services
- Response time assertions
- Status code validation
```

### Output Examples

#### **Complete Unit Test Suite**
```javascript
// tests/services/userService.test.js
const userService = require('../../src/services/userService');
const { User } = require('../../src/models');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

// Mock dependencies
jest.mock('../../src/models');
jest.mock('bcrypt');
jest.mock('jsonwebtoken');

describe('UserService', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('registerUser', () => {
    const validUserData = {
      email: 'test@example.com',
      password: 'SecurePass123!',
      name: 'Test User'
    };

    it('should register a new user successfully', async () => {
      // Arrange
      const hashedPassword = 'hashedPassword';
      const createdUser = { id: 1, ...validUserData, password: hashedPassword };
      
      User.findOne.mockResolvedValue(null);
      bcrypt.hash.mockResolvedValue(hashedPassword);
      User.create.mockResolvedValue(createdUser);

      // Act
      const result = await userService.registerUser(validUserData);

      // Assert
      expect(User.findOne).toHaveBeenCalledWith({ 
        where: { email: validUserData.email } 
      });
      expect(bcrypt.hash).toHaveBeenCalledWith(validUserData.password, 10);
      expect(User.create).toHaveBeenCalledWith({
        ...validUserData,
        password: hashedPassword
      });
      expect(result).toEqual(createdUser);
    });

    it('should throw error if email already exists', async () => {
      // Arrange
      User.findOne.mockResolvedValue({ id: 1, email: validUserData.email });

      // Act & Assert
      await expect(userService.registerUser(validUserData))
        .rejects.toThrow('Email already exists');
    });

    it('should throw error for invalid email format', async () => {
      // Arrange
      const invalidUserData = { ...validUserData, email: 'invalid-email' };

      // Act & Assert
      await expect(userService.registerUser(invalidUserData))
        .rejects.toThrow('Invalid email format');
    });

    it('should throw error for weak password', async () => {
      // Arrange
      const weakPasswordData = { ...validUserData, password: '123' };

      // Act & Assert
      await expect(userService.registerUser(weakPasswordData))
        .rejects.toThrow('Password must be at least 8 characters long');
    });
  });

  describe('authenticateUser', () => {
    const validCredentials = {
      email: 'test@example.com',
      password: 'SecurePass123!'
    };

    it('should authenticate user with valid credentials', async () => {
      // Arrange
      const user = {
        id: 1,
        email: validCredentials.email,
        password: 'hashedPassword',
        name: 'Test User'
      };
      const token = 'jwt-token';

      User.findOne.mockResolvedValue(user);
      bcrypt.compare.mockResolvedValue(true);
      jwt.sign.mockReturnValue(token);

      // Act
      const result = await userService.authenticateUser(validCredentials);

      // Assert
      expect(User.findOne).toHaveBeenCalledWith({ 
        where: { email: validCredentials.email } 
      });
      expect(bcrypt.compare).toHaveBeenCalledWith(
        validCredentials.password, 
        user.password
      );
      expect(jwt.sign).toHaveBeenCalledWith(
        { userId: user.id, email: user.email },
        process.env.JWT_SECRET,
        { expiresIn: '24h' }
      );
      expect(result).toEqual({ user, token });
    });

    it('should throw error for non-existent user', async () => {
      // Arrange
      User.findOne.mockResolvedValue(null);

      // Act & Assert
      await expect(userService.authenticateUser(validCredentials))
        .rejects.toThrow('Invalid credentials');
    });

    it('should throw error for incorrect password', async () => {
      // Arrange
      const user = {
        id: 1,
        email: validCredentials.email,
        password: 'hashedPassword'
      };

      User.findOne.mockResolvedValue(user);
      bcrypt.compare.mockResolvedValue(false);

      // Act & Assert
      await expect(userService.authenticateUser(validCredentials))
        .rejects.toThrow('Invalid credentials');
    });
  });

  describe('getUserProfile', () => {
    const userId = 1;

    it('should return user profile for valid user ID', async () => {
      // Arrange
      const userProfile = {
        id: userId,
        email: 'test@example.com',
        name: 'Test User',
        createdAt: new Date()
      };

      User.findByPk.mockResolvedValue(userProfile);

      // Act
      const result = await userService.getUserProfile(userId);

      // Assert
      expect(User.findByPk).toHaveBeenCalledWith(userId, {
        attributes: { exclude: ['password'] }
      });
      expect(result).toEqual(userProfile);
    });

    it('should throw error for non-existent user', async () => {
      // Arrange
      User.findByPk.mockResolvedValue(null);

      // Act & Assert
      await expect(userService.getUserProfile(userId))
        .rejects.toThrow('User not found');
    });
  });
});
```

#### **API Integration Tests**
```javascript
// tests/integration/users.test.js
const request = require('supertest');
const app = require('../../src/app');
const { User } = require('../../src/models');
const { generateToken } = require('../../src/utils/auth');

describe('User API Integration Tests', () => {
  let testUser;
  let authToken;

  beforeAll(async () => {
    // Setup test database
    await User.sync({ force: true });
    
    // Create test user
    testUser = await User.create({
      email: 'test@example.com',
      password: 'hashedPassword',
      name: 'Test User'
    });
    
    authToken = generateToken(testUser.id);
  });

  afterAll(async () => {
    // Cleanup test database
    await User.drop();
  });

  describe('POST /api/users/register', () => {
    it('should register a new user', async () => {
      const newUser = {
        email: 'newuser@example.com',
        password: 'SecurePass123!',
        name: 'New User'
      };

      const response = await request(app)
        .post('/api/users/register')
        .send(newUser)
        .expect(201);

      expect(response.body).toHaveProperty('id');
      expect(response.body.email).toBe(newUser.email);
      expect(response.body.name).toBe(newUser.name);
      expect(response.body).not.toHaveProperty('password');
    });

    it('should return 400 for duplicate email', async () => {
      const duplicateUser = {
        email: testUser.email,
        password: 'SecurePass123!',
        name: 'Duplicate User'
      };

      const response = await request(app)
        .post('/api/users/register')
        .send(duplicateUser)
        .expect(400);

      expect(response.body.error).toBe('Email already exists');
    });

    it('should return 400 for invalid email format', async () => {
      const invalidUser = {
        email: 'invalid-email',
        password: 'SecurePass123!',
        name: 'Invalid User'
      };

      const response = await request(app)
        .post('/api/users/register')
        .send(invalidUser)
        .expect(400);

      expect(response.body.error).toBe('Invalid email format');
    });

    it('should return 400 for weak password', async () => {
      const weakPasswordUser = {
        email: 'weak@example.com',
        password: '123',
        name: 'Weak Password User'
      };

      const response = await request(app)
        .post('/api/users/register')
        .send(weakPasswordUser)
        .expect(400);

      expect(response.body.error).toBe('Password must be at least 8 characters long');
    });
  });

  describe('POST /api/users/login', () => {
    it('should login with valid credentials', async () => {
      const credentials = {
        email: testUser.email,
        password: 'SecurePass123!'
      };

      const response = await request(app)
        .post('/api/users/login')
        .send(credentials)
        .expect(200);

      expect(response.body).toHaveProperty('token');
      expect(response.body.user.email).toBe(testUser.email);
      expect(response.body.user).not.toHaveProperty('password');
    });

    it('should return 401 for invalid email', async () => {
      const credentials = {
        email: 'nonexistent@example.com',
        password: 'SecurePass123!'
      };

      const response = await request(app)
        .post('/api/users/login')
        .send(credentials)
        .expect(401);

      expect(response.body.error).toBe('Invalid credentials');
    });

    it('should return 401 for invalid password', async () => {
      const credentials = {
        email: testUser.email,
        password: 'wrongpassword'
      };

      const response = await request(app)
        .post('/api/users/login')
        .send(credentials)
        .expect(401);

      expect(response.body.error).toBe('Invalid credentials');
    });
  });

  describe('GET /api/users/profile', () => {
    it('should return user profile with valid token', async () => {
      const response = await request(app)
        .get('/api/users/profile')
        .set('Authorization', `Bearer ${authToken}`)
        .expect(200);

      expect(response.body.email).toBe(testUser.email);
      expect(response.body.name).toBe(testUser.name);
      expect(response.body).not.toHaveProperty('password');
    });

    it('should return 401 without token', async () => {
      const response = await request(app)
        .get('/api/users/profile')
        .expect(401);

      expect(response.body.error).toBe('Access token required');
    });

    it('should return 401 with invalid token', async () => {
      const response = await request(app)
        .get('/api/users/profile')
        .set('Authorization', 'Bearer invalid-token')
        .expect(401);

      expect(response.body.error).toBe('Invalid token');
    });
  });

  describe('PUT /api/users/profile', () => {
    it('should update user profile with valid data', async () => {
      const updateData = {
        name: 'Updated Name',
        email: 'updated@example.com'
      };

      const response = await request(app)
        .put('/api/users/profile')
        .set('Authorization', `Bearer ${authToken}`)
        .send(updateData)
        .expect(200);

      expect(response.body.name).toBe(updateData.name);
      expect(response.body.email).toBe(updateData.email);
    });

    it('should return 400 for invalid email format', async () => {
      const updateData = {
        email: 'invalid-email'
      };

      const response = await request(app)
        .put('/api/users/profile')
        .set('Authorization', `Bearer ${authToken}`)
        .send(updateData)
        .expect(400);

      expect(response.body.error).toBe('Invalid email format');
    });

    it('should return 401 without authentication', async () => {
      const updateData = {
        name: 'Updated Name'
      };

      const response = await request(app)
        .put('/api/users/profile')
        .send(updateData)
        .expect(401);

      expect(response.body.error).toBe('Access token required');
    });
  });
});
```

#### **E2E Test with Cypress**
```javascript
// cypress/e2e/user-journey.cy.js
describe('User Registration and Login Journey', () => {
  beforeEach(() => {
    // Visit the application
    cy.visit('/');
  });

  it('should complete full user registration and login flow', () => {
    const user = {
      name: 'John Doe',
      email: 'john.doe@example.com',
      password: 'SecurePass123!'
    };

    // Navigate to registration
    cy.get('[data-cy=register-button]').click();
    cy.url().should('include', '/register');

    // Fill registration form
    cy.get('[data-cy=name-input]').type(user.name);
    cy.get('[data-cy=email-input]').type(user.email);
    cy.get('[data-cy=password-input]').type(user.password);
    cy.get('[data-cy=confirm-password-input]').type(user.password);

    // Submit registration
    cy.get('[data-cy=register-submit]').click();

    // Verify successful registration
    cy.url().should('include', '/dashboard');
    cy.get('[data-cy=welcome-message]')
      .should('contain', `Welcome, ${user.name}`);

    // Logout
    cy.get('[data-cy=logout-button]').click();
    cy.url().should('include', '/login');

    // Login with new credentials
    cy.get('[data-cy=email-input]').type(user.email);
    cy.get('[data-cy=password-input]').type(user.password);
    cy.get('[data-cy=login-submit]').click();

    // Verify successful login
    cy.url().should('include', '/dashboard');
    cy.get('[data-cy=user-profile]').should('contain', user.name);
  });

  it('should handle registration validation errors', () => {
    // Try to submit empty form
    cy.get('[data-cy=register-button]').click();
    cy.get('[data-cy=register-submit]').click();

    // Verify validation errors
    cy.get('[data-cy=name-error]').should('be.visible');
    cy.get('[data-cy=email-error]').should('be.visible');
    cy.get('[data-cy=password-error]').should('be.visible');

    // Try invalid email
    cy.get('[data-cy=name-input]').type('Test User');
    cy.get('[data-cy=email-input]').type('invalid-email');
    cy.get('[data-cy=password-input]').type('password123');
    cy.get('[data-cy=confirm-password-input]').type('password123');

    cy.get('[data-cy=register-submit]').click();

    // Verify email validation error
    cy.get('[data-cy=email-error]')
      .should('contain', 'Invalid email format');
  });

  it('should handle login errors', () => {
    // Navigate to login
    cy.get('[data-cy=login-button]').click();
    cy.url().should('include', '/login');

    // Try login with invalid credentials
    cy.get('[data-cy=email-input]').type('nonexistent@example.com');
    cy.get('[data-cy=password-input]').type('wrongpassword');
    cy.get('[data-cy=login-submit]').click();

    // Verify error message
    cy.get('[data-cy=login-error]')
      .should('contain', 'Invalid credentials');
  });
});

describe('Shopping Cart Functionality', () => {
  beforeEach(() => {
    // Login before each test
    cy.visit('/login');
    cy.get('[data-cy=email-input]').type('test@example.com');
    cy.get('[data-cy=password-input]').type('password123');
    cy.get('[data-cy=login-submit]').click();
    cy.url().should('include', '/dashboard');
  });

  it('should add items to cart and complete checkout', () => {
    const products = [
      { name: 'Product 1', price: 29.99 },
      { name: 'Product 2', price: 49.99 }
    ];

    // Add products to cart
    products.forEach(product => {
      cy.visit('/products');
      cy.contains(product.name).click();
      cy.get('[data-cy=add-to-cart]').click();
      cy.get('[data-cy=cart-count]')
        .should('contain', products.indexOf(product) + 1);
    });

    // View cart
    cy.get('[data-cy=cart-button]').click();
    cy.url().should('include', '/cart');

    // Verify cart contents
    cy.get('[data-cy=cart-item]').should('have.length', 2);
    cy.get('[data-cy=cart-total]')
      .should('contain', (29.99 + 49.99).toFixed(2));

    // Proceed to checkout
    cy.get('[data-cy=checkout-button]').click();
    cy.url().should('include', '/checkout');

    // Fill checkout form
    cy.get('[data-cy=shipping-address]').type('123 Main St');
    cy.get('[data-cy=shipping-city]').type('Anytown');
    cy.get('[data-cy=shipping-zip]').type('12345');

    // Complete checkout
    cy.get('[data-cy=place-order]').click();

    // Verify order confirmation
    cy.url().should('include', '/order-confirmation');
    cy.get('[data-cy=order-success]')
      .should('contain', 'Order placed successfully');
  });
});
```

## Best Practices for Tester Agent

### Providing Good Input

#### **✅ Good Input Examples**
```
Create comprehensive tests for user authentication:
- Unit tests for validation logic
- Integration tests for API endpoints
- E2E tests for user flows
- Performance tests for login endpoint
- Target 90% code coverage
```

#### **❌ Poor Input Examples**
```
Test the user service
```

### Structuring Test Requirements

Use the following structure for best results:

```markdown
## Test Scope
[What needs to be tested]

## Test Types Required
[Unit, Integration, E2E, Performance, etc.]

## Test Requirements
[Specific test cases and scenarios]

## Framework Preferences
[Testing frameworks and tools]

## Coverage Requirements
[Code coverage targets and quality gates]

## Performance Requirements
[Performance benchmarks and load requirements]
```

### Reviewing Test Output

When reviewing the Tester agent's output:

1. **Coverage**: Does it test all important scenarios?
2. **Quality**: Are the tests well-structured and maintainable?
3. **Edge Cases**: Are edge cases properly covered?
4. **Performance**: Are performance requirements tested?
5. **Integration**: Do integration tests work properly?
6. **Data**: Is test data properly managed?

## Integration with Other Agents

### Typical Workflow Sequence

1. **Implementer**: Implement the feature/code
2. **Tester**: Create comprehensive tests
3. **Reviewer**: Review both code and tests
4. **Debugger**: Fix any failing tests
5. **Documenter**: Document testing approach

### Handoff Patterns

#### **Tester → Reviewer**
The Tester provides:
- Complete test suite
- Test coverage reports
- Performance benchmarks
- Quality metrics

#### **Tester → Debugger**
The Tester provides:
- Failing test cases
- Error logs and diagnostics
- Reproduction steps
- Expected vs actual behavior

## Common Use Cases

### **Use Case 1: API Testing**

**Input**: "Create comprehensive tests for REST API"

**Output**:
- Unit tests for business logic
- Integration tests for API endpoints
- Contract testing for API contracts
- Performance tests for critical endpoints

### **Use Case 2: Component Testing**

**Input**: "Test React component library"

**Output**:
- Component unit tests
- Accessibility tests
- Visual regression tests
- Interaction tests

### **Use Case 3: Performance Testing**

**Input**: "Load test e-commerce checkout flow"

**Output**:
- Load test scenarios
- Performance benchmarks
- Bottleneck analysis
- Scalability tests

## Troubleshooting

### Common Issues

#### **Issue: Insufficient Test Coverage**
**Problem**: Tests don't cover important scenarios
**Solution**: Specify detailed test cases and edge cases

#### **Issue: Flaky Tests**
**Problem**: Tests are unreliable and fail intermittently
**Solution**: Request proper test isolation and deterministic behavior

#### **Issue: Slow Tests**
**Problem**: Test suite takes too long to run
**Solution**: Request test optimization and parallelization

#### **Issue: Complex Test Setup**
**Problem**: Tests require complex setup and teardown
**Solution**: Request better test fixtures and utilities

### Getting Better Results

1. **Specify Test Types**: Clearly define what types of tests are needed
2. **Provide Examples**: Show expected test scenarios and edge cases
3. **Define Coverage**: Specify coverage targets and quality gates
4. **Include Performance**: Define performance requirements and benchmarks
5. **Request Automation**: Ask for CI/CD integration and automation

## Advanced Features

### **Test Coverage Analysis**
```bash
# Analyze test coverage gaps
opencode-setup agents execute tester \
  --task "Analyze test coverage gaps" \
  --source src/ \
  --tests tests/ \
  --target 90 \
  --output coverage-report.html
```

### **Performance Benchmarking**
```bash
# Create performance benchmarks
opencode-setup agents execute tester \
  --task "Create performance benchmarks for API endpoints" \
  --baseline "current_performance.json" \
  --threshold "response_time < 200ms" \
  --output benchmarks/
```

### **Test Data Generation**
```bash
# Generate realistic test data
opencode-setup agents execute tester \
  --task "Generate test data for user management" \
  --count 1000 \
  --realistic true \
  --output fixtures/users.json
```

## Summary

The Tester agent is your quality assurance expert for:

- **Comprehensive Testing**: Creating thorough test suites across all levels
- **Quality Assurance**: Establishing quality standards and gates
- **Test Automation**: Setting up automated testing pipelines
- **Performance Testing**: Ensuring system performance meets requirements

By providing detailed testing requirements and quality criteria, you can leverage the Tester agent to create robust, reliable test suites that ensure your software meets the highest quality standards.

The key to success with the Tester agent is providing clear testing requirements, specifying coverage targets, and defining quality gates that align with your project's quality standards.
CHAPTER_EOF

echo "✅ Generated agent chapters (5-7)"

# Generate remaining chapters
echo "📖 Generating remaining chapters..."

# Define additional chapters
ADDITIONAL_CHAPTERS=(
    "08-debugger.md:The Debugger Agent"
    "09-reviewer.md:The Reviewer Agent"
    "10-refactorer.md:The Refactorer Agent"
    "11-documenter.md:The Documenter Agent"
    "12-researcher.md:The Researcher Agent"
    "13-workflows.md:Workflow Orchestration"
    "14-commands.md:Command Reference"
    "15-custom-commands.md:Custom Commands"
    "16-integration.md:Integration Strategies"
    "17-performance.md:Performance Optimization"
    "18-security.md:Security Considerations"
    "19-reference.md:Quick Reference Guide"
    "20-best-practices.md:Best Practices"
    "21-troubleshooting.md:Troubleshooting"
)

# Generate each additional chapter
for chapter_info in "${ADDITIONAL_CHAPTERS[@]}"; do
    IFS=":" read -r filename title <<< "$chapter_info"
    
    echo "Creating Chapter: $title..."
    
    # Create placeholder for remaining chapters
    cat > "$EPUB_DIR/$filename" << CHAPTER_EOF
# Chapter ${title}

*This chapter is currently being written and will be available in the next release.*

## Coming Soon

This chapter will cover:

- Detailed concepts and examples
- Practical implementation guidance
- Best practices and tips
- Integration with other agents

## Preview

The ${title} chapter is part of our comprehensive guide to Open Code Agents. It will provide in-depth information about this topic to help you master the Open Code Agents ecosystem.

---

*This is a development preview. The complete chapter will be available in the final release.*
CHAPTER_EOF
    
    echo "✅ Created $filename"
done

echo "✅ Generated all chapters (1-21)"
echo "📚 EPUB content generation complete!"

