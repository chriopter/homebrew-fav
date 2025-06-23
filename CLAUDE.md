# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`fav` is a macOS command-line tool written in bash that saves and manages favorite shell commands with intelligent tab completion support. Commands are stored in iCloud Drive for cross-Mac syncing.

## Architecture

The project consists of:
- `fav`: Main executable bash script containing all functionality
- `fav-completion.bash` and `fav-completion.zsh`: Shell-specific completion scripts
- `Formula/fav.rb`: Homebrew formula for distribution
- `.github/workflows/release.yml`: Automated release workflow

## Commands

### Testing
```bash
# Run basic version test (as defined in Homebrew formula)
./fav --version
```

### Release Process
Releases are automated via GitHub Actions when pushing to main:
1. Push commits to main branch
2. GitHub Actions automatically:
   - Increments patch version
   - Creates GitHub release with commit message
   - Updates Homebrew formula with new version and SHA256

### Development Workflow
Since this is a bash script:
- Edit the `fav` script directly
- Test changes by running `./fav` with various commands
- Update completion scripts (`fav-completion.bash/zsh`) when adding new commands/options
- Ensure changes work with both bash and zsh shells

## Key Implementation Details

1. **Storage Location**: Commands are stored in `~/Library/Mobile Documents/com~apple~CloudDocs/homebrew-fav/favorites.txt`

2. **Command Structure**:
   - `add`: Appends command to favorites file
   - `list` (default): Shows numbered list of favorites
   - `remove`: Removes by line number
   - `setup`: Configures shell completion
   - Direct execution: Running `fav <saved_command>` executes it

3. **Completion Logic**: 
   - Recently enhanced to support case-insensitive matching in zsh
   - Cycles through matches inline without dropdown
   - Handles partial command matching

4. **Version Management**: Version is defined in the main `fav` script and must match the Homebrew formula version