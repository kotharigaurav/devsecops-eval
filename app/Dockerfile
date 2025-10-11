FROM node:18-alpine AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci --only=production
COPY . .

# Distroless Image
FROM gcr.io/distroless/nodejs18-debian12
WORKDIR /app
COPY --from=builder /usr/src/app .
USER 1001
EXPOSE 3000
CMD ["server.js"]
