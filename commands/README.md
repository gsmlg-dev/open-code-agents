# Commands

## Overview

Commands are pre-defined workflows that orchestrate multiple agents, skills, and MCP servers to accomplish common development tasks. They provide automation, consistency, and reduced cognitive overhead for recurring scenarios.

## What Are Commands?

Commands in Claude Code are executable workflows that:

- **Automate**: Chain multiple steps without manual intervention
- **Orchestrate**: Coordinate agents, skills, and external tools
- **Standardize**: Ensure consistent approaches to common tasks
- **Optimize**: Reduce back-and-forth by following proven patterns

Think of commands as "macros" for development workflows.

## Available Commands

| Command | Description | Agent Flow | When to Use |
|---------|-------------|------------|-------------|
| [/quick-implement](./quick-implement.md) | Zero-interruption implementation | Implementer → Tester | Small, well-defined tasks you want done autonomously |

## Command Registry

### Development Workflow Commands

- **[/quick-implement](./quick-implement.md)**: Rapid implementation with minimal interruption
  - Understand → Implement → Test → Commit → Report
  - Best for: Small features, bug fixes, simple refactors
  - Autonomous: Yes (no checkpoints)

### Planned Commands (Examples)

The `examples/` directory contains templates for additional commands:

- **[/research-and-design](./examples/research-and-design.md)**: Research → Architecture → Review
  - Best for: New features requiring design decisions

- **[/bug-hunt](./examples/bug-hunt.md)**: Debug → Fix → Test → Review
  - Best for: Investigating and resolving bugs

- **[/refactor-safely](./examples/refactor-safely.md)**: Analyze → Refactor → Test → Review
  - Best for: Code improvement with safety checks

## When to Use Commands

### Use Commands When:

1. **Repetitive workflows**: You find yourself following the same agent sequence repeatedly
2. **Time-sensitive tasks**: You want fast execution without manual coordination
3. **Standard scenarios**: The task fits a well-known pattern
4. **Autonomous execution**: You trust the workflow to run without intervention
5. **Learning**: You're new and want guided workflows

### Don't Use Commands When:

1. **Complex/novel tasks**: The situation is unique or experimental
2. **Exploratory work**: You're not sure what approach to take yet
3. **High-stakes changes**: Security, data migrations, or irreversible operations
4. **Need control**: You want to review each step before proceeding
5. **Custom workflows**: The task requires a non-standard agent sequence

## How Commands Work

### Command Structure

Each command defines:

1. **Name and Description**: What the command does
2. **Prerequisites**: What must be true before running
3. **Agent Flow**: Which agents execute in which order
4. **MCP Servers**: Which external tools are used
5. **Workflow Steps**: Detailed execution sequence
6. **Success Criteria**: How to know if the command succeeded
7. **Error Handling**: What to do when things go wrong

### Command Execution

When you invoke a command:

```
User: /quick-implement "Add validation to login form"
    ↓
Command parses task and context
    ↓
Agent 1 (Implementer) executes with context
    ↓
Agent 2 (Tester) receives handoff and executes
    ↓
Command completes and reports results
```

### Autonomous vs Interactive

Commands can be:

- **Autonomous**: Run start-to-finish without asking questions (e.g., `/quick-implement`)
- **Interactive**: Pause for user input at checkpoints (e.g., `/research-and-design`)
- **Hybrid**: Autonomous with optional interrupt points

## Commands and Agents

Commands orchestrate [agents](../agents/README.md) in specific sequences:

- Commands define **which agents** run
- Commands define **in what order** agents run
- Commands pass **context** between agents
- Commands enforce **quality gates** between stages

Example from `/quick-implement`:

```markdown
## Agent Flow

1. **Implementer Agent (Analysis Mode)**
   - Input: Task description
   - Output: Implementation plan

2. **Implementer Agent (Execution Mode)**
   - Input: Implementation plan
   - Output: Working code

3. **Tester Agent**
   - Input: New code
   - Output: Passing tests
```

## Commands and Skills

Commands can specify which [skills](../skills/README.md) agents should apply:

```markdown
## Required Skills

- `language/javascript` - For JavaScript implementation
- `tools/git` - For version control operations
- `core/test-generation` - For creating tests
```

This ensures agents have the right knowledge for the task.

## Commands and MCP Servers

Commands can leverage [MCP servers](../mcp-servers/README.md) for extended capabilities:

```markdown
## MCP Servers Used

- `filesystem` - For reading/writing code files
- `github` - For creating commits and PRs
- `web-search` - For researching solutions (optional)
```

## Creating Custom Commands

To create a new command:

1. **Start with the template**: Use [command template](./template.md)
2. **Define the workflow**: Map out agent sequence and steps
3. **Identify dependencies**: Note required skills and MCP servers
4. **Set boundaries**: Clearly state when to use and when NOT to use
5. **Test thoroughly**: Run through various scenarios
6. **Document examples**: Provide concrete usage examples
7. **Add to registry**: Update this README

### Command Naming Conventions

- Use kebab-case: `/command-name`
- Start with verb: `/quick-implement`, `/research-and-design`
- Be specific: `/refactor-safely` not just `/refactor`
- Keep short: Aim for 2-3 words maximum

## Command Examples

### Simple Command (Single Agent)

```markdown
# /format-code

## Description
Formats all code files in the current directory using language-specific formatters.

## Agent Flow
Implementer (Tool Execution Mode)

## Workflow
1. Detect languages in project
2. Run appropriate formatters
3. Report formatting changes
```

### Complex Command (Multiple Agents)

```markdown
# /release-prep

## Description
Prepares codebase for release: updates, tests, docs, changelog.

## Agent Flow
Refactorer → Tester → Documenter → Reviewer

## Workflow
1. Refactorer: Clean up code, remove TODOs
2. Tester: Ensure 100% test pass rate
3. Documenter: Update changelog and docs
4. Reviewer: Final quality check
```

## Best Practices

### When Using Commands

1. **Read the description**: Understand what the command does before using
2. **Check prerequisites**: Ensure requirements are met
3. **Provide clear input**: Give commands precise, actionable descriptions
4. **Trust the process**: Avoid interrupting autonomous commands
5. **Review the output**: Always check the results

### When Creating Commands

1. **Solve a real problem**: Create commands for actual recurring needs
2. **Make it autonomous**: Minimize user interaction where possible
3. **Handle errors gracefully**: Account for failure scenarios
4. **Document thoroughly**: Include examples and anti-patterns
5. **Keep it focused**: One command = one workflow
6. **Version carefully**: Breaking changes should be documented

## Troubleshooting

### Command Fails to Execute

- Check prerequisites are met
- Verify required MCP servers are configured
- Ensure you have necessary permissions
- Review command documentation for requirements

### Command Produces Unexpected Results

- Review the task description you provided
- Check if the scenario matches "when to use" criteria
- Examine intermediate outputs from agents
- Consider using manual agent workflow instead

### Command Asks Too Many Questions

- The task may be ambiguous or complex
- Consider using a more interactive workflow
- Break the task into smaller, clearer pieces
- Review "when NOT to use" section

## Examples

See [examples directory](../examples/README.md) for detailed command usage:

- [Command Integration Examples](../examples/integrations/commands-with-mcp.md)
- [Workflow Examples](../examples/workflows/)

## Additional Resources

- [Command Template](./template.md) - Template for creating new commands
- [Agents](../agents/README.md) - Understanding agent capabilities
- [Skills](../skills/README.md) - Capabilities commands can leverage
- [MCP Servers](../mcp-servers/README.md) - External tool integrations
- [Orchestration Patterns](../orchestration.md) - Agent coordination strategies
