# Agents

## Overview

Agents are specialized AI personas designed to handle specific aspects of software development. Each agent has a well-defined role, set of responsibilities, and workflow that makes it expert in its domain.

## What Are Agents?

Agents represent different "hats" that developers wear during software development. They embody:

- **Expertise**: Deep knowledge in a specific domain (architecture, testing, debugging, etc.)
- **Focus**: Single responsibility principle - each agent does one thing well
- **Workflow**: Structured approach to completing their specialized tasks
- **Collaboration**: Ability to hand off work to other agents and provide context

## Available Agents

| Agent | Role | Primary Use Case |
|-------|------|------------------|
| [Architect](./architect.md) | System design and architecture | Designing new features, system structure, technical decisions |
| [Implementer](./implementer.md) | Code writing and feature implementation | Writing new code, implementing designs, building features |
| [Tester](./tester.md) | Test creation and validation | Writing unit/integration tests, test strategies |
| [Debugger](./debugger.md) | Bug investigation and resolution | Finding root causes, fixing bugs, troubleshooting |
| [Refactorer](./refactorer.md) | Code improvement and optimization | Improving code quality, refactoring, performance tuning |
| [Documenter](./documenter.md) | Documentation and knowledge sharing | Writing docs, API documentation, code comments |
| [Reviewer](./reviewer.md) | Code review and quality assurance | Reviewing code, ensuring quality, catching issues |
| [Researcher](./researcher.md) | Investigation and exploration | Researching libraries, patterns, technologies |

## When to Use Which Agent

### Starting a New Project or Feature
1. **Unclear requirements or technology?** → Start with **Researcher**
2. **Clear requirements, need design?** → Start with **Architect**
3. **Small, well-defined task?** → Start with **Implementer**

### Working with Existing Code
1. **Bug or error?** → Start with **Debugger**
2. **Code quality issues?** → Start with **Refactorer**
3. **Missing tests?** → Start with **Tester**
4. **Missing docs?** → Start with **Documenter**

### Quality Assurance
1. **Need code review?** → Use **Reviewer**
2. **Pre-commit check?** → Use **Reviewer** + **Tester**

## How Agents Work Together

Agents collaborate through **handoffs** - passing work and context from one agent to another. See [orchestration.md](../orchestration.md) for detailed workflow patterns.

### Common Workflows

**New Feature (Full Cycle)**
```
Researcher → Architect → Implementer → Tester → Reviewer → Documenter
```

**Bug Fix**
```
Debugger → Implementer → Tester → Reviewer
```

**Code Improvement**
```
Refactorer → Tester → Reviewer
```

**Research & Prototype**
```
Researcher → Architect → Implementer → Reviewer
```

## Agents and Skills

Agents leverage [skills](../skills/README.md) to perform their work. Skills represent reusable capabilities and knowledge domains that agents apply during their workflows.

For example:
- **Implementer** uses language skills (JavaScript, Python) and framework skills (React, Django)
- **Reviewer** uses code analysis skills and security skills
- **Tester** uses test generation skills and framework testing skills

## Agents and Commands

[Commands](../commands/README.md) orchestrate multiple agents in pre-defined workflows. Commands are useful for:
- Automating common multi-agent sequences
- Ensuring consistent workflows
- Reducing cognitive overhead

For example:
- `/quick-implement` uses Implementer → Tester sequence
- `/research-and-design` uses Researcher → Architect sequence

## Creating Custom Agents

To create a new specialized agent:

1. Use the [agent template](../templates/agents/agent-template.md)
2. Define the agent's role, responsibilities, and workflow
3. Identify required skills the agent needs
4. Create example interactions
5. Document handoff patterns with other agents
6. Add the agent to this README's table

## Best Practices

### When Using Agents

1. **Start with the right agent**: Choose the agent that matches your current task
2. **Provide context**: Give agents sufficient information to work effectively
3. **Follow handoffs**: When an agent completes its work, follow its handoff recommendations
4. **Trust specialization**: Let each agent focus on its domain of expertise
5. **Iterate when needed**: Some workflows require multiple passes (e.g., Implementer ↔ Reviewer)

### When Creating Agents

1. **Single responsibility**: Each agent should have one clear purpose
2. **Clear boundaries**: Define what the agent does and doesn't do
3. **Structured workflow**: Provide step-by-step process
4. **Integration points**: Document how the agent works with others
5. **Skill references**: List skills the agent leverages

## Examples

See the [examples directory](../examples/README.md) for complete examples of agents in action:
- [New Feature Development](../examples/workflows/new-feature-full.md)
- [Bug Fix Workflow](../examples/workflows/bug-fix-workflow.md)
- [Multi-Agent Collaboration](../examples/integrations/multi-agent-collab.md)

## Additional Resources

- [Orchestration Patterns](../orchestration.md) - Detailed agent coordination strategies
- [Skills](../skills/README.md) - Capabilities agents leverage
- [Commands](../commands/README.md) - Pre-built agent workflows
- [Getting Started](../docs/getting-started.md) - Introduction to the system
