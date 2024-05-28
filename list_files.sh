#!/bin/bash

# Define the directory to list (current directory by default)
DIR=${1:-.}

# Output file
OUTPUT_FILE="filenames.txt"

# List all filenames in the directory and subdirectories
find "$DIR" -type f > "$OUTPUT_FILE"

echo "All filenames have been listed in $OUTPUT_FILE"
