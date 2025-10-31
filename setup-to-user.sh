#!/bin/bash

# setup-to-user.sh - Install agents and commands from this repo to user's opencode config
# Usage: ./setup-to-user.sh

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Paths
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OPENCODE_CONFIG_DIR="$HOME/.config/opencode"
AGENT_DIR="$OPENCODE_CONFIG_DIR/agent"
COMMAND_DIR="$OPENCODE_CONFIG_DIR/command"
BACKUP_DIR="$OPENCODE_CONFIG_DIR/backup-$(date +%Y%m%d-%H%M%S)"

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if opencode config exists
check_opencode() {
    if [ ! -d "$OPENCODE_CONFIG_DIR" ]; then
        log_error "OpenCode config directory not found at $OPENCODE_CONFIG_DIR"
        log_info "Please install and configure OpenCode first"
        exit 1
    fi
    log_success "OpenCode config found at $OPENCODE_CONFIG_DIR"
}

# Create backup of existing config
create_backup() {
    log_info "Creating backup of existing config..."
    mkdir -p "$BACKUP_DIR"
    
    if [ -d "$AGENT_DIR" ]; then
        cp -r "$AGENT_DIR" "$BACKUP_DIR/"
        log_info "Backed up existing agents"
    fi
    
    if [ -d "$COMMAND_DIR" ]; then
        cp -r "$COMMAND_DIR" "$BACKUP_DIR/"
        log_info "Backed up existing commands"
    fi
    
    log_success "Backup created at $BACKUP_DIR"
}

# Create directories if they don't exist
create_directories() {
    log_info "Creating directories..."
    mkdir -p "$AGENT_DIR"
    mkdir -p "$COMMAND_DIR"
    log_success "Directories created/verified"
}

# Convert agent to opencode format
convert_agent() {
    local agent_file="$1"
    local agent_name=$(basename "$agent_file" .md)
    local output_file="$AGENT_DIR/${agent_name}.md"
    
    log_info "Converting agent: $agent_name"
    
    # Extract description from the Role section
    local description=$(sed -n '/## Role/,/## /p' "$agent_file" | sed '1d;$d' | tr '\n' ' ' | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//' | head -c 100)
    
    # Determine mode and tools based on agent type
    local mode="subagent"
    local temperature="0.3"
    local tools_config=""
    
    case "$agent_name" in
        "implementer")
            mode="primary"
            temperature="0.3"
            tools_config="tools:
  write: true
  edit: true
  bash: true
  read: true"
            ;;
        "architect")
            mode="primary"
            temperature="0.2"
            tools_config="tools:
  write: false
  edit: false
  bash: false
  read: true
  webfetch: true"
            ;;
        "tester")
            temperature="0.2"
            tools_config="tools:
  write: true
  edit: true
  bash: true
  read: true"
            ;;
        "debugger")
            temperature="0.1"
            tools_config="tools:
  write: true
  edit: true
  bash: true
  read: true"
            ;;
        "reviewer")
            temperature="0.1"
            tools_config="tools:
  write: false
  edit: false
  bash: false
  read: true"
            ;;
        "refactorer")
            temperature="0.2"
            tools_config="tools:
  write: true
  edit: true
  bash: false
  read: true"
            ;;
        "documenter")
            temperature="0.3"
            tools_config="tools:
  write: true
  edit: true
  bash: false
  read: true"
            ;;
        "researcher")
            temperature="0.4"
            tools_config="tools:
  write: false
  edit: false
  bash: false
  read: true
  webfetch: true"
            ;;
    esac
    
    # Create the opencode agent file
    cat > "$output_file" << EOF
---
description: $description
mode: $mode
model: anthropic/claude-sonnet-4-20250514
temperature: $temperature
$tools_config
---

$(cat "$agent_file")
EOF
    
    log_success "Created agent: $agent_name"
}

# Convert command to opencode format
convert_command() {
    local command_file="$1"
    local command_name=$(basename "$command_file" .md)
    local output_file="$COMMAND_DIR/${command_name}.md"
    
    log_info "Converting command: $command_name"
    
    # The command file already has proper frontmatter, just copy it
    cp "$command_file" "$output_file"
    
    log_success "Created command: $command_name"
}

# Install all agents
install_agents() {
    log_info "Installing agents..."
    
    for agent_file in "$REPO_DIR/agents"/*.md; do
        if [ -f "$agent_file" ] && [ "$(basename "$agent_file")" != "README.md" ]; then
            convert_agent "$agent_file"
        fi
    done
    
    log_success "All agents installed"
}

# Install all commands
install_commands() {
    log_info "Installing commands..."
    
    for command_file in "$REPO_DIR/commands"/*.md; do
        if [ -f "$command_file" ] && [ "$(basename "$command_file")" != "README.md" ]; then
            convert_command "$command_file"
        fi
    done
    
    log_success "All commands installed"
}

# Show summary
show_summary() {
    log_success "Installation complete!"
    echo
    echo "=== Summary ==="
    echo "Agents installed: $(ls -1 "$AGENT_DIR"/*.md 2>/dev/null | wc -l)"
    echo "Commands installed: $(ls -1 "$COMMAND_DIR"/*.md 2>/dev/null | wc -l)"
    echo "Backup location: $BACKUP_DIR"
    echo
    echo "=== Usage ==="
    echo "• Switch between primary agents with Tab key"
    echo "• Use @agent-name to invoke subagents"
    echo "• Use /command-name to run commands"
    echo
    echo "=== Installed Agents ==="
    for agent in "$AGENT_DIR"/*.md; do
        if [ -f "$agent" ]; then
            name=$(basename "$agent" .md)
            description=$(grep "^description:" "$agent" | cut -d' ' -f2- | head -c 60)
            echo "• $name: $description..."
        fi
    done
    echo
    echo "=== Installed Commands ==="
    for command in "$COMMAND_DIR"/*.md; do
        if [ -f "$command" ]; then
            name=$(basename "$command" .md)
            description=$(grep "^description:" "$command" | cut -d' ' -f2- | head -c 60)
            echo "• /$name: $description..."
        fi
    done
    echo
    echo "To rollback: rm -rf $AGENT_DIR $COMMAND_DIR && mv $BACKUP_DIR/* $OPENCODE_CONFIG_DIR/"
}

# Main execution
main() {
    echo "=== OpenCode Agents Setup ==="
    echo "This will install agents and commands to your OpenCode configuration"
    echo
    
    check_opencode
    create_backup
    create_directories
    install_agents
    install_commands
    show_summary
}

# Run main function
main "$@"