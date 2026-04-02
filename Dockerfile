# syntax=docker/dockerfile:1
ARG NODE_VERSION=20.12.1

# 1. Image de base
FROM node:${NODE_VERSION}-slim as base
WORKDIR /usr/src/app

# 2. Dependencies Stage
# We MUST install dependencies, or 'npm run build' won't work.
FROM base as deps
COPY package.json package-lock.json ./
RUN --mount=type=cache,target=/root/.npm \
    npm install --omit=dev --ignore-scripts --legacy-peer-deps

# 3. Build Stage
FROM deps as build
# Copy the rest of the source code (src, public, etc.)
COPY . .
# Now that code AND node_modules exist, we can build
RUN npm run build

# 4. Final Stage (Production)
FROM base as final
ENV NODE_ENV production
USER node

# Copy only the necessary production files
COPY package.json .
COPY --from=deps /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/build ./build

# Exposition du port 3000 et lancement
EXPOSE 3000
CMD npx serve -s build -l 3000