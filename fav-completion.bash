#!/usr/bin/env bash

_fav_completions() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    
    # Base commands and options
    local commands="add list remove help version"
    local options="-h --help -v --version"
    
    # Handle different completion contexts
    case "${prev}" in
        fav)
            # If we're completing after 'fav', show commands, options, and favorite commands
            if [[ ${cur} == -* ]]; then
                COMPREPLY=( $(compgen -W "${options}" -- ${cur}) )
            else
                # Get favorite commands from the file
                local fav_file="$HOME/Library/Mobile Documents/com~apple~CloudDocs/homebrew-fav/fav_favorites.txt"
                if [[ -f "$fav_file" ]] && [[ -s "$fav_file" ]]; then
                    # Read commands from file and escape special characters
                    local favorites=""
                    while IFS= read -r line; do
                        # Escape special characters for completion
                        local escaped_line=$(printf '%q' "$line")
                        favorites+="$escaped_line "
                    done < "$fav_file"
                    
                    # Combine commands and favorites
                    COMPREPLY=( $(compgen -W "${commands} ${favorites}" -- ${cur}) )
                else
                    # No favorites yet, just show commands
                    COMPREPLY=( $(compgen -W "${commands}" -- ${cur}) )
                fi
            fi
            ;;
        remove)
            # For remove command, suggest index numbers based on the number of favorites
            local fav_file="$HOME/.fav_favorites.txt"
            if [[ -f "$fav_file" ]] && [[ -s "$fav_file" ]]; then
                local num_lines=$(wc -l < "$fav_file")
                local indices=$(seq 1 $num_lines)
                COMPREPLY=( $(compgen -W "${indices}" -- ${cur}) )
            fi
            ;;
        add)
            # No completion after 'add' - user needs to type their command
            ;;
        *)
            # Default: no completion
            ;;
    esac
    
    return 0
}

# Register the completion function for the fav command
complete -F _fav_completions fav