# Build container 1 and include config1.txt
docker build -t mirroring-container-1 --build-arg CONFIG_FILE=config1.txt .

# Build container 2 and include config2.txt
docker build -t mirroring-container-2 --build-arg CONFIG_FILE=config2.txt .

# Build container 3 and include config3.txt
docker build -t mirroring-container-3 --build-arg CONFIG_FILE=config3.txt .

# Build container 4 and include config4.txt
docker build -t mirroring-container-4 --build-arg CONFIG_FILE=config4.txt .
