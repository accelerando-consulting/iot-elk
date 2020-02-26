
# IoT data pipeline

1. Sensor data transmitted via MQTT
2. Logstash consumes MQTT input (augments events with site/sensor data such as geolocation)
3. Elasticsearch data lake
4. [optional] Serverless API, S3-hosted web interface
5. [optional] kafka or kinesis for sending alerts onward or processing events

# Production setup

1. Sensors communicate via WiFi or LPWAN
2. On-site concentrator
3. Site concentrator relays to MQTT (or sensors may go direct)
4. Mosquitto in docker on EC2 instance 
5. Logstash in docker on EC2 instance 
6. Elasticsearch hosted by cloud.elastic.co or on AWS

The docker-compose-live.yml file sets up components 2+3

# Development setup

1. Dev Sensors transmit direct to MQTT (skip LPWAN)
2. Mosquitto in docker
3. Logstash in docker
4. Elasticsearch in docker
5. Kibana in docker

The docker-compose.yml file sets up components 2,3,4,5

## Setup instructions

Search for 'example.com' and replace any instances with your names.

Just run "make setup".

### Setup explanation

The "make setup" target does the below steps:

1. Start the data components

```
docker-compose up -d  elasticsearch kibana broker
docker-compose logs -f
```

2. Wait until elasticsearch is running

Look for "kibana | ...Status changed from yellow to green - Ready""

3. Import configuration data

for s in scripts/*.sh ; do $s localhost ; done

4. Start the importer (which needs the above config)

```
docker-compose up -d logstash
```

5. Navigate to localhost:5601 and conifigure kibana for index pattern "data-*"


## Subsequent use instructions

Once the configuration import is done in your elastic docker, 
you can start and stop the whole enchilada with `make start` and `make stop`

# Populating a real (elastic cloud) elasticsearch 

(password 'changeme' is a placeholder for actual password)

('eshost' is a placeholder for the hostname of the ES server)

```
. config.inc && for cript in scripts/* ; do $cript ; done
```


