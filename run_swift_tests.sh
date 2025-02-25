#!/bin/bash

# Save the original directory
original_dir=$(pwd)

# Find all directories containing a Package.swift file
paths=$(find . -name "Package.swift" -exec dirname {} \;)

# Start timing
start_time=$(date +%s)

# Loop through each path and run swift test
for path in $paths
do
    echo "Running tests in $path"
    cd "$path"
    swift test
    if [ $? -ne 0 ]; then
        echo "Tests failed in $path. Exiting."
        exit 1
    fi
    echo "Finished testing $path"
    # Return to the original directory
    cd "$original_dir"
done

# End timing
end_time=$(date +%s)

# Calculate and report the duration
duration=$((end_time - start_time))
echo "Total time taken: $duration seconds"