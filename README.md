# fav

Save and autocomplete your favorite commands.

Just "fav add top" to add and "fav t.." to complete.

Sync via iCloud Drive.

## What it does

`fav` gives you instant tab completion for your most-used commands:

```bash
# Save a complex command once
fav add "docker ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'"

# Later, just type and press TAB to autocomplete
fav doc<TAB>
# Autocompletes to: fav "docker ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'"

# Press ENTER to run
```

✨ **Features**
- **Tab completion** for all your saved commands
- **Full commands** - not abbreviations or aliases
- **iCloud sync** - your favorites work on all your Macs
- **Zero config** - just save and use

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

### Use tab completion to run commands
```bash
# Press TAB to see all your saved commands
fav <TAB>

# Or type the first few letters and TAB to autocomplete
fav git<TAB>
# Autocompletes to: fav "git log --oneline --graph --all"

# Press ENTER to execute the full command
```

### Remove commands you don't need
```bash
fav remove 1
```

## Examples

Think of `fav` as your personal command palette with tab completion:

```bash
# Save complex Docker commands
fav add "docker ps -a --format 'table {{.Names}}\t{{.Status}}'"
fav add "docker system prune -a --volumes"

# Save Git workflows you use daily
fav add "git push origin main"
fav add "git log --oneline --graph --all -20"

# Save project-specific commands
fav add "npm run dev -- --host 0.0.0.0"
fav add "python manage.py runserver 0.0.0.0:8000"
```

Now when you type `fav doc<TAB>`, you'll see both Docker commands. Pick one and press ENTER to run the full command.

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