FROM node:20-slim

# Create app directory
WORKDIR /app

# Copy package files first to leverage Docker cache for installs
COPY package*.json ./

# Use deterministic install when a lockfile is present, otherwise install production deps
# Avoid running `npm audit fix --force` during image build as it can upgrade packages
# unexpectedly and introduce breaking changes. Instead produce a reproducible image
# by using package-lock.json (commit it) and `npm ci`.
RUN if [ -f package-lock.json ]; then \
			npm ci --omit=dev; \
		else \
			npm install --omit=dev; \
		fi

# Copy app source
COPY . .

# Run as non-root for better security (create app user and own files)
# Debian-based images use groupadd/useradd
RUN groupadd -r app && useradd -r -g app -d /app -s /bin/false app && chown -R app:app /app
USER app

EXPOSE 3000
CMD ["node", "server.js"]
