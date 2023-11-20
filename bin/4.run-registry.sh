#!/bin/bash

# Set the registry container name and port
REGISTRY_CONTAINER_NAME="local-registry"
REGISTRY_PORT=5000

# Check if the registry container already exists
if docker ps -a | grep -q "$REGISTRY_CONTAINER_NAME"; then
    echo "Registry container already exists."

    # Check if the container is running
    if docker ps | grep -q "$REGISTRY_CONTAINER_NAME"; then
        echo "Registry container is already running."
    else
        echo "Starting the registry container..."
        docker start "$REGISTRY_CONTAINER_NAME"
    fi
else
    # Create and start the registry container
    echo "Creating and starting local registry container..."
    docker run -d -p $REGISTRY_PORT:5000 --name "$REGISTRY_CONTAINER_NAME" registry:2

    if [ $? -eq 0 ]; then
        echo "Local registry container started successfully on port $REGISTRY_PORT."
    else
        echo "Failed to start local registry container."
    fi
fi