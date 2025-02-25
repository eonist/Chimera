#!/bin/bash

# Change to the directory where the script resides
cd "$(dirname "$0")"

# Find the first .xcodeproj file in the current directory
project_file=$(find . -maxdepth 1 -name "*.xcodeproj" | head -n 1)

if [ -z "$project_file" ]; then
    echo "No .xcodeproj file found in the current directory."
    exit 1
fi

# Extract the project name from the file path
project_name=$(basename "$project_file" .xcodeproj)

# Get the list of schemes and trim leading/trailing whitespace
schemes=$(xcodebuild -list -project "$project_file" | awk '/Schemes:/,/^$/' | tail -n +2 | sed '/^\s*$/d' | sed 's/^[ \t]*//;s/[ \t]*$//')

# Initialize counters
total_schemes=0
successful_builds=0

# Build each scheme
while IFS= read -r scheme; do
    ((total_schemes++))
    echo "Building scheme: $scheme"
    if xcodebuild -project "$project_file" -scheme "$scheme" build; then
        ((successful_builds++))
    else
        echo "Failed to build scheme: $scheme"
    fi
    echo "-----------------------------------"
done <<< "$schemes"

# Print summary
echo "Build complete. $successful_builds out of $total_schemes schemes built successfully."