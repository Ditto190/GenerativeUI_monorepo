#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install Playwright MCP globally
npm install -g @playwright/mcp@latest

# Run Playwright MCP with default options
playwright-mcp --help

# Save Playwright MCP session
OUTPUT_DIR="./mcp-session"
mkdir -p "$OUTPUT_DIR"
playwright-mcp --save-session --output-dir "$OUTPUT_DIR"

# Print success message
echo "Playwright MCP setup and session saved to $OUTPUT_DIR"