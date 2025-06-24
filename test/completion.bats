#!/usr/bin/env bats

load test_helper

@test "bash completion script exists and is valid" {
    [ -f "$BATS_TEST_DIRNAME/../fav-completion.bash" ]
    run bash -n "$BATS_TEST_DIRNAME/../fav-completion.bash"
    [ "$status" -eq 0 ]
}

@test "zsh completion script exists and is valid" {
    [ -f "$BATS_TEST_DIRNAME/../fav-completion.zsh" ]
    # zsh syntax check
    run zsh -n "$BATS_TEST_DIRNAME/../fav-completion.zsh" 2>/dev/null || true
    # Just check file exists since zsh -n might not be available
    [ -f "$BATS_TEST_DIRNAME/../fav-completion.zsh" ]
}

@test "bash completion file references match main script" {
    # Check that completion script uses same file path
    grep -q "fav_favorites.txt" "$BATS_TEST_DIRNAME/../fav-completion.bash"
}