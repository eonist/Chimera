#!/bin/bash

# Change to the directory where the script is located
cd "$(dirname "$0")"

# Define an array of script names to be executed
scripts=(
    "run_swift_builds.sh" # Builds all Swift packages in the project
    "run_swift_tests.sh" # Runs tests for all Swift packages in the project
    "remove_package_resolved.sh" # Removes Package.resolved files to reset package resolution
    "remove_build_folders.sh" # Removes all .build folders to clean build artifacts
)

# Get the total number of scripts
total_scripts=${#scripts[@]}
# Initialize the counter for completed scripts
completed_scripts=0

# Loop through each script in the array
for script in "${scripts[@]}"; do
    # Execute the script
    bash "$script"
    # Capture the exit status of the script
    exit_status=$?
    
    # Check if the script executed successfully
    if [ $exit_status -eq 0 ]; then
        # Print a success message
        echo "$script has finished"
        # Increment the completed scripts counter
        ((completed_scripts++))
    else
        # Print a failure message with the exit status
        echo "$script failed with exit status $exit_status"
    fi
done

# Print the number of successfully completed scripts
echo "$completed_scripts out of $total_scripts scripts finished"