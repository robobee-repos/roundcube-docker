# Roundcube-Docker

## Description

Packages the Roundcubemail as a docker container. It is based on the docker
image [instrumentisto/roundcube](https://hub.docker.com/r/instrumentisto/roundcube/).
This image does not require root or any additional privileges to run and can
be deployed in OpenShift. Per default sqlite is configured as the database
backend, but the image comes with MySQL and PostgreSQL libraries installed.

## Environment Parameters

| Variable | Default | Description |
| ------------- | ------------- | ----- |
| PHP_MAX_EXECUTION_TIME  | 300 | max_execution_time |
| PHP_MEMORY_LIMIT_MB | 128 | memory_limit |
| PHP_FPM_MAX_CHILDREN | 10 | pm.max_children |
| PHP_FPM_START_SERVERS | 2 | pm.start_servers |
| PHP_FPM_MIN_SPARE_SERVERS | 2 | pm.min_spare_servers |
| PHP_FPM_MAX_SPARE_SERVERS | 5 | pm.max_spare_servers |
| PHP_FPM_MAX_REQUESTS | 500 | pm.max_requests |
| PHP_FPM_REQUEST_SLOWLOG_TIMEOUT | 30s | request_slowlog_timeout |
| PHP_FPM_CATCH_WORKERS_OUTPUT | 1 | catch_workers_output |
| PHP_OPCACHE_ENABLE_CLI | 1 | opcache.enable_cli |
| PHP_OPCACHE_ENABLE | 1 | opcache.enable |
| PHP_OPCACHE_MEMORY_CONSUMPTION_MB | 128 | opcache.memory_consumption |

## Exposed Ports

| Port | Description |
| ------------- | ----- |
| 9000  | php-fpm |

## Directories

| Path | Description |
| ------------- | ----- |
| /var/www/html  | www-root directory. |

## Input Configration

| Source | Destination |
| ------------- | ------------- |
| /php-in/*.ini | /usr/local/etc/php/ |
| /php-fpm-in/*.conf | /usr/local/etc/php-fpm.d/ |
| /roundcube-in/*.php | /var/www/html/config/ |

## Test

The docker-compose file `test.yaml` can be used to startup the container and
Roundcube should be available at `localhost:8080`.

```
docker-compose -f test.yaml up
```

## Optimize php-fpm

 ```
find /var/www/html -iname *.php|wc -l
 ```
