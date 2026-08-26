FROM debian:11

# update packages index
RUN apt-get update

RUN apt install -y nginx php-fpm
# Required extensions
RUN apt-get install -y \
    php-curl \
    php-exif \
    php-gd \
    php-mbstring \
    php-mysql \
    php-pdo \
    php-xml

RUN apt-get install -y iproute2 ca-certificates bash

RUN mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html

ENV         USER=www-data HOME=/var/www/html
WORKDIR     /var/www/html

# Copy entrypoint script
COPY --chown=www-data:www-data ./entrypoint.sh /entrypoint.sh
USER root
CMD ["/bin/bash", "/entrypoint.sh"]
