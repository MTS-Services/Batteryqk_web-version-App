# Use the latest Flutter image that supports Dart SDK >= 3.7.2
FROM instrumentisto/flutter:latest AS builder

# Set working directory for the build
WORKDIR /app

# Configure Git locally to avoid 'dubious ownership' issues with Flutter SDK
RUN git config --global --add safe.directory /sdks/flutter

# Copy the Flutter project into the container
COPY . .

# Get Flutter dependencies
RUN flutter pub get

# Build the Flutter web app
RUN flutter build web

# Use Nginx Alpine image for serving the app
FROM nginx:alpine

# Remove the default Nginx HTML content
RUN rm -rf /usr/share/nginx/html/*

# Copy the build output from the Flutter build stage to the Nginx HTML folder
COPY --from=builder /app/build/web /usr/share/nginx/html

# Copy custom Nginx configuration (if needed)
COPY nginx.conf /etc/nginx/nginx.conf

# Expose the web server port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
