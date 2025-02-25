#!/bin/bash

# Change to the directory where the script is located
cd "$(dirname "$0")"

# Initialize a counter for removed folders
count=0

# Find .build folders, print their paths, remove them, and count
while IFS= read -r -d '' folder; do
    # Print the path of the folder being removed
    echo "Removing: $folder"
    # Remove the folder and its contents
     rm -rf "$folder"
    # Increment the counter
    ((count++))
# Use find to locate all directories named .build and process them
done < <(find . -type d -name ".build" -print0)

# Print summary
echo "------------------------"
# Print the total number of .build folders removed: $count
echo "Total .build folders removed: $count"