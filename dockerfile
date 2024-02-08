# Use the official Ubuntu base image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && \
    apt-get install -y httrack

# Set the working directory
WORKDIR /websites

# Define the list of websites to mirror
ARG WEBSITES="https://www.webmd.com/ https://www.sciencedaily.com/ https://www.wikipedia.org/ https://www.ifixit.com/ https://www.engineeringtoolbox.com/ https://www.allaboutcircuits.com/ https://stackoverflow.com/ https://www.wildfooduk.com/edible-wild-plants/ https://www.farmersalmanac.com/vegetable-gardening-for-beginners-30600 https://www.ncbi.nlm.nih.gov/pmc/"

# Mirror websites
RUN for website in $WEBSITES; do \
        httrack "$website" -O "/websites/$(basename $website)" --mirror; \
    done

# Default command
CMD ["echo", "All websites mirrored successfully."]
