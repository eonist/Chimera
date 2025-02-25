#!/bin/bash

cd "$(dirname "$0")"

spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

echo "Starting CI process..."

# Record the start time
start_time=$(date +%s)

# Run the CI script in the background
./run_ci.sh &

# Capture the PID of the background process
CI_PID=$!

# Start the spinner, passing the CI script's PID
spinner $CI_PID

# Wait for the CI script to finish
wait $CI_PID

# Record the end time
end_time=$(date +%s)

# Calculate the elapsed time in seconds
elapsed_time=$((end_time - start_time))

# Convert seconds to hours, minutes, and seconds
hours=$((elapsed_time / 3600))
minutes=$(( (elapsed_time % 3600) / 60 ))
seconds=$((elapsed_time % 60))

# Check the exit status of the CI script
if [ $? -eq 0 ]; then
    echo "CI process completed successfully!"
else
    echo "CI process failed. Check logs for details."
fi

# Print the elapsed time
printf "Total time: %02dh %02dm %02ds\n" $hours $minutes $seconds
