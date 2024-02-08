#!/bin/bash

# Define the list of containers
CONTAINERS=("mirroring-container-1" "mirroring-container-2" "mirroring-container-3" "mirroring-container-4")

# Define website URLs
WEBSITES=( "https://www.webmd.com/" "https://www.sciencedaily.com/" "https://www.wikipedia.org/" "https://www.ifixit.com/" "https://www.engineeringtoolbox.com/" "https://www.allaboutcircuits.com/" "https://stackoverflow.com/" "https://www.wildfooduk.com/edible-wild-plants/" "https://www.farmersalmanac.com/vegetable-gardening-for-beginners-30600" "https://www.ncbi.nlm.nih.gov/pmc/" )

# Calculate the number of websites per container
WEBSITES_PER_CONTAINER=$(( ${#WEBSITES[@]} / ${#CONTAINERS[@]} ))

# Loop through containers
for container in "${CONTAINERS[@]}"; do
    # Extract the slice of websites for this container
    websites_slice=("${WEBSITES[@]:0:$WEBSITES_PER_CONTAINER}")
    
    # Remove the sliced websites from the main list
    WEBSITES=("${WEBSITES[@]:$WEBSITES_PER_CONTAINER}")

    # Run the container to mirror the websites
    docker run -d --name "$container" -v "$(pwd)/$container:/websites" "$container"

    # Update the Dockerfile for the container with the selected websites
    sed -i "s|ARG WEBSITES=.*|ARG WEBSITES=\"$(printf '%s ' "${websites_slice[@]}")\"|" Dockerfile
done
