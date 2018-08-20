NOMINATIM_DIR=$(shell git rev-parse --show-toplevel)
NOMINATIM_DATA_DIR=${NOMINATIM_DIR}/data
COUNTRY=france
IMAGE=marchelbling/nominatim:latest


.PHONY: init
init: build-docker init-data init-db


.PHONY: build-docker
build-docker:
	docker build -t ${IMAGE} .


.PHONY: init-data
init-data:
	mkdir -p ${NOMINATIM_DATA_DIR}
	wget https://download.geofabrik.de/europe/${COUNTRY}-latest.osm.pbf -O ${NOMINATIM_DATA_DIR}/${COUNTRY}.osm.pbf


.PHONY: init-db
init-db:
	docker run -v ${NOMINATIM_DATA_DIR}:/data -t ${IMAGE} sh /app/init.sh /data/${COUNTRY}.osm.pbf postgresdata 8


.PHONY: start
start:
	docker top nominatim >/dev/null 2>&1 || docker run \
														--name nominatim \
														--restart=always \
														-p 6432:5432 \
														-p 7070:8080 \
														--detach \
														-v ${NOMINATIM_DATA_DIR}/postgresdata:/var/lib/postgresql/9.5/main ${IMAGE} \
													sh /app/start.sh


.PHONY: stop
stop:
	docker rm -f nominatim
