# Random Adventure Generator

This repository contains a static front-end prototype and a small optional Node/Express backend that uses MySQL to store adventure prompts.

## What’s in this repo

- `index.html`, `styles.css`, `scripts.js` — front-end prototype
- `Random_Adventure_Generator_Wireframes_and_Mockups.md` — design wireframes and specs
- `backend/` — small Node/Express API and SQL files to run a MySQL-backed service

## Backend (MySQL + Node) — quick start

This project includes a minimal backend to persist and serve adventures via a REST API.

Prerequisites:
- Node.js 18+ (or compatible)
- MySQL server (5.7+ recommended for JSON support, but MySQL 8 is ideal)

Steps:
1. Open a terminal and change into the backend folder:

```powershell
cd "C:\Users\ebooz\Desktop\School\MSSE 667\AdventureGeneratorApp\backend"
```

2. Install dependencies:

```powershell
npm install
```

3. Create a `.env` file from the example and set your DB credentials:

```powershell
copy .env.example .env
# then edit .env and set DB_PASS and any other values
```

4. Initialize the database and seed data. In a MySQL client (MySQL Workbench, command line):

```sql
-- from the backend folder run the SQL files or paste them into your MySQL client
SOURCE schema.sql;
SOURCE seed.sql;
```

Or from a terminal (with mysql client installed):

```powershell
mysql -u root -p < schema.sql
mysql -u root -p < seed.sql
```

5. Start the server:

```powershell
npm start
```

The server will listen on the `PORT` in `.env` (default `3000`). Endpoints:
- `GET /api/adventures` — list all adventures
- `GET /api/adventures?category=Chill` — list adventures in the given category
- `POST /api/adventures` — create a new adventure (body: `{ text, categories: [] }`)

## Front-end changes

`scripts.js` was updated to try the API endpoints first and fall back to a local list if the server is unavailable. No build is required — open `index.html` in a browser. To use the backend, make sure the server is running and that your browser can reach `http://localhost:3000`.

## Notes & next steps

- For production or multi-user scenarios, consider adding authentication, pagination, and sanitation of inputs.
- You may want to move the backend to a separate host or containerize it with Docker.

Docker (optional)

There is a provided `docker-compose.yml` that will start MySQL and the Node backend together for local development. It uses a simple `example` root password — change this in production.

From the project root run:

```powershell
docker-compose up --build
```

The compose file maps:
- MySQL: `3306:3306`
- Backend: `3000:3000`

When the containers are up the backend will be reachable at `http://localhost:3000` and the DB will be pre-created. The compose file is configured to auto-run `schema.sql` and `seed.sql` on the database's first initialization (files are mounted into `/docker-entrypoint-initdb.d/`). The provided `seed.sql` is idempotent — it will not insert duplicates if run multiple times.

If you want, I can:
- Add endpoints for updating/deleting adventures and returning random adventures directly from the API.
