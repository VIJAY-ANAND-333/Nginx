# Use the official Nginx base image
FROM nginx:latest

# Copy custom index.html file to the container
COPY index.html /usr/share/nginx/html/index.html

# Expose the HTTP port
EXPOSE 80

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
