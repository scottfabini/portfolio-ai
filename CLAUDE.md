# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

### Frontend (`frontend/`)
```bash
npm run dev          # Dev server (http://localhost:3000)
npm run build        # Production build (static export to /out)
npm run lint         # ESLint
npm run update-env   # Regenerate public/env-config.js with API URL
```

### Backend (`backend/`)
```bash
mvn spring-boot:run          # Run locally (http://localhost:8080)
mvn clean install            # Full build with tests
mvn clean package -DskipTests  # Build only
```

### Full stack
```bash
docker-compose up   # frontend :3000, backend :8080, MySQL :3306
```

### Single test
```bash
# Frontend
cd frontend && npx jest path/to/test.test.ts

# Backend
cd backend && mvn test -Dtest=TestClassName
```

## Architecture

This is a monorepo: Next.js 14 frontend + Spring Boot 3.2 backend + MySQL.

### Frontend

- **App Router** (`app/`): layouts and pages
- **Components** (`components/`): client components use `'use client'` directive
- **Static export**: `next.config.js` sets `output: 'export'` — no SSR, purely static files served via CDN
- **Runtime API URL**: Because it's static, API URL can't be baked in at build time. `scripts/update-env.js` writes `public/env-config.js`, which gets injected into `index.html` before React hydrates. At runtime, components read `window.ENV.NEXT_PUBLIC_API_URL` via the `getApiUrl()` helper.

### Backend

Thin controller → service layer → JPA repository.

- `@CrossOrigin(origins = "*")` on controllers (permissive CORS for dev)
- Entities use Lombok `@Data`; prefer **records** for new DTOs
- `spring.jpa.hibernate.ddl-auto=update` — schema auto-migrates on startup (be careful with breaking column changes)
- Timestamps managed in `TodoService` using `LocalDateTime`

### Deployment (AWS Amplify)

Frontend and backend are deployed as **separate Amplify apps**. Each has its own `amplify.yml` and `amplify-build.sh`. The root `amplify.yml` rewrites `/api/*` → backend domain. Key env var: `NEXT_PUBLIC_API_URL` must be set in the Amplify frontend console.
