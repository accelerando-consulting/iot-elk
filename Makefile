start:
	docker-compose up -d

stop:
	docker-compose stop

nuke:
	docker-compose down

config:
	@[ -e config.inc ] || ln -s config-dev.inc config.inc
	@[ -e docker-compose.yml ] || ln -s docker-compose-dev.yml docker-compose.yml

setup:  config
	@# For the Dev variant, we run our own elastic and kibana
	@# For the Live variant, we only run logstash (elastic and kibana are in elastic.co cloud cluster)
	@if grep elasticsearch: docker-compose.yml ; then \
	  echo "Starting elasticsearch and kibana." \
	  docker-compose up --build -d elasticsearch ; \
	  echo "Waiting 60s for Elasticsearch first-time startup..." ; \
	  sleep 60 ; \
	else \
	  echo "NOT starting elasticsearch (use cloud.elastic.co instead)." ; \
	fi
	@echo "Inserting metadata into Elasticsearch..."
	@./populate.sh
	@echo "Starting logstash to populate index."
	docker-compose up --build -d logstash
	docker-compose up -d kibana
	@echo "Now open http://elastic:changeme@localhost:5601/ and configure index pattern data-*"
