package cli

import (
	"github.com/spf13/cobra"
)

// NewSkillCommand creates skills command (placeholder for now)
func NewSkillCommand() *cobra.Command {
	cmd := &cobra.Command{
		Use:   "skills",
		Short: "Manage OpenCode skills",
		Long:  "Interactive menu for managing OpenCode skills (coming soon)",
		Run: func(cmd *cobra.Command, args []string) {
			cmd.Println("Skills management coming soon!")
		},
	}
	return cmd
}
