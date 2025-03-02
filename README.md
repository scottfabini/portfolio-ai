# Next.js + Spring Boot Application

This project consists of a Next.js frontend and a Spring Boot backend, containerized with Docker.

## Features

- **Next.js Frontend**: Modern React framework with TypeScript, Tailwind CSS, and App Router
- **Spring Boot Backend**: Java-based backend with REST API, JPA, and H2 database
- **Single Command Development**: Run both frontend and backend with a single command
- **Todo Application**: Simple CRUD application to demonstrate the integration
- **Git Submodules**: Frontend and backend are managed as separate git repositories using submodules

## Prerequisites

- Docker
- Docker Compose
- Node.js (v18 or later)
- Java (JDK 17 or later)
- npm or yarn
- Git

## Getting Started

### Cloning the Repository with Submodules

1. Clone the repository with submodules:
   ```bash
   git clone --recurse-submodules <repository-url>
   cd <project-directory>
   ```

   If you've already cloned the repository without submodules, initialize them with:
   ```bash
   git submodule update --init --recursive
   ```

2. Build and start the containers:
   ```bash
   ./docker-start.sh
   ```

3. Access the application:
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:8080
   - H2 Database Console (if enabled): http://localhost:8080/h2-console

4. Stop the containers:
   ```bash
   docker-compose down
   ```

## Development

### Working with Submodules

The project uses git submodules to manage the frontend and backend codebases separately:

- `frontend/`: Next.js application (submodule)
- `backend/`: Spring Boot application (submodule)

To make changes to a submodule:

1. Navigate to the submodule directory:
   ```bash
   cd frontend  # or cd backend
   ```

2. Make your changes and commit them:
   ```bash
   git add .
   git commit -m "Your commit message"
   git push
   ```

3. Update the main repository to point to the new submodule commit:
   ```bash
   cd ..  # back to the main repository
   git add frontend  # or git add backend
   git commit -m "Update frontend submodule"
   git push
   ```

### Frontend (Next.js)

The frontend is a Next.js application located in the `frontend` directory.

To run it locally:
```bash
cd frontend
npm install
npm run dev
```

To run both frontend and backend together:
```bash
cd frontend
npm run fullstack:dev
```

### Backend (Spring Boot)

The backend is a Spring Boot application located in the `backend` directory.

To run it locally:
```bash
cd backend
./mvnw spring-boot:run
```

## Project Structure

- `frontend/`: Next.js application (git submodule)
  - Contains all JavaScript dependencies and configuration
  - Includes scripts to run both frontend and backend
- `backend/`: Spring Boot application (git submodule)
- `docker-compose.yml`: Docker Compose configuration
- `docker-start.sh`: Script to start the Docker containers with hot-reloading
- `.gitmodules`: Git submodules configuration

## Environment Variables

### Frontend
- `NODE_ENV`: Set to `production` in Docker

### Backend
- `SPRING_PROFILES_ACTIVE`: Set to `docker` in Docker

## Notes

- The frontend communicates with the backend through API calls to `/api/*` endpoints, which are proxied to the backend service.
- The system uses a bridge network for communication between containers.

## Available Scripts

All scripts are now located in the frontend package.json:

- `npm run dev`: Start only the frontend in development mode
- `npm run backend:dev`: Start only the backend in development mode
- `npm run fullstack:dev`: Start both frontend and backend in development mode
- `npm run install:all`: Install dependencies for both frontend and backend
- `npm run fullstack:build`: Build both frontend and backend
- `npm run fullstack:start`: Start both frontend and backend in production mode

## API Endpoints

- `GET /api/hello`: Simple hello world endpoint
- `GET /api/todos`: Get all todos
- `GET /api/todos/{id}`: Get a specific todo
- `POST /api/todos`: Create a new todo
- `PUT /api/todos/{id}`: Update a specific todo
- `DELETE /api/todos/{id}`: Delete a specific todo

## License

MIT 