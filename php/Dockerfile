FROM php:8.3-fpm-bookworm

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

RUN apt-get update && \
    apt install -y --no-install-recommends \
        nginx \
        curl \
        ca-certificates \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libzip-dev \
        libicu-dev
RUN docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg 
RUN docker-php-ext-install -j"$(nproc)" \
        gd \
        mysqli \
        pdo \
        pdo_mysql \
        mbstring \
        exif \
        xml \
        zip \
        opcache

# PHP configuration
RUN { \
        echo 'memory_limit=256M'; \
        echo 'upload_max_filesize=64M'; \
        echo 'post_max_size=64M'; \
        echo 'max_execution_time=120'; \
        echo 'max_input_vars=5000'; \
        echo 'date.timezone=UTC'; \
    } > /usr/local/etc/php/conf.d/nameless.ini

# Create Pterodactyl application directory
RUN mkdir -p /home/container && chown -R www-data:www-data /home/container

# remove default nginx config
RUN rm -f /etc/nginx/sites-enabled/default

COPY nginx.conf /etc/nginx/conf.d/nameless.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
RUN chmod +x /etc/nginx/conf.d/nameless.conf

WORKDIR /home/container

CMD ["/bin/bash", "/entrypoint.sh"]
