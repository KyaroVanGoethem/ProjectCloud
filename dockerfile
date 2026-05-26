FROM node:20-alpine AS builder
WORKDIR /app
COPY ./ProjectCloud/package*.json ./
RUN npm ci
COPY ./tsconfig.json ./
COPY ./ProjectCloud/ ./
RUN npx tsc --rootDir ./ --outDir ./dist

FROM node:20-alpine
WORKDIR /app
COPY ./ProjectCloud/package*.json ./
RUN npm ci --only=production
COPY --from=builder /app/dist ./dist

# Kopieer de views map handmatig mee naar de dist map
COPY ./ProjectCloud/views ./dist/views

EXPOSE 3000
CMD ["node", "dist/index.js"]
