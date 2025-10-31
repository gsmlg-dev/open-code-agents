package orchestrator

import (
	"context"
	"testing"
)

func TestGetWorkflow(t *testing.T) {
	tests := []struct {
		name    string
		wantErr bool
	}{
		{"new-feature", false},
		{"bug-fix", false},
		{"code-improvement", false},
		{"nonexistent", true},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			_, err := GetWorkflow(tt.name)
			if (err != nil) != tt.wantErr {
				t.Errorf("GetWorkflow() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
		})
	}
}

func TestOrchestrator_ExecuteWorkflow(t *testing.T) {
	orch := NewOrchestrator()
	ctx := context.Background()

	// Test with a simple workflow
	workflow := Workflow{
		Name:        "test-workflow",
		Description: "Test workflow for unit testing",
		Steps: []WorkflowStep{
			{
				AgentName: "implementer",
				Input:     "Write a test function",
				Required:  true,
			},
		},
		Context: map[string]string{
			"test": "true",
		},
	}

	result, err := orch.ExecuteWorkflow(ctx, workflow)
	if err != nil {
		t.Errorf("Orchestrator.ExecuteWorkflow() error = %v", err)
		return
	}

	if !result.Success {
		t.Errorf("Orchestrator.ExecuteWorkflow() success = %v, want true", result.Success)
	}

	if len(result.Steps) != 1 {
		t.Errorf("Orchestrator.ExecuteWorkflow() steps = %v, want 1", len(result.Steps))
	}

	step := result.Steps[0]
	if step.AgentName != "implementer" {
		t.Errorf("Step agent name = %v, want implementer", step.AgentName)
	}

	if !step.Success {
		t.Errorf("Step success = %v, want true", step.Success)
	}
}

func TestSubstituteContext(t *testing.T) {
	orch := NewOrchestrator()

	tests := []struct {
		name     string
		input    string
		context  map[string]interface{}
		expected string
	}{
		{
			name:     "simple substitution",
			input:    "Hello {{name}}",
			context:  map[string]interface{}{"name": "World"},
			expected: "Hello World",
		},
		{
			name:     "multiple substitutions",
			input:    "{{greeting}} {{name}}!",
			context:  map[string]interface{}{"greeting": "Hello", "name": "World"},
			expected: "Hello World!",
		},
		{
			name:     "no substitution",
			input:    "Hello World",
			context:  map[string]interface{}{},
			expected: "Hello World",
		},
		{
			name:     "missing context",
			input:    "Hello {{name}}",
			context:  map[string]interface{}{},
			expected: "Hello {{name}}",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			result := orch.substituteContext(tt.input, tt.context)
			if result != tt.expected {
				t.Errorf("substituteContext() = %v, want %v", result, tt.expected)
			}
		})
	}
}
