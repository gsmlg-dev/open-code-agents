package config

import (
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
)

// Config represents the application configuration
type Config struct {
	DefaultAgent string            `json:"default_agent,omitempty"`
	Workflows    map[string]string `json:"workflows,omitempty"`
	Settings     Settings          `json:"settings"`
}

// Settings contains application-wide settings
type Settings struct {
	LogLevel   string `json:"log_level"`
	AutoSave   bool   `json:"auto_save"`
	ShowHints  bool   `json:"show_hints"`
	MaxHistory int    `json:"max_history"`
}

// DefaultConfig returns a default configuration
func DefaultConfig() *Config {
	return &Config{
		Workflows: make(map[string]string),
		Settings: Settings{
			LogLevel:   "info",
			AutoSave:   true,
			ShowHints:  true,
			MaxHistory: 100,
		},
	}
}

// LoadConfig loads configuration from file
func LoadConfig(scope Scope) (*Config, error) {
	configPath, err := getConfigFilePath(scope)
	if err != nil {
		return nil, err
	}

	// If config doesn't exist, return default
	if _, err := os.Stat(configPath); os.IsNotExist(err) {
		return DefaultConfig(), nil
	}

	data, err := os.ReadFile(configPath)
	if err != nil {
		return nil, fmt.Errorf("failed to read config file: %w", err)
	}

	var config Config
	if err := json.Unmarshal(data, &config); err != nil {
		return nil, fmt.Errorf("failed to parse config file: %w", err)
	}

	// Ensure workflows map exists
	if config.Workflows == nil {
		config.Workflows = make(map[string]string)
	}

	return &config, nil
}

// SaveConfig saves configuration to file
func SaveConfig(config *Config, scope Scope) error {
	configPath, err := getConfigFilePath(scope)
	if err != nil {
		return err
	}

	// Ensure directory exists
	dir := filepath.Dir(configPath)
	if err := os.MkdirAll(dir, 0755); err != nil {
		return fmt.Errorf("failed to create config directory: %w", err)
	}

	data, err := json.MarshalIndent(config, "", "  ")
	if err != nil {
		return fmt.Errorf("failed to marshal config: %w", err)
	}

	if err := os.WriteFile(configPath, data, 0644); err != nil {
		return fmt.Errorf("failed to write config file: %w", err)
	}

	return nil
}

// getConfigFilePath returns the path to the config file for a given scope
func getConfigFilePath(scope Scope) (string, error) {
	configPath, err := GetConfigPath(scope)
	if err != nil {
		return "", err
	}
	return filepath.Join(configPath, "config.json"), nil
}

// UpdateConfig updates specific configuration values
func UpdateConfig(scope Scope, updates func(*Config)) error {
	config, err := LoadConfig(scope)
	if err != nil {
		return err
	}

	updates(config)

	return SaveConfig(config, scope)
}
