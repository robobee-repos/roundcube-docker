#!/bin/bash
set -e

if [[ "$DEBUG" == "true" ]]; then
  set -x
fi

function check_files_exists() {
  ls $1 1> /dev/null 2>&1
}

function copy_file() {
  file="$1"; shift
  dir="$1"; shift
  mod="$1"; shift
  if [ -e "$file" ]; then
    mkdir -p "$dir"
    cp "$file" "$dir/$file"
    chmod $mod "$dir/$file"
  fi
}

function copy_php_conf() {
  dir="/php-in"
  if [ ! -d "${dir}" ]; then
    return
  fi
  cd "${dir}"
  if ! check_files_exists "*.ini"; then
    return
  fi
  rsync -vL ${dir}/*.ini /usr/local/etc/php/conf.d/
 }
 
function copy_php_fpm_conf() {
  dir="/php-fpm-in"
  if [ ! -d "${dir}" ]; then
    return
  fi
  cd "${dir}"
  if ! check_files_exists "*.conf"; then
    return
  fi
  rsync -vL ${dir}/*.conf /usr/local/etc/php-fpm.d/
 }
 
function copy_roundcube() {
  dir="/roundcube-in"
  if [ ! -d "${dir}" ]; then
    return
  fi
  cd "${dir}"
  if ! check_files_exists "*.php"; then
    return
  fi
  rsync -vL ${dir}/*.php "${WEB_ROOT}/config/"
}

function sync_roundcube() {
  cd "${WEB_ROOT}"
  rsync -rlD -u ${ROUNDCUBE_SRC_DIR}/. .
}

echo "Running as `id`"

copy_php_conf
copy_php_fpm_conf
copy_roundcube
sync_roundcube

cd "${WEB_ROOT}"
exec "$@"
