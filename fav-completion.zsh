#compdef fav

_fav() {
    local -a commands favorites
    local fav_file="$HOME/Library/Mobile Documents/com~apple~CloudDocs/homebrew-fav/fav_favorites.txt"
    
    # Define base commands
    commands=(
        'add:Add a command to favorites'
        'list:List all favorite commands'
        'remove:Remove a command by index'
        'help:Show help message'
        'version:Show version information'
    )
    
    # Read favorite commands if file exists
    if [[ -f "$fav_file" ]] && [[ -s "$fav_file" ]]; then
        while IFS= read -r line; do
            favorites+=("${line}:Execute saved command")
        done < "$fav_file"
    fi
    
    # Handle completion based on context
    case $state in
        args)
            case $words[2] in
                remove)
                    # For remove, complete with indices
                    if [[ -f "$fav_file" ]] && [[ -s "$fav_file" ]]; then
                        local num_lines=$(wc -l < "$fav_file")
                        _arguments "1:index:($(seq 1 $num_lines))"
                    fi
                    ;;
                add)
                    # No completion after add
                    ;;
                *)
                    # Complete with commands and favorites
                    _describe -t commands 'fav commands' commands
                    if [[ ${#favorites} -gt 0 ]]; then
                        _describe -t favorites 'favorite commands' favorites
                    fi
                    ;;
            esac
            ;;
    esac
}

# Main completion function
_fav_main() {
    local context state line
    local fav_file="$HOME/Library/Mobile Documents/com~apple~CloudDocs/homebrew-fav/fav_favorites.txt"
    
    _arguments -C \
        '1: :->first_arg' \
        '*: :->args'
    
    case $state in
        first_arg)
            local -a all_completions
            all_completions=(
                'add:Add a command to favorites'
                'list:List all favorite commands'
                'remove:Remove a command by index'
                'help:Show help message'
                'version:Show version information'
                '-h:Show help message'
                '--help:Show help message'
                '-v:Show version information'
                '--version:Show version information'
            )
            
            # Add favorite commands
            if [[ -f "$fav_file" ]] && [[ -s "$fav_file" ]]; then
                while IFS= read -r line; do
                    all_completions+=("${line}:Execute: ${line}")
                done < "$fav_file"
            fi
            
            _describe 'fav' all_completions
            ;;
        args)
            case $words[2] in
                remove)
                    if [[ -f "$fav_file" ]] && [[ -s "$fav_file" ]]; then
                        local num_lines=$(wc -l < "$fav_file")
                        local -a indices
                        for i in $(seq 1 $num_lines); do
                            indices+=("$i")
                        done
                        _values 'index' $indices
                    fi
                    ;;
            esac
            ;;
    esac
}

_fav_main "$@"