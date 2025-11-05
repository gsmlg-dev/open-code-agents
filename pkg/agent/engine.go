package agent

import (
	"context"
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/gsmlg-dev/open-code-agents/pkg/config"
	"github.com/gsmlg-dev/open-code-agents/pkg/resources"
)

// Engine handles agent execution and management
type Engine struct {
	workingDir string
	context    map[string]interface{}
}

// NewEngine creates a new agent engine
func NewEngine() *Engine {
	wd, _ := os.Getwd()
	return &Engine{
		workingDir: wd,
		context:    make(map[string]interface{}),
	}
}

// ExecuteRequest represents an agent execution request
type ExecuteRequest struct {
	AgentName string                 `json:"agent_name"`
	Input     string                 `json:"input"`
	Context   map[string]interface{} `json:"context,omitempty"`
	Tools     map[string]bool        `json:"tools,omitempty"`
}

// ExecuteResponse represents the result of agent execution
type ExecuteResponse struct {
	Output  string                 `json:"output"`
	Success bool                   `json:"success"`
	Error   string                 `json:"error,omitempty"`
	Context map[string]interface{} `json:"context,omitempty"`
	Handoff *HandoffSuggestion     `json:"handoff,omitempty"`
}

// HandoffSuggestion suggests next agent to use
type HandoffSuggestion struct {
	AgentName string            `json:"agent_name"`
	Reason    string            `json:"reason"`
	Context   map[string]string `json:"context"`
}

// Execute runs an agent with the given request
func (e *Engine) Execute(ctx context.Context, req ExecuteRequest) (*ExecuteResponse, error) {
	// Load agent configuration
	agent, err := e.loadAgent(req.AgentName)
	if err != nil {
		return &ExecuteResponse{
			Success: false,
			Error:   fmt.Sprintf("Failed to load agent: %v", err),
		}, nil
	}

	// Prepare execution context
	execCtx := e.prepareContext(req.Context)

	// Execute agent based on its type
	switch agent.Mode {
	case "primary":
		return e.executePrimaryAgent(ctx, agent, req, execCtx)
	case "subagent":
		return e.executeSubAgent(ctx, agent, req, execCtx)
	default:
		return &ExecuteResponse{
			Success: false,
			Error:   fmt.Sprintf("Unknown agent mode: %s", agent.Mode),
		}, nil
	}
}

// loadAgent loads agent from installed locations or embedded resources
func (e *Engine) loadAgent(name string) (*resources.AgentResource, error) {
	// Try to load from user scope first
	if agent, err := e.loadInstalledAgent(name, config.UserScope); err == nil {
		return &agent, nil
	}

	// Try project scope
	if agent, err := e.loadInstalledAgent(name, config.ProjectScope); err == nil {
		return &agent, nil
	}

	// Fall back to embedded resources
	agent, err := resources.GetAgent(name)
	if err != nil {
		return nil, fmt.Errorf("agent '%s' not found in any location", name)
	}

	return &agent, nil
}

// loadInstalledAgent loads agent from filesystem
func (e *Engine) loadInstalledAgent(name string, scope config.Scope) (resources.AgentResource, error) {
	agentDir, err := config.GetAgentDir(scope)
	if err != nil {
		return resources.AgentResource{}, err
	}

	agentFile := filepath.Join(agentDir, name+".md")
	content, err := os.ReadFile(agentFile)
	if err != nil {
		return resources.AgentResource{}, err
	}

	// Parse frontmatter and content
	return e.parseInstalledAgent(name, string(content))
}

// parseInstalledAgent parses installed agent file with frontmatter
func (e *Engine) parseInstalledAgent(name, content string) (resources.AgentResource, error) {
	lines := strings.Split(content, "\n")

	// Find frontmatter boundaries
	frontmatterStart := -1
	frontmatterEnd := -1

	for i, line := range lines {
		if line == "---" {
			if frontmatterStart == -1 {
				frontmatterStart = i
			} else {
				frontmatterEnd = i
				break
			}
		}
	}

	agent := resources.AgentResource{
		Name:  name,
		Tools: make(map[string]bool),
	}

	if frontmatterStart != -1 && frontmatterEnd != -1 {
		// Parse frontmatter
		frontmatter := strings.Join(lines[frontmatterStart+1:frontmatterEnd], "\n")
		e.parseFrontmatter(frontmatter, &agent)

		// Extract content after frontmatter
		agent.Content = strings.Join(lines[frontmatterEnd+1:], "\n")
	} else {
		// No frontmatter, treat entire file as content
		agent.Content = content
		agent.Mode = "subagent"
		agent.Temperature = 0.3
	}

	return agent, nil
}

// parseFrontmatter parses YAML frontmatter
func (e *Engine) parseFrontmatter(frontmatter string, agent *resources.AgentResource) {
	lines := strings.Split(frontmatter, "\n")
	for _, line := range lines {
		line = strings.TrimSpace(line)
		if line == "" {
			continue
		}

		if strings.HasPrefix(line, "description:") {
			agent.Description = strings.TrimSpace(strings.TrimPrefix(line, "description:"))
		} else if strings.HasPrefix(line, "mode:") {
			agent.Mode = strings.TrimSpace(strings.TrimPrefix(line, "mode:"))
		} else if strings.HasPrefix(line, "temperature:") {
			var temp float64
			fmt.Sscanf(strings.TrimSpace(strings.TrimPrefix(line, "temperature:")), "%f", &temp)
			agent.Temperature = temp
		} else if strings.HasPrefix(line, "tools:") {
			// Tools parsing would be more complex in real implementation
			agent.Tools["read"] = true
		}
	}
}

// prepareContext prepares execution context
func (e *Engine) prepareContext(reqContext map[string]interface{}) map[string]interface{} {
	ctx := make(map[string]interface{})

	// Copy engine context
	for k, v := range e.context {
		ctx[k] = v
	}

	// Override with request context
	for k, v := range reqContext {
		ctx[k] = v
	}

	// Add working directory
	ctx["working_dir"] = e.workingDir

	return ctx
}

// executePrimaryAgent executes a primary agent (can call other agents)
func (e *Engine) executePrimaryAgent(ctx context.Context, agent *resources.AgentResource, req ExecuteRequest, execCtx map[string]interface{}) (*ExecuteResponse, error) {
	// In a real implementation, this would:
	// 1. Set up the AI model with the agent's configuration
	// 2. Provide the agent with its tools and context
	// 3. Execute the agent's prompt with the user input
	// 4. Parse the response and handle any handoffs

	// For now, simulate execution
	output := fmt.Sprintf("Executed %s agent with input: %s\n", agent.Name, req.Input)
	output += fmt.Sprintf("Mode: %s, Temperature: %.1f\n", agent.Mode, agent.Temperature)
	output += fmt.Sprintf("Available tools: %v\n", agent.Tools)

	// Simulate potential handoff based on agent type
	var handoff *HandoffSuggestion
	switch agent.Name {
	case "architect":
		handoff = &HandoffSuggestion{
			AgentName: "implementer",
			Reason:    "Architecture complete, ready for implementation",
			Context:   map[string]string{"design": "completed"},
		}
	case "implementer":
		handoff = &HandoffSuggestion{
			AgentName: "tester",
			Reason:    "Implementation complete, needs testing",
			Context:   map[string]string{"implementation": "completed"},
		}
	}

	return &ExecuteResponse{
		Output:  output,
		Success: true,
		Context: execCtx,
		Handoff: handoff,
	}, nil
}

// executeSubAgent executes a subagent (focused task)
func (e *Engine) executeSubAgent(ctx context.Context, agent *resources.AgentResource, req ExecuteRequest, execCtx map[string]interface{}) (*ExecuteResponse, error) {
	// Similar to primary agent but without handoff capabilities
	output := fmt.Sprintf("Executed %s subagent with input: %s\n", agent.Name, req.Input)
	output += fmt.Sprintf("Mode: %s, Temperature: %.1f\n", agent.Mode, agent.Temperature)
	output += fmt.Sprintf("Available tools: %v\n", agent.Tools)

	return &ExecuteResponse{
		Output:  output,
		Success: true,
		Context: execCtx,
	}, nil
}

// ListAvailableAgents returns all available agents
func (e *Engine) ListAvailableAgents() ([]resources.AgentResource, error) {
	return resources.GetAvailableAgents()
}

// ListInstalledAgents returns all installed agents
func (e *Engine) ListInstalledAgents() (map[config.Scope][]config.AgentState, error) {
	result := make(map[config.Scope][]config.AgentState)

	userAgents, err := config.GetInstalledAgents(config.UserScope)
	if err != nil {
		return nil, fmt.Errorf("failed to get user agents: %w", err)
	}
	result[config.UserScope] = userAgents

	projectAgents, err := config.GetInstalledAgents(config.ProjectScope)
	if err != nil {
		return nil, fmt.Errorf("failed to get project agents: %w", err)
	}
	result[config.ProjectScope] = projectAgents

	return result, nil
}
