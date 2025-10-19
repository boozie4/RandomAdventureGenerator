FROM node:20.12.2-slim

# Use a stable working directory
WORKDIR /usr/src/app

# Set production environment to avoid installing dev deps unintentionally
ENV NODE_ENV=production

# Copy package files first to leverage Docker cache for installs
COPY package*.json ./

# Deterministic install: use package-lock.json when present, otherwise install production deps
# Do not run `npm audit fix --force` during build - handle auditing and upgrades separately.
RUN if [ -f package-lock.json ]; then \
      npm ci --omit=dev --no-audit --no-fund; \
    else \
      npm install --omit=dev --no-audit --no-fund; \
    fi

# Copy rest of application
COPY . .

# Create a non-root user and set proper permissions
RUN groupadd -r app && useradd -r -g app -d /usr/src/app -s /usr/sbin/nologin app && chown -R app:app /usr/src/app
USER app

EXPOSE 3000
CMD ["node", "server.js"]
