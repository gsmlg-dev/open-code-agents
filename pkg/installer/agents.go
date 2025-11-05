package installer

import (
	"fmt"
	"os"
	"path/filepath"

	"github.com/gsmlg-dev/open-code-agents/pkg/config"
	"github.com/gsmlg-dev/open-code-agents/pkg/resources"
)

// InstallAgent installs an agent to the specified scope
func InstallAgent(agent resources.AgentResource, scope config.Scope) error {
	// Get agent directory for the scope
	agentDir, err := config.GetAgentDir(scope)
	if err != nil {
		return fmt.Errorf("failed to get agent directory: %w", err)
	}

	// Create directory if it doesn't exist
	if err := os.MkdirAll(agentDir, 0755); err != nil {
		return fmt.Errorf("failed to create agent directory: %w", err)
	}

	// Generate OpenCode format agent file
	content := generateOpenCodeAgentFile(agent)

	// Write agent file
	agentFile := filepath.Join(agentDir, agent.Name+".md")
	if err := os.WriteFile(agentFile, []byte(content), 0644); err != nil {
		return fmt.Errorf("failed to write agent file: %w", err)
	}

	return nil
}

// generateOpenCodeAgentFile converts agent resource to OpenCode format
func generateOpenCodeAgentFile(agent resources.AgentResource) string {
	// Generate tools configuration
	toolsConfig := generateToolsConfig(agent.Tools)

	// Generate frontmatter
	frontmatter := fmt.Sprintf(`---
description: %s
mode: %s
model: anthropic/claude-sonnet-4-20250514
temperature: %.1f
%s
---

`, agent.Description, agent.Mode, agent.Temperature, toolsConfig)

	return frontmatter + agent.Content
}

// generateToolsConfig creates tools configuration string
func generateToolsConfig(tools map[string]bool) string {
	if len(tools) == 0 {
		return "tools: {}"
	}

	config := "tools:\n"
	for tool, enabled := range tools {
		status := "false"
		if enabled {
			status = "true"
		}
		config += fmt.Sprintf("  %s: %s\n", tool, status)
	}

	return config
}
