#!/usr/bin/env bash

# Test helper functions for fav tests

# Set up test environment
export TEST_FAV_DIR="$BATS_TEST_TMPDIR/fav_test"
export TEST_FAV_FILE="$TEST_FAV_DIR/fav_favorites.txt"
export TEST_CONFIG_FILE="$TEST_FAV_DIR/fav_config.txt"

# Override the default directories in the fav script
export FAV_DIR="$TEST_FAV_DIR"
export FAV_FILE="$TEST_FAV_FILE"
export CONFIG_FILE="$TEST_CONFIG_FILE"

# Path to the fav script
FAV_SCRIPT="$BATS_TEST_DIRNAME/../fav"

# Create test directory
setup_test_env() {
    mkdir -p "$TEST_FAV_DIR"
    # Clear any existing files
    rm -f "$TEST_FAV_FILE" "$TEST_CONFIG_FILE"
}

# Clean up test directory
teardown_test_env() {
    rm -rf "$TEST_FAV_DIR"
}

# Add a test command to favorites
add_test_command() {
    echo "$1" >> "$TEST_FAV_FILE"
}

# Count lines in favorites file
count_favorites() {
    if [[ -f "$TEST_FAV_FILE" ]]; then
        wc -l < "$TEST_FAV_FILE" | tr -d ' '
    else
        echo "0"
    fi
}

# Check if command exists in favorites
command_exists() {
    grep -Fxq "$1" "$TEST_FAV_FILE"
}