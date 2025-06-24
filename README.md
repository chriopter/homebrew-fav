# fav

Save your favorite commands once. Run them with tab completion forever.

<img src="https://github.com/user-attachments/assets/2bd04cfe-9dff-4080-a8ca-2bfd0a3f5893" width="300">

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
# Works without "-marks as well but might not escapce correctly.

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

- `fav add <command>` - Save a command (with validation and duplicate detection)
- `fav` - List saved commands  
- `fav remove <n>` - Remove by number
- `fav config <action>` - Configure security settings
  - `disable-execution` - Disable direct command execution
  - `enable-execution` - Enable direct command execution (default)
  - `status` - Show current configuration
- `fav <TAB>` - See all commands (with case-insensitive matching)
- `fav --help` - Show help
- `man fav` - Read manual
- Commands stored in iCloud Drive at `~/Library/Mobile Documents/com~apple~CloudDocs/homebrew-fav/`

## Features

### Security
- Command validation prevents injection attacks
- Detects 30+ dangerous command patterns including:
  - File destruction (`rm -rf`, `shred`, `find -delete`)
  - Disk operations (`dd`, `mkfs`, `fdisk`, `wipefs`)
  - System modification (`> /etc/`, `chmod 777`, `chown -R`)
  - Remote execution (`curl|sh`, `wget|bash`, `nc -e`)
  - System state (`shutdown`, `reboot`, `init 0`)
  - Package corruption (`remove kernel`, `--force` installs)
- Confirmation prompts for risky operations  
- Option to disable command execution entirely
- All commands are validated before being saved

### Quality Assurance
- Comprehensive test suite with automated testing on every push
- Code quality checks with shellcheck
- Version consistency validation

## Technical Details

### How It Works

`fav` is a bash script that manages a plain text file of your favorite commands with intelligent shell integration:

1. **Storage**: Commands are stored one-per-line in `~/Library/Mobile Documents/.../fav_favorites.txt`
   - Uses iCloud Drive for automatic sync between Macs
   - Config stored separately in `fav_config.txt`

2. **Tab Completion Magic**: 
   - Shell-specific completion scripts (`fav-completion.bash/zsh`) 
   - Reads favorites file and matches against your input
   - Case-insensitive matching with inline cycling (no dropdown)
   - `fav doc<TAB>` → finds "docker ps..." command

3. **Execution Flow**:
   ```
   fav "docker ps -a"
   ├── Check if execution disabled
   ├── Grep for exact match in favorites
   ├── Validate command (even saved ones)
   ├── Warn if dangerous pattern detected
   └── Execute with eval (or cancel)
   ```

4. **Security Validation**:
   - Blocks command injection: `echo test; rm -rf $HOME`
   - Detects 30+ dangerous patterns across 6 categories:
     - File/directory destruction
     - Disk/filesystem operations  
     - System file modifications
     - Permission changes
     - Remote code execution
     - System state changes
   - Two-stage validation: when adding AND before executing

5. **Performance Optimizations**:
   - Uses `awk` for 50+ commands (faster than bash loops)
   - Grep-first lookup instead of reading entire file
   - Efficient duplicate detection for large files

6. **Error Handling**:
   - Creates timestamped backups before destructive operations
   - Validates iCloud Drive exists and is writable
   - Handles both BSD (macOS) and GNU sed syntax
   - Restores from backup if operations fail

## Troubleshooting

- **Tab completion not working?** Run `fav setup` and restart your terminal
- **Commands not syncing?** Ensure iCloud Drive is enabled and synced
- **Permission errors?** Check that iCloud Drive folder exists and is writable

## Development

Releases are triggered when the VERSION in the `fav` script is incremented. The release process:
1. Checks if VERSION changed from latest tag
2. Runs all tests (must pass)
3. Creates GitHub release and updates Homebrew formula

Tests are run automatically on every push to ensure code quality.



**Note:** This tool is AI-generated and should be reviewed before use in production environments.
