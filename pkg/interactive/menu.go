package interactive

import (
	"bufio"
	"fmt"
	"os"
	"strings"

	"github.com/gsmlg-dev/open-code-agents/pkg/config"
	"github.com/gsmlg-dev/open-code-agents/pkg/resources"
)

// readInput reads a line from stdin with proper buffering
func readInput() string {
	reader := bufio.NewReader(os.Stdin)
	input, _ := reader.ReadString('\n')
	return strings.TrimSpace(input)
}

// ShowAgentMenu displays the main agent management menu
func ShowAgentMenu() string {
	fmt.Println("\n=== OpenCode Agent Management ===")
	fmt.Println("1. install all")
	fmt.Println("2. select what to install")
	fmt.Println("3. view current agents")
	fmt.Println("Q. Quit")
	fmt.Print("\nSelect an option: ")

	return readInput()
}

// ShowAgentSelection displays interactive agent selection menu
func ShowAgentSelection(agents []resources.AgentResource) []string {
	fmt.Println("\n=== Select Agents to Install ===")

	for i, agent := range agents {
		status := " "
		if config.IsAgentInstalled(agent.Name) {
			status = "✓"
		}
		fmt.Printf("%d. [%s] %s - %s\n", i+1, status, agent.Name, agent.Description)
	}
	fmt.Println("A. Select All")
	fmt.Println("N. Select None")
	fmt.Println("B. Back to main menu")

	fmt.Print("\nEnter agent numbers (comma-separated) or choice: ")

	input := readInput()

	switch strings.ToUpper(input) {
	case "A":
		var allNames []string
		for _, agent := range agents {
			allNames = append(allNames, agent.Name)
		}
		return allNames
	case "N", "B":
		return []string{}
	default:
		// Parse comma-separated numbers
		var selectedNames []string
		if input != "" {
			parts := strings.Split(input, ",")
			for _, part := range parts {
				part = strings.TrimSpace(part)
				if part != "" {
					// Convert to index and get agent name
					for i, agent := range agents {
						if i+1 == parseIndex(part) {
							selectedNames = append(selectedNames, agent.Name)
							break
						}
					}
				}
			}
		}
		return selectedNames
	}
}

// parseIndex converts string to index number
func parseIndex(s string) int {
	var num int
	fmt.Sscanf(s, "%d", &num)
	return num
}

// PromptForScope prompts user to select installation scope
func PromptForScope() (config.Scope, error) {
	fmt.Println("\n=== Installation Scope ===")
	fmt.Println("1. User scope (~/.config/opencode/)")
	fmt.Println("2. Project scope (.opencode/)")
	fmt.Print("Select scope: ")

	var choice string
	fmt.Scanln(&choice)
	choice = strings.TrimSpace(choice)

	switch choice {
	case "1":
		return config.UserScope, nil
	case "2":
		return config.ProjectScope, nil
	default:
		return config.UserScope, fmt.Errorf("invalid scope selection")
	}
}

// ConfirmAgentInstallation shows installation summary and asks for confirmation
func ConfirmAgentInstallation(agents []resources.AgentResource, scope config.Scope) bool {
	fmt.Printf("\n=== Installation Summary ===\n")
	fmt.Printf("Scope: %s\n", scope)
	fmt.Printf("Agents to install: %d\n", len(agents))
	for _, agent := range agents {
		fmt.Printf("  • %s\n", agent.Name)
	}
	fmt.Print("\nContinue? (y/N): ")

	var response string
	fmt.Scanln(&response)
	response = strings.TrimSpace(strings.ToLower(response))

	return response == "y" || response == "yes"
}

// ShowProgress displays installation progress
func ShowProgress(current, total int, description string) {
	percent := float64(current) / float64(total) * 100
	fmt.Printf("\r[%d/%d] %.1f%% - %s", current, total, percent, description)
}
