package cli

import (
	"bufio"
	"context"
	"fmt"
	"os"
	"strings"

	"github.com/gsmlg-dev/open-code-agents/pkg/agent"
	"github.com/gsmlg-dev/open-code-agents/pkg/orchestrator"
	"github.com/spf13/cobra"
)

// NewCommandCommand creates commands command with workflow execution
func NewCommandCommand() *cobra.Command {
	cmd := &cobra.Command{
		Use:   "commands",
		Short: "Manage OpenCode commands and workflows",
		Long:  "Interactive menu for managing OpenCode commands and executing workflows",
	}

	// Add subcommands
	cmd.AddCommand(
		NewWorkflowCommand(),
		NewExecuteCommand(),
		NewListCommand(),
	)

	return cmd
}

// NewWorkflowCommand creates workflow management command
func NewWorkflowCommand() *cobra.Command {
	cmd := &cobra.Command{
		Use:   "workflow",
		Short: "Execute predefined workflows",
		Long:  "Run predefined multi-agent workflows for common development tasks",
		Run: func(cmd *cobra.Command, args []string) {
			runWorkflowMenu()
		},
	}
	return cmd
}

// NewExecuteCommand creates direct agent execution command
func NewExecuteCommand() *cobra.Command {
	cmd := &cobra.Command{
		Use:   "execute [agent-name]",
		Short: "Execute a specific agent",
		Long:  "Execute a single agent with provided input",
		Args:  cobra.ExactArgs(1),
		Run: func(cmd *cobra.Command, args []string) {
			executeAgent(args[0])
		},
	}
	return cmd
}

// NewListCommand creates listing command
func NewListCommand() *cobra.Command {
	cmd := &cobra.Command{
		Use:   "list",
		Short: "List available agents and workflows",
		Long:  "Show all available agents and predefined workflows",
		Run: func(cmd *cobra.Command, args []string) {
			listResources()
		},
	}
	return cmd
}

// runWorkflowMenu displays workflow selection menu
func runWorkflowMenu() {
	fmt.Println("\n=== Available Workflows ===")

	workflows := orchestrator.ListWorkflows()
	for i, workflow := range workflows {
		fmt.Printf("%d. %s - %s\n", i+1, workflow.Name, workflow.Description)
	}
	fmt.Println("B. Back to main menu")

	fmt.Print("\nSelect workflow: ")
	choice := readInput()

	if strings.ToUpper(choice) == "B" {
		return
	}

	// Parse workflow selection
	var selectedWorkflow orchestrator.Workflow
	for i, workflow := range workflows {
		if i+1 == parseIndex(choice) {
			selectedWorkflow = workflow
			break
		}
	}

	if selectedWorkflow.Name == "" {
		fmt.Println("Invalid selection.")
		return
	}

	// Get workflow parameters
	fmt.Printf("\n=== %s Workflow ===\n", strings.Title(selectedWorkflow.Name))
	fmt.Println("This workflow will execute the following steps:")
	for i, step := range selectedWorkflow.Steps {
		fmt.Printf("%d. %s agent\n", i+1, step.AgentName)
	}

	fmt.Print("\nEnter workflow context (key=value, comma-separated): ")
	contextInput := readInput()

	workflowContext := make(map[string]string)
	if contextInput != "" {
		pairs := strings.Split(contextInput, ",")
		for _, pair := range pairs {
			kv := strings.SplitN(strings.TrimSpace(pair), "=", 2)
			if len(kv) == 2 {
				workflowContext[strings.TrimSpace(kv[0])] = strings.TrimSpace(kv[1])
			}
		}
	}

	// Execute workflow
	fmt.Printf("\nExecuting %s workflow...\n", selectedWorkflow.Name)
	executeWorkflow(selectedWorkflow, workflowContext)
}

// executeAgent executes a single agent
func executeAgent(agentName string) {
	fmt.Printf("\n=== Execute %s Agent ===\n", strings.Title(agentName))
	fmt.Print("Enter input for the agent: ")
	input := readInput()

	if input == "" {
		fmt.Println("No input provided.")
		return
	}

	engine := agent.NewEngine()
	req := agent.ExecuteRequest{
		AgentName: agentName,
		Input:     input,
	}

	ctx := context.Background()
	response, err := engine.Execute(ctx, req)
	if err != nil {
		fmt.Printf("Error executing agent: %v\n", err)
		return
	}

	fmt.Printf("\n--- Agent Output ---\n%s\n", response.Output)

	if response.Handoff != nil {
		fmt.Printf("\n--- Suggested Handoff ---\n")
		fmt.Printf("Next Agent: %s\n", response.Handoff.AgentName)
		fmt.Printf("Reason: %s\n", response.Handoff.Reason)
	}
}

// executeWorkflow executes a workflow with given context
func executeWorkflow(workflow orchestrator.Workflow, workflowContext map[string]string) {
	orch := orchestrator.NewOrchestrator()

	// Set workflow context
	workflow.Context = workflowContext

	ctx := context.Background()
	result, err := orch.ExecuteWorkflow(ctx, workflow)
	if err != nil {
		fmt.Printf("Error executing workflow: %v\n", err)
		return
	}

	fmt.Printf("\n--- Workflow Results ---\n")
	fmt.Printf("Workflow: %s\n", result.WorkflowName)
	fmt.Printf("Success: %t\n", result.Success)

	if result.Error != "" {
		fmt.Printf("Error: %s\n", result.Error)
	}

	fmt.Printf("\nSteps executed:\n")
	for i, step := range result.Steps {
		status := "✓"
		if !step.Success {
			status = "✗"
		}
		fmt.Printf("%d. %s %s\n", i+1, status, step.AgentName)
		if !step.Success && step.Error != "" {
			fmt.Printf("   Error: %s\n", step.Error)
		}
	}

	if result.Success {
		fmt.Printf("\n✓ Workflow completed successfully!\n")
	} else {
		fmt.Printf("\n✗ Workflow failed.\n")
	}
}

// listResources shows all available agents and workflows
func listResources() {
	fmt.Println("\n=== Available Agents ===")

	engine := agent.NewEngine()
	agents, err := engine.ListAvailableAgents()
	if err != nil {
		fmt.Printf("Error loading agents: %v\n", err)
		return
	}

	for _, agent := range agents {
		fmt.Printf("• %s - %s\n", agent.Name, agent.Description)
	}

	fmt.Println("\n=== Available Workflows ===")
	workflows := orchestrator.ListWorkflows()
	for _, workflow := range workflows {
		fmt.Printf("• %s - %s\n", workflow.Name, workflow.Description)
	}
}

// Helper functions
func readInput() string {
	reader := bufio.NewReader(os.Stdin)
	input, _ := reader.ReadString('\n')
	return strings.TrimSpace(input)
}

func parseIndex(s string) int {
	var num int
	fmt.Sscanf(s, "%d", &num)
	return num
}
