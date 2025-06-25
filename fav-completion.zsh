#compdef fav

_fav() {
    local fav_file="$HOME/Library/Mobile Documents/com~apple~CloudDocs/homebrew-fav/fav_favorites.txt"
    
    # Get the current word being completed
    local cur_word="${words[CURRENT]}"
    
    # If we're on the first argument after 'fav'
    if [[ $CURRENT -eq 2 ]]; then
        local -a favorites
        
        # Read favorite commands if file exists
        if [[ -f "$fav_file" ]] && [[ -s "$fav_file" ]]; then
            local line
            while IFS= read -r line; do
                favorites+=("$line")
            done < "$fav_file"
        fi
        
        # Only show favorite commands for tab completion
        if [[ ${#favorites} -gt 0 ]]; then
            if [[ -n "$cur_word" ]]; then
                # Filter favorites based on what's typed (case-insensitive)
                local -a matched_favorites
                for fav in "${favorites[@]}"; do
                    if [[ "${fav:l}" == "${cur_word:l}"* ]]; then
                        matched_favorites+=("$fav")
                    fi
                done
                
                if [[ ${#matched_favorites} -gt 0 ]]; then
                    # Set completion options to prevent prefix completion
                    _comp_options+=(NO_listambiguous)
                    
                    # Add matches with display strings to force menu
                    local match
                    for match in "${matched_favorites[@]}"; do
                        compadd -M 'm:{a-zA-Z}={A-Za-z}' -Q -d match -- "$match"
                    done
                else
                    # No matches found, show all favorites
                    compadd -M 'm:{a-zA-Z}={A-Za-z}' -Q -a favorites
                fi
            else
                # No input yet, show all favorites
                compadd -M 'm:{a-zA-Z}={A-Za-z}' -Q -l -a favorites
            fi
        else
            # If no favorites yet, show a helpful message
            _message "No favorite commands saved yet. Use 'fav add <command>' to add one."
        fi
        
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

# Enable menu selection for cycling through matches
# Force menu select always, starting from first match
zstyle ':completion:*:*:fav:*' menu yes select=1

# For fav specifically, prevent common prefix insertion
zstyle ':completion:*:*:fav:*' insert-unambiguous false
zstyle ':completion:*:*:fav:*' list-ambiguous false
zstyle ':completion:*:*:fav:*' special-dirs false
zstyle ':completion:*:*:fav:*' accept-exact false

_fav "$@"