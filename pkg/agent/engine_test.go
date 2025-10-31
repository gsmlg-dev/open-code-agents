package agent

import (
	"context"
	"testing"

	"github.com/gsmlg-dev/open-code-agents/pkg/config"
)

func TestEngine_LoadAgent(t *testing.T) {
	engine := NewEngine()

	tests := []struct {
		name    string
		wantErr bool
	}{
		{"implementer", false},
		{"architect", false},
		{"nonexistent", true},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			agent, err := engine.loadAgent(tt.name)
			if (err != nil) != tt.wantErr {
				t.Errorf("Engine.loadAgent() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
			if !tt.wantErr && agent.Name != tt.name {
				t.Errorf("Engine.loadAgent() = %v, want %v", agent.Name, tt.name)
			}
		})
	}
}

func TestEngine_Execute(t *testing.T) {
	engine := NewEngine()
	ctx := context.Background()

	req := ExecuteRequest{
		AgentName: "implementer",
		Input:     "Write a simple hello world function",
	}

	resp, err := engine.Execute(ctx, req)
	if err != nil {
		t.Errorf("Engine.Execute() error = %v", err)
		return
	}

	if !resp.Success {
		t.Errorf("Engine.Execute() success = %v, want true", resp.Success)
	}

	if resp.Output == "" {
		t.Errorf("Engine.Execute() output = empty, want non-empty")
	}
}

func TestEngine_ListAvailableAgents(t *testing.T) {
	engine := NewEngine()

	agents, err := engine.ListAvailableAgents()
	if err != nil {
		t.Errorf("Engine.ListAvailableAgents() error = %v", err)
		return
	}

	if len(agents) == 0 {
		t.Errorf("Engine.ListAvailableAgents() = empty, want non-empty")
	}

	// Check for known agents
	agentNames := make(map[string]bool)
	for _, agent := range agents {
		agentNames[agent.Name] = true
	}

	knownAgents := []string{"implementer", "architect", "tester", "debugger"}
	for _, name := range knownAgents {
		if !agentNames[name] {
			t.Errorf("Engine.ListAvailableAgents() missing agent %s", name)
		}
	}
}

func TestEngine_ListInstalledAgents(t *testing.T) {
	engine := NewEngine()

	installed, err := engine.ListInstalledAgents()
	if err != nil {
		t.Errorf("Engine.ListInstalledAgents() error = %v", err)
		return
	}

	// Should have both scopes even if empty
	if _, exists := installed[config.UserScope]; !exists {
		t.Errorf("Engine.ListInstalledAgents() missing user scope")
	}

	if _, exists := installed[config.ProjectScope]; !exists {
		t.Errorf("Engine.ListInstalledAgents() missing project scope")
	}
}
