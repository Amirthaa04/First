# FROM ubuntu:22.04

# RUN apt-get update

# RUN apt-get install -y nginx zip curl

# RUN echo "daemon off;" >>/etc/nginx/nginx.conf

# RUN curl -o /var/www/html/master.zip -L https://github.com/gabrielecirulli/2048.git


# RUN cd /var/www/html && unzip master.zip && mv 2048-master/* . && rm -rf 2048-master master.zip


# EXPOSE 80

# CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]

# Use Ubuntu as the base image
FROM ubuntu:22.04

# Update package list and install necessary dependencies
RUN apt-get update && apt-get install -y nginx zip curl git

# Configure Nginx to run in the foreground
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Ensure the directory is empty before cloning the repository
RUN rm -rf /var/www/html/*

# Download the 2048 game from GitHub and move it to the correct directory
RUN git clone https://github.com/gabrielecirulli/2048.git /tmp/2048 && mv /tmp/2048/* /var/www/html/ && rm -rf /tmp/2048

# Expose port 80 for web access
EXPOSE 80

# Start Nginx when the container runs
CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]
