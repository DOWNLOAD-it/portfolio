# syntax=docker/dockerfile:1
ARG NODE_VERSION=20.12.1

# 1. Image de base
FROM node:${NODE_VERSION}-alpine as base
WORKDIR /usr/src/app

# 2. Étape des dépendances (optimisée avec le cache Docker)
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
ENV NODE_ENV production
USER node
COPY package.json .
COPY --from=deps /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/build ./build

# Exposition du port 3000 et lancement de l'application
EXPOSE 3000
CMD npx serve -s build -l 3000