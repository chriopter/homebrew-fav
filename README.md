# fav

A bash favorite command tool for macOS.

## Installation

```bash
brew install chriopter/fav/fav
fav setup  # Configure tab completion
```

That's it! The `fav setup` command will automatically detect your shell and configure tab completion.

### Manual Setup (Optional)

If you prefer to set up completion manually, or if `fav setup` doesn't work for your configuration:

<details>
<summary>For zsh (default on macOS)</summary>

```bash
# Add to your ~/.zshrc
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit
fi
```
</details>

<details>
<summary>For bash</summary>

```bash
# Add to your ~/.bash_profile or ~/.bashrc
if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  fi
fi
```
</details>

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