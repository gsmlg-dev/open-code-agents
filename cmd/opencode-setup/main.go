package main

import (
	"os"

	"github.com/gsmlg-dev/open-code-agents/pkg/cli"
)

func main() {
	rootCmd := cli.NewRootCommand()

	if err := rootCmd.Execute(); err != nil {
		os.Exit(1)
	}
}
