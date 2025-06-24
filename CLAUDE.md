# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`fav` is a macOS command-line tool written in bash that saves and manages favorite shell commands with intelligent tab completion support. Commands are stored in iCloud Drive for cross-Mac syncing.

## Architecture

The project consists of:
- `fav`: Main executable bash script containing all functionality
- `fav-completion.bash` and `fav-completion.zsh`: Shell-specific completion scripts
- `Formula/fav.rb`: Homebrew formula for distribution
- `.github/workflows/release.yml`: Version-driven automated release workflow
- `.github/workflows/test.yml`: Automated testing workflow
- `test/`: Test suite using BATS (Bash Automated Testing System)
- `fav.1`: Man page documentation

## Commands

### Testing
```bash
# Run full test suite
bats test/*.bats

# Run shellcheck for code quality
shellcheck fav
shellcheck fav-completion.bash

# Run basic version test
./fav --version
```

### Release Process
Releases are automated via GitHub Actions when you update versions:
1. Update VERSION in the `fav` script (e.g., "1.2.0")
2. Update version in Formula/fav.rb URL to match (e.g., "v1.2.0.tar.gz")
3. Commit both changes together
4. Push to main branch
5. GitHub Actions automatically:
   - Verifies both versions match
   - Runs full test suite (must pass)
   - Creates GitHub release and tag
   - Updates the SHA256 in the Homebrew formula

**Why this approach**: By updating both versions manually, you have explicit control over when releases happen. The workflow only needs to update the SHA256 after creating the release.

### Development Workflow
1. Edit the `fav` script directly
2. Run tests: `bats test/*.bats`
3. Check code quality: `shellcheck fav`
4. Update completion scripts when adding new commands/options
5. Test with both bash and zsh shells
6. Update man page if adding new features
7. Increment VERSION in script to trigger release

### Error Handling
The script includes robust error handling for:
- Missing iCloud Drive directory
- Disk full conditions
- File permission issues
- Corrupt favorites file
- Empty lines in favorites

All destructive operations create backups that can be restored on failure.

## Key Implementation Details

1. **Storage Locations**: 
   - Commands: `~/Library/Mobile Documents/com~apple~CloudDocs/homebrew-fav/fav_favorites.txt`
   - Config: `~/Library/Mobile Documents/com~apple~CloudDocs/homebrew-fav/fav_config.txt`

2. **Command Structure**:
   - `add`: Appends command to favorites file (with validation and duplicate detection)
   - `list` (default): Shows numbered list of favorites
   - `remove`: Removes by line number (with backup)
   - `setup`: Configures shell completion
   - `config`: Manages security settings
   - Direct execution: Running `fav <saved_command>` executes it (can be disabled)

3. **Security Features**:
   - Command validation prevents injection attacks
   - Detects dangerous patterns (rm -rf, dd, mkfs, curl|sh, etc.)
   - Confirmation prompts for risky commands
   - Option to disable execution entirely
   - Backups created before destructive operations

4. **Completion Logic**: 
   - Case-insensitive matching in both bash and zsh
   - Cycles through matches inline without dropdown
   - Handles partial command matching
   - Context-aware completions for subcommands

5. **Testing**:
   - Comprehensive test suite using BATS
   - Tests cover all commands, error cases, and security features
   - Automated testing on every push
   - Shellcheck for code quality

6. **Version Management**: 
   - Versions must be updated in two places: script VERSION and formula URL
   - Release triggered when both match AND differ from latest tag
   - This gives explicit control over when releases happen
   - Formula SHA256 is automatically calculated after release