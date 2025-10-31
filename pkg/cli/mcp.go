package cli

import (
	"github.com/spf13/cobra"
)

// NewMCPCommand creates MCP servers command (placeholder for now)
func NewMCPCommand() *cobra.Command {
	cmd := &cobra.Command{
		Use:   "mcp-servers",
		Short: "Manage OpenCode MCP servers",
		Long:  "Interactive menu for managing OpenCode MCP servers (coming soon)",
		Run: func(cmd *cobra.Command, args []string) {
			cmd.Println("MCP servers management coming soon!")
		},
	}
	return cmd
}
