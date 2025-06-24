# fav

Never type that long command again. Save it once, press TAB, and go.

<img src="https://github.com/user-attachments/assets/2bd04cfe-9dff-4080-a8ca-2bfd0a3f5893" width="300">

## The Problem

Remember that Docker command with all the formatting flags? Or that Git log with the perfect options? You google it, copy-paste it, then forget it again next week.

## The Solution

`fav` saves your complex commands and makes them available with tab completion. Your commands sync across all your Macs via iCloud Drive automatically.

```bash
# Save once
fav add "docker ps -a --format 'table {{.Names}}\t{{.Status}}'"

# Use forever - just type and TAB
fav doc<TAB>
# → fav "docker ps -a --format 'table {{.Names}}\t{{.Status}}'"
# Press ENTER to run
```

## Install

```bash
brew install chriopter/fav/fav
fav setup  # Enable tab completion
```

## Quick Start

```bash
# Save a command
fav add "git log --graph --pretty=format:'%C(yellow)%h%C(reset) %s %C(green)'"

# List your commands
fav
  1. docker ps -a --format...
  2. git log --graph --pretty...

# Execute by typing part of it + TAB
fav git<TAB>  # Auto-completes and runs your git command

# Remove by number
fav remove 1
```

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

## Commands

- `fav add "command"` - Save a new favorite
- `fav` - List all favorites with numbers  
- `fav remove <n>` - Remove by number
- `fav <partial><TAB>` - Tab complete and execute
- `fav config` - Security settings (disable/enable execution)
- `fav setup` - Configure shell completion
- `fav --help` - Show all options

## How It Works

Your commands are stored in a simple text file in iCloud Drive, making them automatically available on all your Macs. The intelligent tab completion reads this file and matches your input, even with typos.

```
~/Library/Mobile Documents/com~apple~CloudDocs/homebrew-fav/
├── fav_favorites.txt    # Your saved commands
└── fav_config.txt       # Security settings
```

## Troubleshooting

**Tab completion not working?** 
- Run `fav setup` and restart your terminal

**Commands not syncing?** 
- Ensure iCloud Drive is enabled on all devices

**Getting permission errors?** 
- Check that iCloud Drive is accessible: `ls ~/Library/Mobile\ Documents/`

## Development

### Creating a Release

1. Update `VERSION="1.2.0"` in the `fav` script
2. Update the URL version in `Formula/fav.rb` to match
3. Commit both: `git commit -m "Release v1.2.0"`
4. Push to main - GitHub Actions handles the rest

### Contributing

Tests run automatically on every push. Run locally with:
```bash
bats test/*.bats
shellcheck fav
```

---

**Note:** This tool is AI-generated and should be reviewed before use in production environments.