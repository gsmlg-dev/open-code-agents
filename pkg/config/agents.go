package config

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"
	"time"
)

// Scope represents installation scope
type Scope string

const (
	UserScope    Scope = "user"
	ProjectScope Scope = "project"
)

// AgentState represents the state of an installed agent
type AgentState struct {
	Name      string    `json:"name"`
	Version   string    `json:"version"`
	Scope     Scope     `json:"scope"`
	Installed time.Time `json:"installed"`
	Path      string    `json:"path"`
}

// GetConfigPath returns the configuration path for a given scope
func GetConfigPath(scope Scope) (string, error) {
	switch scope {
	case UserScope:
		home, err := os.UserHomeDir()
		if err != nil {
			return "", fmt.Errorf("failed to get home directory: %w", err)
		}
		return filepath.Join(home, ".config", "opencode"), nil
	case ProjectScope:
		cwd, err := os.Getwd()
		if err != nil {
			return "", fmt.Errorf("failed to get current directory: %w", err)
		}
		return filepath.Join(cwd, ".opencode"), nil
	default:
		return "", fmt.Errorf("unknown scope: %s", scope)
	}
}

// GetAgentDir returns the agent directory for a given scope
func GetAgentDir(scope Scope) (string, error) {
	configPath, err := GetConfigPath(scope)
	if err != nil {
		return "", err
	}
	return filepath.Join(configPath, "agent"), nil
}

// GetInstalledAgents returns list of installed agents for a given scope
func GetInstalledAgents(scope Scope) ([]AgentState, error) {
	agentDir, err := GetAgentDir(scope)
	if err != nil {
		return nil, err
	}

	var agents []AgentState

	// Check if directory exists
	if _, err := os.Stat(agentDir); os.IsNotExist(err) {
		return agents, nil
	}

	entries, err := os.ReadDir(agentDir)
	if err != nil {
		return nil, fmt.Errorf("failed to read agent directory: %w", err)
	}

	for _, entry := range entries {
		if entry.IsDir() || filepath.Ext(entry.Name()) != ".md" {
			continue
		}

		info, err := entry.Info()
		if err != nil {
			continue
		}

		name := strings.TrimSuffix(entry.Name(), ".md")
		agents = append(agents, AgentState{
			Name:      name,
			Version:   "1.0.0",
			Scope:     scope,
			Installed: info.ModTime(),
			Path:      filepath.Join(agentDir, entry.Name()),
		})
	}

	return agents, nil
}

// IsAgentInstalled checks if an agent is installed in any scope
func IsAgentInstalled(agentName string) bool {
	userAgents, _ := GetInstalledAgents(UserScope)
	projectAgents, _ := GetInstalledAgents(ProjectScope)

	allAgents := append(userAgents, projectAgents...)
	for _, agent := range allAgents {
		if agent.Name == agentName {
			return true
		}
	}

	return false
}
