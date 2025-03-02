#!/bin/bash

# Stop any running containers
echo "Stopping any running containers..."
docker-compose down

# Build and start the containers
echo "Building and starting containers with hot-reloading..."
docker-compose up --build

# To run in detached mode, uncomment the following line:
# docker-compose up --build -d

echo "Containers are starting..."
echo "Frontend will be available at: http://localhost:3000"
echo "Backend API will be available at: http://localhost:8080"
echo "H2 Database Console (if enabled): http://localhost:8080/h2-console"

echo "To view logs, run: docker-compose logs -f"
echo "To stop containers, run: docker-compose down" 