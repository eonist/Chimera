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

echo "CI script finished in ${elapsed_time} seconds."