## Code Quality

This project follows a consistent Python style using Black, Ruff, and Pylance. The configuration is managed through `pyproject.toml` and `.vscode/settings.json`.

### Running Linters & Formatters

**Format code with Black:**
```bash
black .
```

**Check code with Ruff:**
```bash
ruff check .
ruff check . --fix  # Auto-fix issues
```

**Type checking with Mypy:**
```bash
mypy src/
```

**VS Code Tasks:**

You can also run linting tasks directly from VS Code using the Command Palette (`Cmd+Shift+P`):

1: Type "Tasks: Run Task" and press Enter
2: Then you should see a list of all available tasks:

- **Format Python** - Format the current file or entire workspace with Black
- **Lint Python (Ruff)** - Check the current file with Ruff
- **Lint Python (Ruff) - Fix** - Auto-fix linting issues in current file
- **Lint All (Ruff)** - Check entire workspace with Ruff
- **Type Check** - Run type checking on the workspace

### Pre-commit Hooks (Optional)

To automatically format and lint before commits, the setup includes a `.pre-commit-config.yaml` file. To activate it:

```bash
pip install pre-commit
pre-commit install
```

Then pre-commit will automatically run Black, Ruff, and Mypy checks before each commit. You can also run it manually:

```bash
pre-commit run --all-files  # Check all files
pre-commit run              # Check staged files
```

The pre-commit configuration includes:
- **Black** - Auto-formats Python code
- **Ruff** - Checks and fixes linting issues
- **Mypy** - Performs type checking

### Configuration

The linting configuration is defined in `pyproject.toml`. Key settings:

- **Line length**: 100 characters
- **Python target**: 3.11+
- **Ruff rules**: E, W, F, I, C, B, UP

For more details, see the configuration repository documentation.
