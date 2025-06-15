# Use official Nginx image to serve web content
FROM nginx:alpine

# Remove the default nginx index page
RUN rm -rf /usr/share/nginx/html/*

# Copy the Flutter web build to nginx's public folder
COPY build/web /usr/share/nginx/html

# Copy a custom nginx configuration file if needed (optional)
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 8080

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]

