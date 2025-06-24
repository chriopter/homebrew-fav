#!/usr/bin/env bash

_fav_completions() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    
    # Base commands and options
    local commands="add list remove config setup help version"
    local options="-h --help -v --version"
    
    # Define the favorites file location
    local fav_file="$HOME/Library/Mobile Documents/com~apple~CloudDocs/homebrew-fav/fav_favorites.txt"
    
    # Handle different completion contexts
    case "${prev}" in
        fav)
            # If we're completing after 'fav', show commands, options, and favorite commands
            if [[ ${cur} == -* ]]; then
                COMPREPLY=( $(compgen -W "${options}" -- ${cur}) )
            else
                # Get favorite commands from the file
                if [[ -f "$fav_file" ]] && [[ -s "$fav_file" ]]; then
                    # Read commands from file
                    local favorites=()
                    while IFS= read -r line; do
                        # Add the command to our array
                        [[ -n "$line" ]] && favorites+=("$line")
                    done < "$fav_file"
                    
                    # First, try to complete base commands
                    local base_completions=( $(compgen -W "${commands}" -- "${cur}") )
                    
                    # Then, add favorite commands that match (case-insensitive)
                    shopt -s nocasematch
                    for fav in "${favorites[@]}"; do
                        if [[ "$fav" == "$cur"* ]]; then
                            COMPREPLY+=("$fav")
                        fi
                    done
                    shopt -u nocasematch
                    
                    # Combine base commands and favorites
                    COMPREPLY+=("${base_completions[@]}")
                else
                    # No favorites yet, just show commands
                    COMPREPLY=( $(compgen -W "${commands}" -- ${cur}) )
                fi
            fi
            ;;
        remove)
            # For remove command, suggest index numbers based on the number of favorites
            if [[ -f "$fav_file" ]] && [[ -s "$fav_file" ]]; then
                local num_lines
                num_lines=$(wc -l < "$fav_file")
                local indices
                indices=$(seq 1 $num_lines)
                COMPREPLY=( $(compgen -W "${indices}" -- ${cur}) )
            fi
            ;;
        add)
            # No completion after 'add' - user needs to type their command
            ;;
        config)
            # Complete config subcommands
            local config_cmds="disable-execution enable-execution status"
            COMPREPLY=( $(compgen -W "${config_cmds}" -- ${cur}) )
            ;;
        setup)
            # Complete setup options
            if [[ ${cur} == -* ]]; then
                local setup_opts="--check --shell"
                COMPREPLY=( $(compgen -W "${setup_opts}" -- ${cur}) )
            elif [[ ${prev} == "--shell" ]]; then
                local shells="bash zsh"
                COMPREPLY=( $(compgen -W "${shells}" -- ${cur}) )
            fi
            ;;
        *)
            # Default: no completion
            ;;
    esac
    
    return 0
}

# Register the completion function for the fav command
complete -F _fav_completions fav