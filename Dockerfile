# Use official Nginx image
FROM nginx:alpine

# Copy application files to Nginx web directory
COPY src/ /usr/share/nginx/html/

# Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
