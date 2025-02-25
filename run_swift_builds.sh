#!/bin/bash

# Save the original directory
original_dir=$(pwd)

# Start timing
start_time=$(date +%s)

# Find all directories containing a Package.swift file
package_dirs=$(find . -name "Package.swift" -exec dirname {} \;)

# Loop through each directory and run swift build
for dir in $package_dirs
do
    echo "Building $dir"
    cd "$dir"
    swift build
    if [ $? -ne 0 ]; then
        echo "Build failed in $dir. Exiting."
        exit 1
    fi
    echo "Finished building $dir"
    # Return to the original directory
    cd "$original_dir"
done

# End timing
end_time=$(date +%s)

# Calculate and report the duration
duration=$((end_time - start_time))
echo "Total time taken: $duration seconds"