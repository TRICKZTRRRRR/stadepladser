# Stage 1: Build the Angular app
FROM node:latest AS build

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./
RUN npm ci
RUN npm install -g @angular/cli

# Copy the rest of the Angular source code
COPY . .

# Build the Angular app for production
RUN npm run build --configuration=production

# Stage 2: Serve the Angular app using Nginx
FROM nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf

# Copy the built Angular app from /app/dist/portfolio (build stage) to Nginx's web directory
COPY --from=build /app/dist/stadepladser/browser /usr/share/nginx/html

EXPOSE 80