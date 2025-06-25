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
            local -a matched_favorites
            
            # Filter based on input
            if [[ -n "$cur_word" ]]; then
                for fav in "${favorites[@]}"; do
                    if [[ "${fav:l}" == "${cur_word:l}"* ]]; then
                        matched_favorites+=("$fav")
                    fi
                done
            else
                matched_favorites=("${favorites[@]}")
            fi
            
            if [[ ${#matched_favorites} -gt 0 ]]; then
                # Use _values which handles menu selection properly
                local -a value_specs
                local fav
                for fav in "${matched_favorites[@]}"; do
                    # Escape special characters for _values
                    local escaped="${fav//:/\\:}"
                    escaped="${escaped//\[/\\[}"
                    escaped="${escaped//\]/\\]}"
                    value_specs+=("${escaped//=/\\=}:${fav}")
                done
                
                _values -s '' 'favorite commands' "${value_specs[@]}"
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

# Specific styles for fav to ensure menu selection works
zstyle ':completion:*:*:fav:*:*' menu yes select
zstyle ':completion:*:*:fav:*:*' force-list always

_fav "$@"