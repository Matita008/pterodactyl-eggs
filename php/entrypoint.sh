#!/bin/bash
cd /var/www/html

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

cd /home/container

TZ=${TZ:-UTC}
export TZ

mkdir -p /run/php
mkdir -p /var/log/nginx
mkdir -p /var/lib/nginx

chown -R www-data:www-data /home/container

printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mphp -version\n"
php -v

printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0m%s\n" "starting nginx..."
nginx

PARSED=$(echo "${STARTUP:-php-fpm -F}" | sed -e 's/{{/${/g' -e 's/}}/}/g')

printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0m%s\n" "$PARSED"

exec env "${PARSED}"
