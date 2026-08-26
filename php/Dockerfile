FROM debian:11

RUN apt install -y nginx php-fpm
# Required extensions
RUN apt install -y apt install php-{curl,exif,gd,mbstring,mysql,pdo,xml}

RUN adduser -D -h /var/www/html www-data && mkdir -p /var/www/html 

USER        www-data
ENV         USER=www-data HOME=/var/www/html
WORKDIR     /home/container

# Copy entrypoint script
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
