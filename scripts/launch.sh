#!/bin/bash

# Load Configuration
source /scripts/toran-proxy/config.sh

# Initilize
source $SCRIPTS_DIRECTORY/install/common.sh
source $SCRIPTS_DIRECTORY/install/toran.sh
source $SCRIPTS_DIRECTORY/install/ssh.sh
source $SCRIPTS_DIRECTORY/install/php.sh
source $SCRIPTS_DIRECTORY/install/nginx.sh

# Log Permissions
chown -R www-data:www-data \
    $DATA_DIRECTORY/logs \

# Start Services
echo "Starting Toran Proxy..."
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
