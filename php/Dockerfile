FROM php:8.3-fpm-bookworm

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install Nginx and required system libraries
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        nginx \
        curl \
        ca-certificates \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libzip-dev \
        libicu-dev \
        && \
    docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
        && \
    docker-php-ext-install -j"$(nproc)" \
        gd \
        mysqli \
        pdo \
        pdo_mysql \
        mbstring \
        exif \
        xml \
        zip \
        opcache \
        && \
    rm -rf /var/lib/apt/lists/*

# PHP configuration
RUN { \
        echo 'memory_limit=256M'; \
        echo 'upload_max_filesize=64M'; \
        echo 'post_max_size=64M'; \
        echo 'max_execution_time=120'; \
        echo 'max_input_vars=5000'; \
        echo 'date.timezone=UTC'; \
    } > /usr/local/etc/php/conf.d/nameless.ini

# Configure PHP-FPM to listen on TCP localhost
RUN sed -i 's|^listen = .*|listen = 127.0.0.1:9000|' \
    /usr/local/etc/php-fpm.d/www.conf

# Create Pterodactyl application directory
RUN mkdir -p /home/container && \
    chown -R www-data:www-data /home/container

# Download NamelessMC 2.2.5
RUN curl -fL \
    "https://github.com/NamelessMC/Nameless/releases/download/v2.2.5/nameless-deps-dist.tar.xz" \
    -o /tmp/nameless.tar.xz && \
    tar -xJf /tmp/nameless.tar.xz -C /home/container && \
    rm /tmp/nameless.tar.xz && \
    chown -R www-data:www-data /home/container

# Nginx
RUN rm -f /etc/nginx/sites-enabled/default

COPY nginx.conf /etc/nginx/conf.d/nameless.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

WORKDIR /home/container

EXPOSE 8080

CMD ["/bin/bash", "/entrypoint.sh"]
