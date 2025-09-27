# Stage 1: Build frontend
FROM node:22-alpine AS build-frontend
WORKDIR /app
COPY ../lba/package*.json ./
RUN npm install
COPY ../lba ./
RUN npm run build

# Stage 2: Build backend
FROM node:22-alpine AS build-backend
WORKDIR /app
COPY ../lbaws/package*.json ./
RUN npm install
COPY ../lbaws ./
RUN npm run build

# Stage 3: Runtime finale
FROM node:22-alpine
WORKDIR /app
COPY ../lbaws/package*.json ./
RUN npm install --omit=dev
COPY --from=build-backend /app/dist ./dist
COPY --from=build-backend /app/node_modules/@prisma ./node_modules/@prisma
COPY --from=build-backend /app/node_modules/.prisma ./node_modules/.prisma
COPY --from=build-frontend /app/dist/lba ./dist/public
CMD ["node", "dist/index.js"]
