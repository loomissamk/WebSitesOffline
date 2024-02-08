#!/bin/bash

# Check if a configuration file is provided as a build argument
if [ -z "$CONFIG_FILE" ]; then
    echo "Error: No configuration file provided."
    exit 1
fi

# Check if the configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Configuration file '$CONFIG_FILE' not found."
    exit 1
fi

# Read the configuration file
websites=$(cat "$CONFIG_FILE")

# Loop through the list of websites and perform mirroring
for website in $websites; do
    # Perform mirroring for each website
    httrack "$website"
done

