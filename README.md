# fav

Save your favorite commands and run them with a single word. No more typing long commands over and over.

## What it does

`fav` remembers your commonly used commands so you can run them instantly:

```bash
# Instead of typing this every time...
docker ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'

# Just type:
fav docker
```

✨ **Features**
- Save any command with `fav add`
- Run commands with tab completion
- Commands sync between your Macs via iCloud
- No configuration files to edit

## Installation

```bash
# Install with Homebrew
brew install chriopter/fav/fav

# Set up tab completion (one time only)
fav setup
```

That's it! You're ready to go.

## Usage

### Save your first command
```bash
fav add "git log --oneline --graph --all"
```

### See what you've saved
```bash
fav list
# Output:
# 1. git log --oneline --graph --all
```

### Run a saved command
```bash
# Type fav and press TAB to see all commands
fav <TAB>

# Or type the beginning and TAB to complete
fav git<TAB>

# Press enter to run
fav "git log --oneline --graph --all"
```

### Remove commands you don't need
```bash
fav remove 1
```

## Examples

Save your most-used commands:

```bash
# Docker commands
fav add "docker ps -a"
fav add "docker system prune -a"

# Git workflows  
fav add "git push origin main"
fav add "git log --oneline -10"

# System monitoring
fav add "top -o cpu"
fav add "df -h"

# Project-specific
fav add "npm run dev"
fav add "python manage.py runserver"
```

## Commands Reference

- `fav` - List all saved commands
- `fav add <command>` - Save a new command
- `fav remove <number>` - Remove a command
- `fav setup` - Configure tab completion
- `fav --help` - Show help
- `fav --version` - Show version

## Advanced

- Commands are stored in `~/Library/Mobile Documents/com~apple~CloudDocs/homebrew-fav/fav_favorites.txt`
- They sync automatically between Macs signed into the same iCloud account
- Use `man fav` for the full manual

## Development

Pushing to main automatically creates a new release. See the `.github/workflows` directory for details.

**Note:** This tool is AI-generated and should be reviewed before use in production environments.