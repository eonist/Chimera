#!/bin/bash

cd "$(dirname "$0")"

start_time=$(date +%s)

# Navigate to the Packages directory and run all package scripts
cd Packages
./run_all_scripts.sh
cd .. # Go back to the project root

# Run Xcode scheme builds and tests
./build_schemes.sh

end_time=$(date +%s)
elapsed_time=$((end_time - start_time))

# Calculate hours, minutes, and seconds
hours=$((elapsed_time / 3600))
minutes=$(( (elapsed_time % 3600) / 60 ))
seconds=$((elapsed_time % 60))

echo "CI script finished in ${hours} hours, ${minutes} minutes, and ${seconds} seconds."