# Python Style Configuration

A shared configuration repository for maintaining consistent Python code style across all repositories using Black, Ruff, and Pylance.

## Configuration Files

- **`pyproject.toml`** - Shared configuration for Black formatter and Ruff linter
- **`.vscode-settings.json`** - VS Code Python extension settings template
- **`tasks.json`** - VS Code tasks for running formatters and linters
- **`REPO_SETUP.sh`** - Automated setup script for each repository
- **`README_SNIPPET.md`** - Copy-paste section for individual repository READMEs

## Tools Configured

- **Black**: Opinionated code formatter (line length: 100)
- **Ruff**: Fast Python linter with isort integration
- **Pylance**: Microsoft's static analysis tool for type checking
- **Pytest**: Test framework configuration

## Installation & Setup

### Recommended: Using Git Submodules (Automated)

The easiest approach is to add `python-style-config` as a git submodule to each repository, then run the automated setup script.

**For each repository:**

```bash
# 1. Add as a git submodule
cd /path/to/repo
git submodule add https://github.com/yourusername/python-style-config python-style-config

# 2. Run the setup script
bash python-style-config/REPO_SETUP.sh
```

The `REPO_SETUP.sh` script automatically:
- ✅ Copies `pyproject.toml`, `.vscode/settings.json`, and `.vscode/tasks.json`
- ✅ Appends the Code Quality section to your existing README.md
- ✅ Creates a `.venv` virtual environment if it doesn't exist
- ✅ Installs `black`, `ruff`, `mypy`, and `pytest`

After running the script:
1. Reload VS Code: `Cmd+Shift+P` → "Developer: Reload Window"
2. Select the interpreter: `Cmd+Shift+P` → "Python: Select Interpreter" → Choose `.venv`

### Alternative: Manual Setup

If you prefer not to use submodules:

```bash
# Copy configuration files
cd /path/to/repo
cp ../python-style-config/pyproject.toml .
mkdir -p .vscode
cp ../python-style-config/.vscode-settings.json .vscode/settings.json
cp ../python-style-config/tasks.json .vscode/tasks.json
```

Then manually append the README snippet:
```bash
cat ../python-style-config/README_SNIPPET.md >> README.md
```

Then set up the virtual environment:
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install black ruff mypy pytest
```

### Install Required VS Code Extensions

```bash
# Install via VS Code or command line
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
```

## Configuration Details

### Line Length
- **Black**: 100 characters
- **Ruff**: 100 characters
- Keeps code readable while allowing slightly longer lines than PEP 8 default (79)

### Python Version Target
- **Minimum**: Python 3.8
- **Supported**: Python 3.8 - 3.11

### Ruff Rules Selected
- `E/W` - PyCodeStyle errors and warnings
- `F` - PyFlakes
- `I` - Import sorting (isort)
- `C` - Comprehension complexity
- `B` - Common bugs and design problems
- `UP` - PyUpgrade (modernize Python syntax)

### Exclusions
- `__pycache__` directories
- `.venv` and virtual environments
- `migrations` directories
- Build artifacts (`dist`, `build`)

## Usage

### Format Code
```bash
black .
```

### Lint Code
```bash
ruff check .
ruff check . --fix  # Auto-fix issues
```

### Type Checking
```bash
mypy src/
```

### Run Tests
```bash
pytest
```

## VS Code Tasks

The `tasks.json` file provides convenient shortcuts for running formatters and linters directly from VS Code. Available tasks:

- **Format Python** - Format entire workspace with Black
- **Format Python - Current File** - Format only the active file
- **Lint Python (Ruff)** - Check current file with Ruff
- **Lint Python (Ruff) - Fix** - Auto-fix current file
- **Lint All (Ruff)** - Check entire workspace
- **Lint All (Ruff) - Fix** - Auto-fix entire workspace
- **Type Check** - Run mypy on the `src/` directory

**To run a task:**
1. Press `Cmd+Shift+P` (macOS) or `Ctrl+Shift+P` (Windows/Linux)
2. Type "Run Task"
3. Select the desired task

Errors and warnings will appear in the VS Code Problems panel with line/column references.

## VS Code Auto-Formatting

With the settings configured, VS Code will automatically:
- Format Python files on save (Black)
- Check code with Ruff on save
- Run type checking in the background (Pylance)
- Organize imports on save

## Per-Repository Customization

Each repository can override settings by:

1. **Extending `pyproject.toml`**: Add tool-specific sections after copying
2. **Extending `.vscode/settings.json`**: Add additional settings to the copied file

Example: A repo with different test structure could add to `pyproject.toml`:

```toml
# In individual repo's pyproject.toml
[tool.pytest.ini_options]
testpaths = ["tests", "integration_tests"]
pythonpath = ["src"]
```

## Updating Configuration

### If Using Submodules (Recommended)

When you update the shared config in `python-style-config/`:

```bash
# From any repository using the submodule
cd /path/to/repo
git submodule update --remote python-style-config
```

Then optionally re-run the setup script to apply any new config file changes:

```bash
bash python-style-config/REPO_SETUP.sh
```

### If Using Manual Copies

For manually copied files, you'll need to:
1. Update the `python-style-config` repo
2. Manually copy files to each repository
3. Or create a script to do this across all repos

### If Using Symlinks

Changes to files in `python-style-config/` automatically apply to all repositories since they're symlinked.

## Troubleshooting

### VS Code Not Formatting
1. Ensure Python extension is installed: `code --install-extension ms-python.python`
2. Reload VS Code: `Cmd+Shift+P` → "Developer: Reload Window"
3. Check that `.vscode/settings.json` is in the repo root
4. Select the `.venv` interpreter: `Cmd+Shift+P` → "Python: Select Interpreter"

### Tools Not Found
```bash
# Activate the virtual environment and check
source .venv/bin/activate
which black  # Should show path in .venv/bin
```

If tools are missing, reinstall them:
```bash
source .venv/bin/activate
pip install black ruff mypy pytest
```

### Submodule Not Cloning
When cloning a repo that uses the submodule:
```bash
git clone --recurse-submodules https://github.com/yourusername/your-repo
# OR if already cloned
git submodule update --init --recursive
```

### Setup Script Fails
- Ensure you're running from the repo root: `pwd` should show the repo directory
- Ensure `python-style-config` exists: `ls python-style-config/pyproject.toml`
- Make it executable: `chmod +x python-style-config/REPO_SETUP.sh`

### Different Behavior Across Repos
- Ensure each repo has the same config files in `.vscode/` and repo root
- Check that `pyproject.toml` exists in the repo root
- Run `bash python-style-config/REPO_SETUP.sh` again to refresh configs

## License

This configuration is provided as-is for personal use across your projects.
