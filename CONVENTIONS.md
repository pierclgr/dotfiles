# Code, naming and documentation conventions

**PREMISE**: the following are **user preferences**, to use when no other standard is already in use and with new projects. **Always** use project's `CLAUDE.md`, `AGENTS.md` and project conventions if present.

## 1. Python preferences
- Docstring style: Google
- Coding convention: PEP8

## 2. File naming
- Default (when nothing specified): `snake_case.extension`
- Markdown: `UPPER_SNAKE_CASE.md`

## 3. Repository structure
- `docs/`: all documentation files (`.md`, `.pdf`, etc.)
- `src/`: all source code files (`.py`, etc.)
- `tests/`: all test files

## 4. Code comments
Starting letter *lowercase*, no ending period.

## 5. Git
### Branches
- `feature/snake_case`: for *feature*
- `fix/snake_case`: for *bug fixing*

### Commits
#### Message
- Use past tense (e.g. 'Added', 'Fixed', 'Modified' etc.)
- Short and compact message
- Indicate file(s) affected
- If too many changes, use only most significative

### Pull requests
#### Title
- `FEATURE: title`
- `FIX: title`
- Short and compact summarizing title

#### Description
- Short headline of problem solved/feature implemented
- Detailed list of changes done
- No test plan
- No mention to coding agents (CLAUDE, CODEX, OPENCODE etc.)
