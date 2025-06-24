#!/usr/bin/env bats

load test_helper

@test "version command shows correct version" {
    run "$FAV_SCRIPT" --version
    [ "$status" -eq 0 ]
    [[ "$output" == "fav version 1.0.1" ]]
}

@test "help command shows usage information" {
    run "$FAV_SCRIPT" --help
    [ "$status" -eq 0 ]
    [[ "$output" =~ "fav - A bash favorite command tool for macOS" ]]
    [[ "$output" =~ "USAGE:" ]]
    [[ "$output" =~ "COMMANDS:" ]]
}

@test "list shows message when no favorites exist" {
    setup_test_env
    run "$FAV_SCRIPT" list
    [ "$status" -eq 0 ]
    [[ "$output" =~ "No favorite commands saved yet" ]]
}

@test "add command adds to favorites" {
    setup_test_env
    run "$FAV_SCRIPT" add "echo hello world"
    [ "$status" -eq 0 ]
    [[ "$output" == "Added to favorites: echo hello world" ]]
    [ "$(count_favorites)" -eq 1 ]
    command_exists "echo hello world"
}

@test "add command with quotes" {
    setup_test_env
    run "$FAV_SCRIPT" add 'git commit -m "Initial commit"'
    [ "$status" -eq 0 ]
    [[ "$output" == 'Added to favorites: git commit -m "Initial commit"' ]]
    command_exists 'git commit -m "Initial commit"'
}

@test "add empty command fails" {
    setup_test_env
    run "$FAV_SCRIPT" add ""
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Error: No command provided" ]]
}

@test "add duplicate command prompts user" {
    setup_test_env
    add_test_command "echo test"
    run bash -c "echo 'no' | '$FAV_SCRIPT' add 'echo test'"
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Warning: This exact command already exists" ]]
    [[ "$output" =~ "Command not added" ]]
    [ "$(count_favorites)" -eq 1 ]
}

@test "add dangerous command shows warning" {
    setup_test_env
    run bash -c "echo 'no' | '$FAV_SCRIPT' add 'rm -rf /'"
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Warning: Command matches destructive pattern" ]]
    [[ "$output" =~ "Command not added" ]]
    [ "$(count_favorites)" -eq 0 ]
}

@test "list shows numbered favorites" {
    setup_test_env
    add_test_command "echo one"
    add_test_command "echo two"
    add_test_command "echo three"
    
    run "$FAV_SCRIPT" list
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Favorite commands:" ]]
    [[ "$output" =~ "1. echo one" ]]
    [[ "$output" =~ "2. echo two" ]]
    [[ "$output" =~ "3. echo three" ]]
}

@test "remove by valid index" {
    setup_test_env
    add_test_command "echo one"
    add_test_command "echo two"
    add_test_command "echo three"
    
    run "$FAV_SCRIPT" remove 2
    [ "$status" -eq 0 ]
    [[ "$output" == "Removed from favorites: echo two" ]]
    [ "$(count_favorites)" -eq 2 ]
    ! command_exists "echo two"
    command_exists "echo one"
    command_exists "echo three"
}

@test "remove with invalid index fails" {
    setup_test_env
    add_test_command "echo test"
    
    run "$FAV_SCRIPT" remove 5
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Index 5 is out of range" ]]
}

@test "remove with non-numeric index fails" {
    setup_test_env
    run "$FAV_SCRIPT" remove abc
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Please provide a valid index number" ]]
}

@test "remove from empty list fails" {
    setup_test_env
    run "$FAV_SCRIPT" remove 1
    [ "$status" -eq 1 ]
    [[ "$output" =~ "No favorite commands to remove" ]]
}

@test "config disable-execution works" {
    setup_test_env
    run "$FAV_SCRIPT" config disable-execution
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Direct command execution has been disabled" ]]
    [ -f "$TEST_CONFIG_FILE" ]
    grep -q "disable_execution=true" "$TEST_CONFIG_FILE"
}

@test "config enable-execution works" {
    setup_test_env
    echo "disable_execution=true" > "$TEST_CONFIG_FILE"
    
    run "$FAV_SCRIPT" config enable-execution
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Direct command execution has been enabled" ]]
    ! grep -q "disable_execution=true" "$TEST_CONFIG_FILE"
}

@test "config status shows current state" {
    setup_test_env
    run "$FAV_SCRIPT" config status
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Direct command execution: ENABLED" ]]
    
    "$FAV_SCRIPT" config disable-execution
    run "$FAV_SCRIPT" config status
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Direct command execution: DISABLED" ]]
}

@test "execute command when enabled" {
    setup_test_env
    add_test_command "echo execution test"
    
    run "$FAV_SCRIPT" "echo execution test"
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Executing: echo execution test" ]]
}

@test "execute command when disabled fails" {
    setup_test_env
    add_test_command "echo test"
    "$FAV_SCRIPT" config disable-execution
    
    run "$FAV_SCRIPT" "echo test"
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Error: Direct command execution is disabled" ]]
}

@test "execute non-existent command fails" {
    setup_test_env
    run "$FAV_SCRIPT" "non-existent-command"
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Error: Unknown command" ]]
}

@test "default behavior with no arguments lists commands" {
    setup_test_env
    add_test_command "echo default test"
    
    run "$FAV_SCRIPT"
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Favorite commands:" ]]
    [[ "$output" =~ "1. echo default test" ]]
}

# Cleanup after each test
teardown() {
    teardown_test_env
}