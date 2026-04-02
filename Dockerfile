# syntax=docker/dockerfile:1
ARG NODE_VERSION=20.12.1

# 1. Image de base (Switched to slim to ensure build tools are available)
FROM node:${NODE_VERSION}-slim as base
WORKDIR /usr/src/app

# 2. Étape des dépendances (Production only)
FROM base as deps
RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci --omit=dev

# 3. Étape de build
FROM deps as build
RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci
COPY . .
RUN npm run build

# 4. Étape finale (Production)
FROM base as final
ENV NODE_ENV=production

# Copy files and explicitly grant ownership to the non-root 'node' user
COPY --chown=node:node package.json .
COPY --chown=node:node --from=deps /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/build ./build

# Switch to the non-root user for execution
USER node

EXPOSE 3000

# Exec form CMD allows proper handling of shutdown signals (SIGTERM)
CMD ["npx", "serve", "-s", "build", "-l", "3000"]