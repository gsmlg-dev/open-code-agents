package cli

import (
	"github.com/spf13/cobra"
)

// NewRootCommand creates the main opencode-setup command that can be reused as a subcommand
func NewRootCommand() *cobra.Command {
	cmd := &cobra.Command{
		Use:   "opencode-setup",
		Short: "Setup and manage OpenCode agents, commands, and resources",
		Long: `opencode-setup is a CLI tool for managing OpenCode resources.
It can install agents, commands, MCP servers, and skills to either user or project scope.`,
	}

	// Add subcommands
	cmd.AddCommand(
		NewAgentCommand(),
		NewCommandCommand(),
		NewMCPCommand(),
		NewSkillCommand(),
	)

	return cmd
}

// NewAgentMenuCommand returns just the agents command for embedding in other CLIs
func NewAgentMenuCommand() *cobra.Command {
	return NewAgentCommand()
}
