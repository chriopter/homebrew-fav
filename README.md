# fav

Save your favorite commands once. Run them with tab completion forever.

Remember that Docker command with all the formatting flags? Or that Git log with the perfect options? Save them with `fav` and never type them again. Just press TAB and go.

```bash
# Add command as fav:
fav add docker ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'

# After: just three letters + TAB 🚀
fav dock<TAB>
```

Your commands sync between all your Macs automatically via iCloud Drive.

## Install

```bash
brew install chriopter/fav/fav
fav setup # To setup autocompletion 
```

## Use

```bash
# Save a command
fav add "docker ps -a --format 'table {{.Names}}\t{{.Status}}'"

# Show all Favs with Index
fav

# Delete a fav by Index
fav remove 1

# Type and TAB to complete
fav doc<TAB>
# → fav "docker ps -a --format 'table {{.Names}}\t{{.Status}}'"

# Press ENTER to run
```

## Commands

- `fav add <command>` - Save a command
- `fav` - List saved commands  
- `fav remove <n>` - Remove by number
- `fav <TAB>` - See all commands
- `fav --help` - Show help
- `man fav` - Read manual
- Commands stored in iCloud Drive at `~/Library/Mobile Documents/com~apple~CloudDocs/homebrew-fav/`

## Development

Pushing to main automatically creates a new release. See the `.github/workflows` directory for details.

**Note:** This tool is AI-generated and should be reviewed before use in production environments.