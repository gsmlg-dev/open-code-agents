package cli

import (
	"fmt"

	"github.com/gsmlg-dev/open-code-agents/pkg/config"
	"github.com/gsmlg-dev/open-code-agents/pkg/installer"
	"github.com/gsmlg-dev/open-code-agents/pkg/interactive"
	"github.com/gsmlg-dev/open-code-agents/pkg/resources"
	"github.com/spf13/cobra"
)

// NewAgentCommand creates the agents command with interactive menu
func NewAgentCommand() *cobra.Command {
	cmd := &cobra.Command{
		Use:   "agents",
		Short: "Manage OpenCode agents",
		Long: `Interactive menu for managing OpenCode agents.
Options include installing all agents, selecting specific agents, or viewing current installations.`,
		Run: func(cmd *cobra.Command, args []string) {
			runAgentMenu()
		},
	}

	return cmd
}

// runAgentMenu displays the interactive agent management menu
func runAgentMenu() {
	for {
		choice := interactive.ShowAgentMenu()

		switch choice {
		case "1":
			installAllAgents()
		case "2":
			selectAgentsToInstall()
		case "3":
			viewCurrentAgents()
		case "q", "Q":
			fmt.Println("Goodbye!")
			return
		default:
			fmt.Println("Invalid choice. Please try again.")
		}
	}
}

// installAllAgents installs all available agents
func installAllAgents() {
	fmt.Println("\n=== Install All Agents ===")

	agents, err := resources.GetAvailableAgents()
	if err != nil {
		fmt.Printf("Error loading agents: %v\n", err)
		return
	}

	if len(agents) == 0 {
		fmt.Println("No agents available to install.")
		return
	}

	// Prompt for scope
	scope, err := interactive.PromptForScope()
	if err != nil {
		fmt.Printf("Error: %v\n", err)
		return
	}

	// Confirm installation
	if !interactive.ConfirmAgentInstallation(agents, scope) {
		fmt.Println("Installation cancelled.")
		return
	}

	// Install all agents
	fmt.Printf("\nInstalling %d agents to %s scope...\n", len(agents), scope)

	successCount := 0
	for i, agent := range agents {
		interactive.ShowProgress(i+1, len(agents), fmt.Sprintf("Installing %s", agent.Name))

		if err := installer.InstallAgent(agent, scope); err != nil {
			fmt.Printf("\nError installing %s: %v\n", agent.Name, err)
			continue
		}
		successCount++
	}

	fmt.Printf("\n✓ Successfully installed %d/%d agents\n", successCount, len(agents))
}

// selectAgentsToInstall shows interactive selection menu
func selectAgentsToInstall() {
	fmt.Println("\n=== Select Agents to Install ===")

	agents, err := resources.GetAvailableAgents()
	if err != nil {
		fmt.Printf("Error loading agents: %v\n", err)
		return
	}

	if len(agents) == 0 {
		fmt.Println("No agents available to install.")
		return
	}

	// Show selection menu
	selectedNames := interactive.ShowAgentSelection(agents)
	if len(selectedNames) == 0 {
		fmt.Println("No agents selected.")
		return
	}

	// Get selected agents
	var selectedAgents []resources.AgentResource
	for _, name := range selectedNames {
		if agent, err := resources.GetAgent(name); err == nil {
			selectedAgents = append(selectedAgents, agent)
		}
	}

	// Prompt for scope
	scope, err := interactive.PromptForScope()
	if err != nil {
		fmt.Printf("Error: %v\n", err)
		return
	}

	// Confirm installation
	if !interactive.ConfirmAgentInstallation(selectedAgents, scope) {
		fmt.Println("Installation cancelled.")
		return
	}

	// Install selected agents
	fmt.Printf("\nInstalling %d selected agents to %s scope...\n", len(selectedAgents), scope)

	successCount := 0
	for i, agent := range selectedAgents {
		interactive.ShowProgress(i+1, len(selectedAgents), fmt.Sprintf("Installing %s", agent.Name))

		if err := installer.InstallAgent(agent, scope); err != nil {
			fmt.Printf("\nError installing %s: %v\n", agent.Name, err)
			continue
		}
		successCount++
	}

	fmt.Printf("\n✓ Successfully installed %d/%d selected agents\n", successCount, len(selectedAgents))
}

// viewCurrentAgents displays currently installed agents
func viewCurrentAgents() {
	fmt.Println("\n=== Currently Installed Agents ===")

	userAgents, err := config.GetInstalledAgents(config.UserScope)
	if err != nil {
		fmt.Printf("Error loading user agents: %v\n", err)
	} else {
		if len(userAgents) > 0 {
			fmt.Println("\n🏠 User Scope Agents (~/.config/opencode/):")
			for _, agent := range userAgents {
				status := "✓"
				fmt.Printf("  %s %s (installed %s)\n", status, agent.Name, agent.Installed.Format("2006-01-02"))
			}
		}
	}

	projectAgents, err := config.GetInstalledAgents(config.ProjectScope)
	if err != nil {
		fmt.Printf("Error loading project agents: %v\n", err)
	} else {
		if len(projectAgents) > 0 {
			fmt.Println("\n📁 Project Scope Agents (.opencode/):")
			for _, agent := range projectAgents {
				status := "✓"
				fmt.Printf("  %s %s (installed %s)\n", status, agent.Name, agent.Installed.Format("2006-01-02"))
			}
		}
	}

	if len(userAgents) == 0 && len(projectAgents) == 0 {
		fmt.Println("No agents installed.")
		fmt.Println("Use option 1 or 2 to install agents.")
	}

	fmt.Println() // Add spacing
}
