# Open Code Agents

A CLI tool for managing specialized AI agents that automate software development workflows. This project provides a structured way to orchestrate different AI personas (Architect, Implementer, Tester, etc.) for various development tasks.

## Features

- **Agent Management**: Install and manage specialized AI agents
- **Workflow Orchestration**: Execute multi-agent workflows for common development tasks
- **Interactive CLI**: User-friendly command-line interface
- **Scope-based Installation**: User-wide or project-specific agent installations
- **Configuration Management**: Persistent settings and preferences

## Quick Start

### Installation

```bash
# Build from source
go build ./cmd/opencode-setup

# Or use the provided binary
./opencode-setup
```

### Basic Usage

```bash
# List available agents and workflows
./opencode-setup commands list

# Execute a specific agent
./opencode-setup commands execute implementer

# Run a predefined workflow
./opencode-setup commands workflow

# Interactive agent management
./opencode-setup agents
```

## Available Agents

| Agent | Role | Description |
|-------|------|-------------|
| **Architect** | System Design | High-level architectural planning and design decisions |
| **Implementer** | Code Development | Writes production-quality code based on specifications |
| **Tester** | Quality Assurance | Creates comprehensive test suites |
| **Debugger** | Issue Resolution | Analyzes and fixes bugs in code |
| **Reviewer** | Code Review | Evaluates code quality and adherence to standards |
| **Refactorer** | Code Improvement | Improves code structure and maintainability |
| **Documenter** | Documentation | Creates comprehensive documentation |
| **Researcher** | Investigation | Researches technologies and solutions |

## Predefined Workflows

### New Feature Development
```bash
./opencode-setup commands workflow
# Select "new-feature"
# Provide context: feature_description="Add user authentication"
```
**Sequence**: Researcher → Architect → Implementer → Tester → Reviewer → Documenter

### Bug Fix
```bash
./opencode-setup commands workflow
# Select "bug-fix"
# Provide context: bug_description="Login fails with valid credentials"
```
**Sequence**: Debugger → Implementer → Tester → Reviewer

### Code Improvement
```bash
./opencode-setup commands workflow
# Select "code-improvement"
# Provide context: code_location="src/auth/"
```
**Sequence**: Refactorer → Tester → Reviewer

## Installation Scopes

### User Scope
- Location: `~/.config/opencode/`
- Available to all projects
- Ideal for commonly used agents

### Project Scope
- Location: `.opencode/` in project root
- Project-specific agents and configurations
- Version controlled with project

## Configuration

Configuration is stored in JSON format at:
- User: `~/.config/opencode/config.json`
- Project: `.opencode/config.json`

Example configuration:
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

## Development

### Project Structure
```
├── cmd/opencode-setup/     # Main CLI application
├── pkg/
│   ├── agent/              # Agent execution engine
│   ├── cli/                # CLI commands and menus
│   ├── config/             # Configuration management
│   ├── installer/          # Agent installation system
│   ├── interactive/        # Interactive UI components
│   ├── orchestrator/       # Workflow orchestration
│   └── resources/          # Embedded agent definitions
├── agents/                 # Agent definition files
└── embed/                  # Embedded resources
```

### Building and Testing

```bash
# Build the application
go build ./cmd/opencode-setup

# Run tests
go test ./...

# Run specific package tests
go test ./pkg/agent
go test ./pkg/orchestrator
```

### Adding New Agents

1. Create agent definition in `agents/` directory
2. Follow the established template format
3. Include role, responsibilities, workflow sections
4. Update agent resource parsing if needed
5. Add tests for the new agent

### Creating Custom Workflows

```go
// Define workflow in pkg/orchestrator/workflow.go
customWorkflow := orchestrator.Workflow{
    Name:        "custom-workflow",
    Description: "Custom workflow for specific needs",
    Steps: []orchestrator.WorkflowStep{
        {
            AgentName: "researcher",
            Input:     "Research {{topic}}",
            Required:  true,
        },
        {
            AgentName: "implementer", 
            Input:     "Implement based on research: {{last_output}}",
            Required:  true,
        },
    },
}
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## License

This project is open source. See LICENSE file for details.

## Support

For issues and questions:
- Check the documentation
- Review existing issues
- Create new issue with detailed description