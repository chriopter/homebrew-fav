#compdef fav

_fav() {
    local fav_file="$HOME/Library/Mobile Documents/com~apple~CloudDocs/homebrew-fav/fav_favorites.txt"
    
    # Get the current word being completed
    local cur_word="${words[CURRENT]}"
    
    # If we're on the first argument after 'fav'
    if [[ $CURRENT -eq 2 ]]; then
        local -a commands options favorites
        
        # Base commands
        commands=(
            'add:Add a command to favorites'
            'list:List all favorite commands'
            'remove:Remove a command by index'
            'setup:Configure shell completion'
            'help:Show help message'
            'version:Show version information'
        )
        
        # Options
        options=(
            '-h:Show help message'
            '--help:Show help message'
            '-v:Show version information'
            '--version:Show version information'
        )
        
        # Read favorite commands if file exists
        if [[ -f "$fav_file" ]] && [[ -s "$fav_file" ]]; then
            local line
            while IFS= read -r line; do
                # Just add the command without description
                favorites+=("$line")
            done < "$fav_file"
        fi
        
        # Combine all completions
        local -a all_completions
        all_completions=($commands $options $favorites)
        
        # First add favorite commands (no descriptions needed)
        if [[ ${#favorites} -gt 0 ]]; then
            compadd -Q -a favorites
        fi
        
        # Then add commands and options with descriptions
        _describe -t commands 'commands' commands
        _describe -t options 'options' options
        
        return 0
    fi
    
    # Handle subcommand completions
    case "${words[2]}" in
        remove)
            if [[ $CURRENT -eq 3 ]] && [[ -f "$fav_file" ]] && [[ -s "$fav_file" ]]; then
                local num_lines=$(wc -l < "$fav_file")
                local -a indices
                for i in {1..$num_lines}; do
                    local cmd=$(sed -n "${i}p" "$fav_file")
                    indices+=("${i}:${cmd}")
                done
                _describe -t indices 'command index' indices
            fi
            ;;
        setup)
            if [[ $CURRENT -eq 3 ]]; then
                local -a setup_options
                setup_options=(
                    '--check:Check if completion is configured'
                    '--shell:Configure for specific shell'
                )
                _describe -t options 'setup options' setup_options
            elif [[ $CURRENT -eq 4 ]] && [[ "${words[3]}" == "--shell" ]]; then
                local -a shells
                shells=(
                    'zsh:Z shell'
                    'bash:Bourne Again Shell'
                )
                _describe -t shells 'shell type' shells
            fi
            ;;
        add)
            # No completion after add
            ;;
        *)
            # No further completion for other commands
            ;;
    esac
}

# Set completion style to menu select for cycling through options
zstyle ':completion:*:*:fav:*' menu select

# Enable shift-tab for reverse menu completion
# This is a global setting but useful for fav
bindkey '^[[Z' reverse-menu-complete

_fav "$@"