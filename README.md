# fav

Save and autocomplete your favorite commands.

## Install

```bash
brew install chriopter/fav/fav
fav setup
```

## Use

```bash
# Save a command
fav add "docker ps -a"

# Type and TAB to complete
fav d<TAB>
# → fav "docker ps -a"

# Press ENTER to run
```

## Commands

- `fav add <command>` - Save a command
- `fav` - List saved commands  
- `fav remove <n>` - Remove by number
- `fav <TAB>` - See all commands

Commands sync via iCloud between your Macs.

## More Info

- `fav --help` - Help
- `man fav` - Manual