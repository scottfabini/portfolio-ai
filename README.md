# Portfolio AI

A modern portfolio website built with Next.js, featuring:

- Interactive sections for About, Projects, Experiments, and Experience
- Responsive design for all device sizes
- Clean, professional styling with Tailwind CSS
- Smooth scrolling navigation
- Dark/light mode support

## Technologies Used

- Next.js
- React
- Tailwind CSS
- TypeScript
- Spring Boot (Backend API)
- Docker

## Features

- **Intro Section**: Engaging introduction with background image and download resume button
- **About Section**: Professional summary and background information
- **Projects Section**: Showcase of development projects with images, tags, and links
- **Experiments Section**: Highlight of experimental projects and technologies
- **Experience Section**: Professional experience timeline with detailed responsibilities
- **Todo App**: Integrated Todo application with full functionality

## Development

This portfolio was developed with the assistance of AI tools to streamline the development process and showcase modern web development practices.

## Getting Started

### Using Docker (Recommended)

The easiest way to start both the frontend and backend services:

```bash
# Make the script executable (if needed)
chmod +x ./docker-start.sh

# Start the complete application (frontend and backend)
./docker-start.sh
```

This will start:
- Frontend at [http://localhost:3000](http://localhost:3000)
- Backend API at [http://localhost:8080](http://localhost:8080)

### Manual Setup

```bash
# Install dependencies
npm install

# Run the development server
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result. 