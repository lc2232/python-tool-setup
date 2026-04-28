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

- **Format Python** - Format the current file or entire workspace with Black
- **Lint Python (Ruff)** - Check the current file with Ruff
- **Lint Python (Ruff) - Fix** - Auto-fix linting issues in current file
- **Lint All (Ruff)** - Check entire workspace with Ruff
- **Type Check** - Run type checking on the workspace

### Pre-commit Hooks (Optional)

To automatically format and lint before commits, install pre-commit:

```bash
pip install pre-commit
pre-commit install
```

Then add a `.pre-commit-config.yaml` to your repo root:

```yaml
repos:
  - repo: https://github.com/psf/black
    rev: 24.1.1
    hooks:
      - id: black
        language_version: python3

  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.2.0
    hooks:
      - id: ruff
        args: [--fix]
      - id: ruff-format
```

### Configuration

The linting configuration is defined in `pyproject.toml`. Key settings:

- **Line length**: 100 characters
- **Python target**: 3.8+
- **Ruff rules**: E, W, F, I, C, B, UP

For more details, see the configuration repository documentation.
