package resources

import (
	"embed"
	"fmt"
	"strings"
)

//go:embed embed/agents/*.md
var agentFS embed.FS

// AgentResource represents an agent definition
type AgentResource struct {
	Name        string
	Description string
	Content     string
	Mode        string // "primary" | "subagent"
	Temperature float64
	Tools       map[string]bool
}

// GetAvailableAgents returns all available agents from embedded filesystem
func GetAvailableAgents() ([]AgentResource, error) {
	var agents []AgentResource

	entries, err := agentFS.ReadDir("embed/agents")
	if err != nil {
		return nil, fmt.Errorf("failed to read agent directory: %w", err)
	}

	for _, entry := range entries {
		if entry.IsDir() || !strings.HasSuffix(entry.Name(), ".md") {
			continue
		}

		content, err := agentFS.ReadFile("embed/agents/" + entry.Name())
		if err != nil {
			continue
		}

		agent := parseAgentContent(entry.Name(), string(content))
		agents = append(agents, agent)
	}

	return agents, nil
}

// GetAgent returns a specific agent by name
func GetAgent(name string) (AgentResource, error) {
	agents, err := GetAvailableAgents()
	if err != nil {
		return AgentResource{}, err
	}

	for _, agent := range agents {
		if agent.Name == name {
			return agent, nil
		}
	}

	return AgentResource{}, fmt.Errorf("agent %s not found", name)
}

// parseAgentContent parses agent markdown content to extract metadata
func parseAgentContent(filename, content string) AgentResource {
	name := strings.TrimSuffix(filename, ".md")

	// Extract description from Role section
	description := extractDescription(content)

	// Determine agent type and default settings
	mode, temperature, tools := getAgentDefaults(name)

	return AgentResource{
		Name:        name,
		Description: description,
		Content:     content,
		Mode:        mode,
		Temperature: temperature,
		Tools:       tools,
	}
}

// extractDescription extracts description from Role section
func extractDescription(content string) string {
	lines := strings.Split(content, "\n")
	inRoleSection := false
	var description []string

	for _, line := range lines {
		if strings.HasPrefix(line, "## Role") {
			inRoleSection = true
			continue
		}
		if strings.HasPrefix(line, "## ") && inRoleSection {
			break
		}
		if inRoleSection && line != "" {
			description = append(description, strings.TrimSpace(line))
		}
	}

	if len(description) > 0 {
		result := strings.Join(description, " ")
		if len(result) > 100 {
			return result[:97] + "..."
		}
		return result
	}

	return "Agent for software development tasks"
}

// getAgentDefaults returns default configuration for known agents
func getAgentDefaults(name string) (mode string, temperature float64, tools map[string]bool) {
	tools = make(map[string]bool)

	switch name {
	case "implementer":
		mode = "primary"
		temperature = 0.3
		tools["write"] = true
		tools["edit"] = true
		tools["bash"] = true
		tools["read"] = true
	case "architect":
		mode = "primary"
		temperature = 0.2
		tools["write"] = false
		tools["edit"] = false
		tools["bash"] = false
		tools["read"] = true
		tools["webfetch"] = true
	case "tester":
		mode = "subagent"
		temperature = 0.2
		tools["write"] = true
		tools["edit"] = true
		tools["bash"] = true
		tools["read"] = true
	case "debugger":
		mode = "subagent"
		temperature = 0.1
		tools["write"] = true
		tools["edit"] = true
		tools["bash"] = true
		tools["read"] = true
	case "reviewer":
		mode = "subagent"
		temperature = 0.1
		tools["write"] = false
		tools["edit"] = false
		tools["bash"] = false
		tools["read"] = true
	case "refactorer":
		mode = "subagent"
		temperature = 0.2
		tools["write"] = true
		tools["edit"] = true
		tools["bash"] = false
		tools["read"] = true
	case "documenter":
		mode = "subagent"
		temperature = 0.3
		tools["write"] = true
		tools["edit"] = true
		tools["bash"] = false
		tools["read"] = true
	case "researcher":
		mode = "subagent"
		temperature = 0.4
		tools["write"] = false
		tools["edit"] = false
		tools["bash"] = false
		tools["read"] = true
		tools["webfetch"] = true
	default:
		mode = "subagent"
		temperature = 0.3
		tools["read"] = true
	}

	return mode, temperature, tools
}
