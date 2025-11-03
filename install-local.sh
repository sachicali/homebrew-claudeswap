#!/usr/bin/env bash

# Local installer for claudeswap - no Homebrew tap needed
# Usage: bash install-local.sh

set -euo pipefail

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}╔══════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Claude Swap - Local Installer           ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════╝${NC}"
echo ""

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    PREFIX="/opt/homebrew"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    PREFIX="/usr/local"
else
    echo -e "${RED}Unsupported OS: $OSTYPE${NC}"
    exit 1
fi

echo -e "${GREEN}✓${NC} Detected OS: $OS"
echo ""

# Check for jq
if ! command -v jq &> /dev/null; then
    echo -e "${YELLOW}jq is required but not installed.${NC}"
    echo ""
    echo "Install jq with:"
    if [[ "$OS" == "macos" ]]; then
        echo -e "${CYAN}  brew install jq${NC}"
    else
        echo -e "${CYAN}  sudo apt-get install jq${NC}  # Ubuntu/Debian"
        echo -e "${CYAN}  sudo yum install jq${NC}      # RHEL/CentOS"
    fi
    echo ""
    read -p "Do you want to install jq now? (y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if [[ "$OS" == "macos" ]]; then
            brew install jq
        else
            sudo apt-get update && sudo apt-get install -y jq
        fi
    else
        echo "Cannot continue without jq. Exiting."
        exit 1
    fi
fi

echo -e "${GREEN}✓${NC} jq is installed"
echo ""

# Install to /usr/local/bin
BIN_DIR="/usr/local/bin"
INSTALL_PATH="$BIN_DIR/claudeswap"

echo -e "${BLUE}Installing to: $INSTALL_PATH${NC}"

# Check if running as root for system install
if [[ $EUID -ne 0 ]] && [[ ! -w "$BIN_DIR" ]]; then
    echo -e "${YELLOW}Note: May need sudo password to install to $BIN_DIR${NC}"
fi

# Copy the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_PATH="$SCRIPT_DIR/claudeswap"

if [[ ! -f "$SCRIPT_PATH" ]]; then
    echo -e "${RED}Error: claudeswap script not found in current directory${NC}"
    echo "Run this script from the directory containing claudeswap"
    exit 1
fi

# Make executable and install
chmod +x "$SCRIPT_PATH"
sudo cp "$SCRIPT_PATH" "$INSTALL_PATH"

echo -e "${GREEN}✓${NC} Installed claudeswap to $INSTALL_PATH"
echo ""

# Install zsh completion (optional)
if [[ -f "$SCRIPT_DIR/claudeswap.zsh" ]]; then
    COMPLETION_DIR="/usr/local/share/zsh/site-functions"
    sudo mkdir -p "$COMPLETION_DIR"
    sudo cp "$SCRIPT_DIR/claudeswap.zsh" "$COMPLETION_DIR/_claudeswap"
    echo -e "${GREEN}✓${NC} Installed zsh completion"
else
    echo -e "${YELLOW}⚠ zsh completion file not found, skipping${NC}"
fi

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║        Installation Complete! 🎉            ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════╝${NC}"
echo ""

# Test installation
echo -e "${BLUE}Testing installation...${NC}"
if command -v claudeswap &> /dev/null; then
    echo -e "${GREEN}✓${NC} claudeswap command is available"
    claudeswap --version 2>&1 || echo -e "${YELLOW}Note: --version flag not supported${NC}"
else
    echo -e "${RED}✗ claudeswap command not found in PATH${NC}"
fi

echo ""
echo -e "${RED}⚠️  IMPORTANT: Configure Your Credentials! ⚠️${NC}"
echo ""
echo -e "${BLUE}Before using claudeswap, you MUST set up your API credentials:${NC}"
echo ""
echo -e "${YELLOW}Step 1:${NC} Edit your shell configuration file"
echo -e "  ${CYAN}vim ~/.zshrc${NC}   (or nano, code, etc.)"
echo ""
echo -e "${YELLOW}Step 2:${NC} Add your credentials (choose the ones you have):"
echo ""
echo -e "  ${BLUE}# For Z.ai (if you have access):${NC}"
echo -e "  ${CYAN}export CLAUDE_ZAI_AUTH_TOKEN=\"your-zai-token-here\"${NC}"
echo -e "  ${CYAN}export CLAUDE_ZAI_BASE_URL=\"https://api.z.ai/api/anthropic\"${NC}"
echo ""
echo -e "  ${BLUE}# For MiniMax (if you have access):${NC}"
echo -e "  ${CYAN}export CLAUDE_MINIMAX_AUTH_TOKEN=\"your-minimax-token-here\"${NC}"
echo -e "  ${CYAN}export CLAUDE_MINIMAX_BASE_URL=\"https://api.minimax.io/anthropic\"${NC}"
echo ""
echo -e "${YELLOW}Step 3:${NC} Reload your shell"
echo -e "  ${CYAN}source ~/.zshrc${NC}"
echo ""
echo -e "${YELLOW}Step 4:${NC} Test the tool"
echo -e "  ${CYAN}claudeswap status${NC}"
echo ""
echo -e "${BLUE}Usage:${NC}"
echo -e "  ${YELLOW}claudeswap zai${NC}       - Switch to Z.ai"
echo -e "  ${YELLOW}claudeswap minimax${NC}   - Switch to MiniMax"
echo -e "  ${YELLOW}claudeswap standard${NC}  - Switch to standard Anthropic"
echo ""
echo -e "${GREEN}For help:${NC} ${CYAN}claudeswap help${NC}"
echo ""
