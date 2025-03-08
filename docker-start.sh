#!/bin/bash

# Exit on error
set -e

echo "Building and starting portfolio-ai containers..."

# Update submodules if needed
git submodule update --init --recursive

# Build and start containers
docker-compose build
docker-compose up -d

echo "Containers started successfully!"
echo "  - Frontend: http://localhost:3000"
echo "  - Backend: http://localhost:8080"