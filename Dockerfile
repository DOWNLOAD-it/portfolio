# syntax=docker/dockerfile:1
ARG NODE_VERSION=20.12.1

# 1. Base Image 
FROM node:${NODE_VERSION}-slim as base
WORKDIR /usr/src/app

# 2. Dependencies Stage
FROM base as deps
# Replaced bind mounts with standard COPY so the files are writable
COPY package.json package-lock.json ./
RUN --mount=type=cache,target=/root/.npm \
    npm ci --omit=dev

# 3. Build Stage
FROM deps as build
# Replaced bind mounts with standard COPY
COPY package.json package-lock.json ./
RUN --mount=type=cache,target=/root/.npm \
    npm ci
COPY . .
RUN npm run build

# 4. Final Stage (Production)
FROM base as final
ENV NODE_ENV production
USER node
COPY package.json .
COPY --from=deps /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/build ./build

# Expose port 3000 and start the application
EXPOSE 3000
CMD npx serve -s build -l 3000