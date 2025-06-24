# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`fav` is a macOS command-line tool written in bash that saves and manages favorite shell commands with intelligent tab completion support. Commands are stored in iCloud Drive for cross-Mac syncing.

## Architecture

The project consists of:
- `fav`: Main executable bash script containing all functionality
- `fav-completion.bash` and `fav-completion.zsh`: Shell-specific completion scripts
- `Formula/fav.rb`: Homebrew formula for distribution
- `.github/workflows/main.yml`: Combined CI/CD workflow (testing + releases)
- `.github/workflows/test-reusable.yml`: Reusable test workflow
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
2. Commit and push to main branch
3. GitHub Actions automatically:
   - Updates Formula version to match script
   - Runs full test suite (must pass)
   - Creates GitHub release and tag
   - Updates the SHA256 in the Homebrew formula

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


## Key Implementation Details

1. **Storage Location**: 
   - Commands: `~/Library/Mobile Documents/com~apple~CloudDocs/homebrew-fav/fav_favorites.txt`

2. **Command Structure**:
   - `add`: Appends command to favorites file
   - `list` (default): Shows numbered list of favorites
   - `remove`: Removes by line number
   - `setup`: Configures shell completion
   - Direct execution: Running `fav <saved_command>` executes it

3. **Completion Logic**: 
   - Case-insensitive matching in both bash and zsh
   - Cycles through matches inline without dropdown
   - Handles partial command matching
   - Context-aware completions for subcommands

4. **Testing**:
   - Test suite using BATS
   - Tests cover all commands and error cases
   - Automated testing on every push
   - Shellcheck for code quality

5. **Version Management**: 
   - Version is defined only in the main `fav` script
   - CI automatically updates the formula version to match
   - Release triggered when version differs from latest tag
   - Formula SHA256 is automatically calculated after release