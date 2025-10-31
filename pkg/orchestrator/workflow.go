package orchestrator

import (
	"context"
	"fmt"
	"strings"

	"github.com/gsmlg-dev/open-code-agents/pkg/agent"
)

// Workflow represents a multi-agent execution workflow
type Workflow struct {
	Name        string            `json:"name"`
	Description string            `json:"description"`
	Steps       []WorkflowStep    `json:"steps"`
	Context     map[string]string `json:"context,omitempty"`
}

// WorkflowStep represents a single step in a workflow
type WorkflowStep struct {
	AgentName string            `json:"agent_name"`
	Input     string            `json:"input"`
	Required  bool              `json:"required"` // Whether this step must succeed
	Context   map[string]string `json:"context,omitempty"`
}

// Orchestrator manages multi-agent workflows
type Orchestrator struct {
	engine *agent.Engine
}

// NewOrchestrator creates a new orchestrator
func NewOrchestrator() *Orchestrator {
	return &Orchestrator{
		engine: agent.NewEngine(),
	}
}

// ExecuteWorkflow runs a complete workflow
func (o *Orchestrator) ExecuteWorkflow(ctx context.Context, workflow Workflow) (*WorkflowResult, error) {
	result := &WorkflowResult{
		WorkflowName: workflow.Name,
		Steps:        make([]StepResult, 0, len(workflow.Steps)),
		Success:      true,
		Context:      make(map[string]interface{}),
	}

	// Initialize context
	for k, v := range workflow.Context {
		result.Context[k] = v
	}

	// Execute each step
	for i, step := range workflow.Steps {
		stepResult := o.executeStep(ctx, step, result.Context)
		result.Steps = append(result.Steps, stepResult)

		// Update context with step results
		if stepResult.Success {
			result.Context["last_output"] = stepResult.Output
			result.Context["last_agent"] = step.AgentName

			// Merge step context
			for k, v := range stepResult.Context {
				result.Context[k] = v
			}
		}

		// Stop if required step failed
		if step.Required && !stepResult.Success {
			result.Success = false
			result.Error = fmt.Sprintf("Required step %d (%s) failed: %s", i+1, step.AgentName, stepResult.Error)
			return result, nil
		}

		// Handle handoff suggestions
		if stepResult.Handoff != nil && i < len(workflow.Steps)-1 {
			// Verify handoff matches next step
			nextStep := workflow.Steps[i+1]
			if stepResult.Handoff.AgentName != nextStep.AgentName {
				// Log warning but continue
				fmt.Printf("Warning: Handoff suggested %s but next step is %s\n",
					stepResult.Handoff.AgentName, nextStep.AgentName)
			}
		}
	}

	return result, nil
}

// executeStep executes a single workflow step
func (o *Orchestrator) executeStep(ctx context.Context, step WorkflowStep, workflowCtx map[string]interface{}) StepResult {
	// Prepare input with context substitution
	input := o.substituteContext(step.Input, workflowCtx)

	// Create execution request
	req := agent.ExecuteRequest{
		AgentName: step.AgentName,
		Input:     input,
		Context:   workflowCtx,
	}

	// Execute agent
	response, err := o.engine.Execute(ctx, req)
	if err != nil {
		return StepResult{
			AgentName: step.AgentName,
			Input:     input,
			Success:   false,
			Error:     err.Error(),
		}
	}

	return StepResult{
		AgentName: step.AgentName,
		Input:     input,
		Output:    response.Output,
		Success:   response.Success,
		Error:     response.Error,
		Context:   response.Context,
		Handoff:   response.Handoff,
	}
}

// substituteContext replaces placeholders in input with context values
func (o *Orchestrator) substituteContext(input string, context map[string]interface{}) string {
	result := input

	for key, value := range context {
		placeholder := fmt.Sprintf("{{%s}}", key)
		if strValue, ok := value.(string); ok {
			result = strings.ReplaceAll(result, placeholder, strValue)
		} else {
			result = strings.ReplaceAll(result, placeholder, fmt.Sprintf("%v", value))
		}
	}

	return result
}

// WorkflowResult represents the result of a workflow execution
type WorkflowResult struct {
	WorkflowName string                 `json:"workflow_name"`
	Steps        []StepResult           `json:"steps"`
	Success      bool                   `json:"success"`
	Error        string                 `json:"error,omitempty"`
	Context      map[string]interface{} `json:"context"`
}

// StepResult represents the result of a single workflow step
type StepResult struct {
	AgentName string                   `json:"agent_name"`
	Input     string                   `json:"input"`
	Output    string                   `json:"output,omitempty"`
	Success   bool                     `json:"success"`
	Error     string                   `json:"error,omitempty"`
	Context   map[string]interface{}   `json:"context,omitempty"`
	Handoff   *agent.HandoffSuggestion `json:"handoff,omitempty"`
}

// Predefined workflows
var (
	// NewFeatureWorkflow implements the full new feature development cycle
	NewFeatureWorkflow = Workflow{
		Name:        "new-feature",
		Description: "Complete new feature development from research to documentation",
		Steps: []WorkflowStep{
			{
				AgentName: "researcher",
				Input:     "Research requirements for: {{feature_description}}",
				Required:  true,
			},
			{
				AgentName: "architect",
				Input:     "Design architecture for feature based on research: {{last_output}}",
				Required:  true,
			},
			{
				AgentName: "implementer",
				Input:     "Implement the feature according to the architecture: {{last_output}}",
				Required:  true,
			},
			{
				AgentName: "tester",
				Input:     "Create comprehensive tests for the implemented feature: {{last_output}}",
				Required:  true,
			},
			{
				AgentName: "reviewer",
				Input:     "Review the implementation and tests for quality: {{last_output}}",
				Required:  true,
			},
			{
				AgentName: "documenter",
				Input:     "Create documentation for the completed feature: {{last_output}}",
				Required:  false,
			},
		},
	}

	// BugFixWorkflow implements the bug fixing process
	BugFixWorkflow = Workflow{
		Name:        "bug-fix",
		Description: "Fix bugs from diagnosis to verification",
		Steps: []WorkflowStep{
			{
				AgentName: "debugger",
				Input:     "Debug and diagnose the issue: {{bug_description}}",
				Required:  true,
			},
			{
				AgentName: "implementer",
				Input:     "Implement fix for the diagnosed issue: {{last_output}}",
				Required:  true,
			},
			{
				AgentName: "tester",
				Input:     "Create tests to verify the fix: {{last_output}}",
				Required:  true,
			},
			{
				AgentName: "reviewer",
				Input:     "Review the fix and tests: {{last_output}}",
				Required:  true,
			},
		},
	}

	// CodeImprovementWorkflow implements code refactoring and improvement
	CodeImprovementWorkflow = Workflow{
		Name:        "code-improvement",
		Description: "Improve code quality through refactoring and optimization",
		Steps: []WorkflowStep{
			{
				AgentName: "refactorer",
				Input:     "Analyze and refactor the code for improvement: {{code_location}}",
				Required:  true,
			},
			{
				AgentName: "tester",
				Input:     "Ensure tests still pass after refactoring: {{last_output}}",
				Required:  true,
			},
			{
				AgentName: "reviewer",
				Input:     "Review the refactored code: {{last_output}}",
				Required:  true,
			},
		},
	}
)

// GetWorkflow returns a predefined workflow by name
func GetWorkflow(name string) (Workflow, error) {
	switch name {
	case "new-feature":
		return NewFeatureWorkflow, nil
	case "bug-fix":
		return BugFixWorkflow, nil
	case "code-improvement":
		return CodeImprovementWorkflow, nil
	default:
		return Workflow{}, fmt.Errorf("workflow '%s' not found", name)
	}
}

// ListWorkflows returns all available predefined workflows
func ListWorkflows() []Workflow {
	return []Workflow{
		NewFeatureWorkflow,
		BugFixWorkflow,
		CodeImprovementWorkflow,
	}
}
