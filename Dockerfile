#
# Nginx/Node/PHP with LocalTunnel Alpine for The Website Nursery Ports 80 for localtunnel
#

FROM nginx:alpine

MAINTAINER thewebsitenursery <hello@thewebsitenursery.com>

# CREATE DIRECTORY FOR WSN
RUN mkdir -p /var/webapps

# Update and install base packages
RUN apk update && apk upgrade && apk add curl wget bash build-base nodejs

# Clean APK cache
RUN rm -rf /var/cache/apk/*

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
ADD nginx.conf /etc/nginx/

# Remove Default index.html from HTML Server Root
RUN rm -v /usr/share/nginx/html/index.html

# Copy WSN Welcome index.html to webroot
ADD index.html /usr/share/nginx/html/

# Create wsntunnel binary & deamon off nginx

RUN touch "wsntunnel" >> /usr/local/bin/wsntunnel
RUN echo '#!/bin/sh' >> /usr/local/bin/wsntunnel
RUN echo 'lt -s thewsn -p 80' >> /usr/local/bin/wsntunnel
RUN chmod a+rx /usr/local/bin/wsntunnel

# Update NPM

RUN npm update -g npm

# Install LocalTunnel

RUN npm install -g localtunnel

#VOLUMES

VOLUME ["/home/alistair/webapps:/var/webapps"]

# Expose port XX
EXPOSE 5580 80 443
CMD ["nginx"] ["-g"] ["deamon off"]
