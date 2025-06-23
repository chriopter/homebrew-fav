# fav

A bash favorite command tool for macOS.

## Installation

```bash
brew install chriopter/fav/fav
```

### Enable Tab Completion

For **zsh** (default on macOS):
```bash
# Add to your ~/.zshrc
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit
fi
```

For **bash**:
```bash
# Add to your ~/.bash_profile or ~/.bashrc
if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  fi
fi
```

After adding the above, restart your terminal or run `source ~/.zshrc` (or `source ~/.bash_profile` for bash).

## Usage

### Add a favorite command
```bash
fav add "git status --porcelain"
fav add docker ps -a    # quotes optional for simple commands
```

### List all favorites
```bash
fav
# or
fav list
```

### Execute a favorite command
```bash
# Use tab completion to see available commands
fav <TAB>

# Execute exact command
fav "git status --porcelain"
```

### Remove a command
```bash
fav remove 2    # removes the second command
```

### Other commands
```bash
fav --help      # Show help
fav --version   # Show version
man fav         # View manual page
```

## Features

- **iCloud Sync**: Favorites are stored in iCloud Drive and sync between your Macs
- **Tab Completion**: Press TAB to see and complete favorite commands
- **Safe Execution**: Only exact matches are executed (no fuzzy matching)
- **Simple Management**: Add, list, and remove commands easily

## Development

Pushing to the main branch automatically triggers a release workflow. The workflow increments the version number, creates a GitHub release using your commit message as the description, and updates the Homebrew formula. This makes releasing new versions as simple as pushing to main with a meaningful commit message.

**Caution:** This code is AI-generated and should be reviewed before use in production environments.