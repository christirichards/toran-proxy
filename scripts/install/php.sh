#!/bin/bash

echo "Configuring PHP..."

# Config PHP Timezone
sed -i "s|;date.timezone =.*|date.timezone = ${PHP_TIMEZONE}|g" /etc/php/7.0/fpm/php.ini
sed -i "s|;date.timezone =.*|date.timezone = ${PHP_TIMEZONE}|g" /etc/php/7.0/cli/php.ini

# Logs
mkdir -p $DATA_DIRECTORY/logs/php-fpm
mkdir -p $DATA_DIRECTORY/logs/php-cli
sed -i "s|;error_log = php_errors.log|error_log = ${DATA_DIRECTORY}/logs/php-fpm/errors.log|g" /etc/php/7.0/fpm/php.ini
sed -i "s|;error_log = php_errors.log|error_log = ${DATA_DIRECTORY}/logs/php-cli/errors.log|g" /etc/php/7.0/cli/php.ini
