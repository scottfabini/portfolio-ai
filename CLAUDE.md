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
docker-compose up   # frontend :3000, backend :8080
```

### Single test
```bash
# Frontend
cd frontend && npx jest path/to/test.test.ts

# Backend
cd backend && mvn test -Dtest=TestClassName
```

## Architecture

This is a monorepo: Next.js 14 frontend + Spring Boot 3.2 backend (currently a bare shell with no endpoints or database).

### Frontend

- **App Router** (`app/`): layouts and pages
- **Components** (`components/`): client components use `'use client'` directive
- **Static export**: `next.config.js` sets `output: 'export'` — no SSR, purely static files served via CDN
- **Todo demo is client-side**: `/todo` stores data in SQLite compiled to WASM (`@sqlite.org/sqlite-wasm`), persisted in OPFS via the `opfs-sahpool` VFS, falling back to in-memory. The DB lives in a Web Worker (`lib/todoDb.worker.ts`, client in `lib/todoDb.ts`). `scripts/copy-sqlite-wasm.js` (run by `predev`/`prebuild`) copies `sqlite3.wasm` into `public/` (gitignored). Schema changes go through the ordered `MIGRATIONS` array in the worker, tracked by `PRAGMA user_version` (append new entries, never edit old ones). Rows are ordered by a `position` column that drag-and-drop (`@dnd-kit`) rewrites via the `reorder` op. The sahpool VFS allows one connection, so a second open tab falls back to in-memory.

### Backend

Spring Boot 3.2 web app with no controllers, entities or datasource. Todo logic was removed when the demo moved into the browser. Add JPA and a database dependency back if a real API is needed again.

### Deployment (AWS Amplify)

Frontend and backend are deployed as **separate Amplify apps**. Each has its own `amplify.yml` and `amplify-build.sh`. The live site is built from the **parent repo** using the root `amplify.yml`, which is where the COOP/COEP headers (needed for the todo's OPFS VFS) must live; `frontend/amplify.yml` is not used by that build. The frontend needs no env vars or backend, so the backend Amplify app can be retired.

`frontend/` and `backend/` are git submodules of this parent repo. Any content/code change requires two commits: one inside the submodule (`cd frontend && git commit && git push`), then one in the parent repo to bump the submodule pointer.

**Amplify deploy lag**: after pushing, the live site can lag behind `origin/main` for a few minutes while Amplify builds. If the site looks stale right after a push, check `git log origin/main` (confirms the push landed) and `WebFetch` the live URL (bypasses browser cache) before assuming something's broken — it's usually just an unfinished build, not a caching or git issue.

### Homepage content (`frontend/components/`)

Section order is set in `app/page.tsx` (hook → proof → depth: Hero, About, Skills, Experience, Projects, Education). `Experience.tsx`, `About.tsx`, and `Skills.tsx` should stay in sync with the resume source of truth (`resume.tex` / `Scott_Fabini_Resume.md`) — but the website doesn't need full parity; it can scope to a subset of skills/bullets for pithiness.
