# syntax=docker/dockerfile:1
ARG NODE_VERSION=20.12.1

# 1. Base Image 
FROM node:${NODE_VERSION}-slim as base
WORKDIR /usr/src/app

# 2. Build Stage (No installation)
FROM base as build
COPY . .
# This will crash here unless node_modules is copied over from your repo
RUN npm run build

# 3. Final Stage (Production)
FROM base as final
ENV NODE_ENV production
USER node
COPY package.json .
COPY --from=build /usr/src/app/build ./build

# Expose port 3000 and start the application
EXPOSE 3000
CMD npx serve -s build -l 3000