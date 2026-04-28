#!/bin/bash

# Repository Setup Script for Python Style Configuration
# Run this script in each repository after adding python-style-config as a submodule
# Usage: bash REPO_SETUP.sh (from within the repo root)

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the script's directory (should be in the submodule)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_ROOT="$(pwd)"

# Check if we're in a git repo
if [ ! -d .git ]; then
    echo -e "${RED}❌ Error: Not in a git repository root${NC}"
    exit 1
fi

# Check if the config repo exists as a submodule
if [ ! -f "$SCRIPT_DIR/pyproject.toml" ]; then
    echo -e "${RED}❌ Error: python-style-config not found at expected location${NC}"
    echo "Make sure python-style-config is added as a git submodule:"
    echo "  git submodule add https://github.com/yourusername/python-style-config python-style-config"
    exit 1
fi

echo -e "${BLUE}🐍 Setting up Python style configuration for $(basename "$REPO_ROOT")...${NC}"
echo ""

# Step 1: Copy configuration files
echo -e "${YELLOW}📋 Step 1: Copying configuration files...${NC}"

cp "$SCRIPT_DIR/pyproject.toml" "$REPO_ROOT/pyproject.toml"
echo -e "${GREEN}   ✅ Copied pyproject.toml${NC}"

mkdir -p "$REPO_ROOT/.vscode"
cp "$SCRIPT_DIR/.vscode-settings.json" "$REPO_ROOT/.vscode/settings.json"
echo -e "${GREEN}   ✅ Copied .vscode/settings.json${NC}"

cp "$SCRIPT_DIR/tasks.json" "$REPO_ROOT/.vscode/tasks.json"
echo -e "${GREEN}   ✅ Copied .vscode/tasks.json${NC}"

echo ""

# Step 2: Append README snippet
echo -e "${YELLOW}📝 Step 2: Updating README.md...${NC}"

if [ ! -f "$REPO_ROOT/README.md" ]; then
    echo -e "${YELLOW}   ⚠️  README.md not found, skipping${NC}"
else
    # Check if snippet is already in README
    if grep -q "## Code Quality" "$REPO_ROOT/README.md"; then
        echo -e "${GREEN}   ✅ Code Quality section already in README.md${NC}"
    else
        # Append the snippet
        echo "" >> "$REPO_ROOT/README.md"
        cat "$SCRIPT_DIR/README_SNIPPET.md" >> "$REPO_ROOT/README.md"
        echo -e "${GREEN}   ✅ Appended Code Quality section to README.md${NC}"
    fi
fi

echo ""

# Step 3: Create virtual environment if it doesn't exist
echo -e "${YELLOW}🔧 Step 3: Setting up Python virtual environment...${NC}"

if [ -d "$REPO_ROOT/.venv" ]; then
    echo -e "${GREEN}   ✅ Virtual environment already exists at .venv${NC}"
else
    python3 -m venv "$REPO_ROOT/.venv"
    echo -e "${GREEN}   ✅ Created virtual environment at .venv${NC}"
fi

# Activate the virtual environment
source "$REPO_ROOT/.venv/bin/activate"

# Step 4: Upgrade pip and install packages
echo -e "${YELLOW}📦 Step 4: Installing Python packages...${NC}"

pip install --upgrade pip > /dev/null 2>&1
echo -e "${GREEN}   ✅ Upgraded pip${NC}"

# Extract package versions from the submodule (if available)
PACKAGES=("black" "ruff" "mypy" "pytest")

for package in "${PACKAGES[@]}"; do
    pip install "$package" > /dev/null 2>&1
    echo -e "${GREEN}   ✅ Installed $package${NC}"
done

echo ""
echo -e "${BLUE}✨ Setup complete!${NC}"
echo ""
echo -e "${GREEN}Next steps:${NC}"
echo "1. Reload VS Code: Cmd+Shift+P → 'Developer: Reload Window'"
echo "2. Check that Python extension selects .venv:"
echo "   Cmd+Shift+P → 'Python: Select Interpreter' → Choose .venv"
echo "3. Test formatting: black --check ."
echo "4. Test linting: ruff check ."
echo ""
echo -e "${BLUE}Available VS Code tasks (Cmd+Shift+P → 'Run Task'):${NC}"
echo "  - Format Python"
echo "  - Format Python - Current File"
echo "  - Lint Python (Ruff)"
echo "  - Lint Python (Ruff) - Fix"
echo "  - Lint All (Ruff)"
echo "  - Lint All (Ruff) - Fix"
echo "  - Type Check"
