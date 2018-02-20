#!/bin/bash
set -e

source /docker-entrypoint-utils.sh
set_debug
echo "Running as `id`"
 
copy_files "/php-in" "/usr/local/etc/php/conf.d" "*.ini"
copy_files "/php-fpm-in" "/usr/local/etc/php-fpm.d" "*.conf"
copy_files "/roundcube-in" "${WEB_ROOT}/config" "*.php"
sync_dir ${ROUNDCUBE_SRC_DIR} ${WEB_ROOT}

cd "${WEB_ROOT}"
exec "$@"
