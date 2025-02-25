# Use bash as the shell interpreter
#!/bin/bash

# Change to the directory where the script is located
cd "$(dirname "$0")"

# Initialize a counter for removed files
# Set counter "removed_count" to 0
removed_count=0

# Find and remove all Package.resolved files in subdirectories
# Start loop reading each found Package.resolved file into "file"
while IFS= read -r file; do
    # Output the current file being removed
    echo "Removing: $file"
    # Remove the file
    rm "$file"
    # Increment "removed_count" by 1
    ((removed_count++))
# End loop; input provided by find command starting from current directory
done < <(find "$(dirname "$0")" -name "Package.resolved" -type f)

# Output the final count of removed files
echo "Total Package.resolved files removed: $removed_count"