#!/bin/bash
cd /var/www/html

# Replace Pterodactyl startup variable placeholders
MODIFIED_STARTUP=$(echo -e "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g')

# Execute startup command passed by the egg
eval ${MODIFIED_STARTUP}
