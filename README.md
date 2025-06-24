# fav

Never type that long command again.

Save commands with 'fav add', access with 'fav <TAB>'. Syncs between Macs.

<img src="https://github.com/user-attachments/assets/2bd04cfe-9dff-4080-a8ca-2bfd0a3f5893" width="300">


## Quick Start

Install:
```bash
brew install chriopter/fav/fav
fav setup  # Enable tab completion
```

Save your complex commands once:
```bash
fav add "docker ps -a --format 'table {{.Names}}\t{{.Status}}'"
```

Use them forever with tab completion:
```bash
fav doc<TAB>  # Auto-completes your docker command & Press ENTER to run
```

Manage your collection:
```bash
fav           # List all saved commands
fav remove 1  # Remove by number
```

That's it! Your commands sync across all your Macs via iCloud automatically.

## Features

### 🚀 Core Features
- **Tab completion** - Type a few letters, press TAB, get your full command
- **iCloud sync** - Your commands are available on all your Macs instantly
- **Direct execution** - Run commands right from `fav` or just view them
- **Works with bash and zsh** - No need to change your shell

### 💎 Quality
- Minimal, clean codebase (KISS principle)
- Tested with automated tests

### 📁 How It Works
Your commands are stored in a simple text file in iCloud Drive. The intelligent tab completion reads this file and matches your input.

```
~/Library/Mobile Documents/com~apple~CloudDocs/homebrew-fav/
└── fav_favorites.txt    # Your saved commands
```

## Commands

- `fav add "command"` - Save a new favorite
- `fav` - List all favorites with numbers  
- `fav remove <n>` - Remove by number
- `fav <partial><TAB>` - Tab complete and execute
- `fav setup` - Configure shell completion
- `fav --help` - Show all options

## Troubleshooting

- Tab Completion: Run `fav setup` and restart your terminal & Check that iCloud Drive is accessible: `ls ~/Library/Mobile\ Documents/`

## Development

To release: Update VERSION in `fav` script, commit, and push. CI will auto-update the formula.

Tests run automatically on every push. Run locally with:
```bash
bats test/*.bats
shellcheck fav
```

---

**Note:** This tool is AI-generated and should be reviewed before use in production environments.