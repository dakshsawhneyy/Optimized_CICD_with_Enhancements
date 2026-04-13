FROM node:18 AS builder
WORKDIR /app

# Optimization Thing
COPY package*.json .
RUN npm install
COPY . .

# Stage 2 
FROM node:18-alpine    
WORKDIR /app

COPY --from=builder /app /app

# Creating a Non Root User
RUN addgroup appgroup && adduser -S appuser -G appgroup
USER appuser

# Running the application
CMD ["node", "app.js"]
