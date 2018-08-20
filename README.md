# Nominatim 3.1.0 Docker

Refer to [mediagis doc](https://github.com/mediagis/nominatim-docker/tree/master/3.1) for more details.

## Requirements

* Docker
* Make


## Usage:

* initialize environment (build docker image, fetch country data — France by default —, load osm in PostgreSQL):
```
$ make init
```

* start server:
```
$ make start
```

* stop server:
```
$ make stop
```
