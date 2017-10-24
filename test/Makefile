include ../utils/Makefile.help
include ../utils/Makefile.functions

export NAME := roundcube
export ROOT_DIR := $(shell realpath ./root)
export NGINX_CONF_DIR := $(shell realpath ./nginx-in)
export ROUNDCUBE_CONF_DIR := $(shell realpath ./roundcube-in)

test: setup ##@targets Starts docker compose.
	echo $$NAME
	docker-compose -p ${NAME} -f test.yaml up
.PHONY: test

clean: rm ##@targets Removes docker containers and created files.
	rm $(ROUNDCUBE_CONF_DIR)/config.inc.php
	if [ -d $(ROOT_DIR) ]; then \
	sudo rm -rf $(ROOT_DIR); \
	fi
.PHONY: clean

rm: ##@targets Removes docker containers.
	docker-compose -p ${NAME} -f test.yaml stop
	docker-compose -p ${NAME} -f test.yaml rm -f
.PHONY: rm

setup: $(ROUNDCUBE_CONF_DIR)/config.inc.php
	mkdir -p $(ROOT_DIR)/html
	mkdir -p $(ROOT_DIR)/bitnami/mariadb
	sudo chmod o+rwX $(ROOT_DIR)/html
	sudo chmod o+rwX $(ROOT_DIR)/bitnami/mariadb
.PHONY: setup

$(ROUNDCUBE_CONF_DIR)/config.inc.php:
	mkdir -p $(ROUNDCUBE_CONF_DIR)
	echo "<?php" > $@
	echo "\$$config = [];" >> $@
	echo "\$$config['log_driver'] = 'file';" >> $@
	echo "\$$config['db_dsnw'] = 'sqlite:////var/www/html/db/roundcube.db?mode=0640';" >> $@
	echo "\$$config['des_key'] = 'Change_me_I_am_example!!';" >> $@
	echo "\$$config['plugins'] = [" >> $@
	echo "'archive'," >> $@
	echo "'zipdownload'," >> $@
	echo "];" >> $@
