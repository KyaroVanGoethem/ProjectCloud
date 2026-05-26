FROM node:20-alpine AS builder
WORKDIR /app
COPY ./ProjectCloud/package*.json ./
RUN npm ci
COPY ./ProjectCloud/ ./
COPY ./tsconfig.json ./
RUN npm run build

FROM node:20-alpine
WORKDIR /app
COPY ./ProjectCloud/package*.json ./
RUN npm i

EXPOSE 3000
CMD ["node", "dist/index.js"]
