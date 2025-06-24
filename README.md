# fav

Never type that long command again.
Save that complicated docker command once, and the next time just press TAB, and go.

<img src="https://github.com/user-attachments/assets/2bd04cfe-9dff-4080-a8ca-2bfd0a3f5893" width="300">


## Quick Start

Install in seconds:
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
fav doc<TAB>  # Auto-completes your docker command
# Press ENTER to run
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
- **Case-insensitive matching** - Type `DOC` or `doc`, both find "docker"
- **Direct execution** - Run commands right from `fav` or just view them
- **Works with bash and zsh** - No need to change your shell

### 🛡️ Security & Quality
- **Validation scans for dangerous patterns** before saving or executing (like `; rm -rf $HOME`)
- Detects 30+ risky patterns: `rm -rf`, `dd`, `curl|sh`, `chmod 777`, and more
- Shows warnings but lets you proceed if you know what you're doing
- Comprehensive test suite with 20+ automated tests
- Robust error handling with automatic backups

### 📁 How It Works
Your commands are stored in a simple text file in iCloud Drive, making them automatically available on all your Macs. The intelligent tab completion reads this file and matches your input.

```
~/Library/Mobile Documents/com~apple~CloudDocs/homebrew-fav/
├── fav_favorites.txt    # Your saved commands
└── fav_config.txt       # Security settings
```

## Commands

- `fav add "command"` - Save a new favorite
- `fav` - List all favorites with numbers  
- `fav remove <n>` - Remove by number
- `fav <partial><TAB>` - Tab complete and execute
- `fav config` - Security settings (disable/enable execution)
- `fav setup` - Configure shell completion
- `fav --help` - Show all options

## Troubleshooting

**Tab completion not working?** 
- Run `fav setup` and restart your terminal

**Commands not syncing?** 
- Ensure iCloud Drive is enabled on all devices

**Getting permission errors?** 
- Check that iCloud Drive is accessible: `ls ~/Library/Mobile\ Documents/`

## Development

To release: Update VERSION in both `fav` script and `Formula/fav.rb` URL, commit, and push.

Tests run automatically on every push. Run locally with:
```bash
bats test/*.bats
shellcheck fav
```

---

**Note:** This tool is AI-generated and should be reviewed before use in production environments.