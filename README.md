## docker-icecast-kh

This is fork of https://github.com/fcqpl/docker-icecast-kh repo, but with icecast-kh.


[![Build Status](https://img.shields.io/github/actions/workflow/status/fcqpl/docker-icecast-kh/docker-publish.yml?branch=main)](https://github.com/fcqpl/docker-icecast-kh/actions/workflows/docker-publish.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/fcqpl/icecast-kh)](https://hub.docker.com/r/fcqpl/icecast-kh)
[![Docker Image Size](https://img.shields.io/docker/image-size/fcqpl/icecast-kh/latest)](https://hub.docker.com/r/fcqpl/icecast-kh)
[![License](https://img.shields.io/github/license/fcqpl/docker-icecast-kh)](https://github.com/fcqpl/docker-icecast-kh/blob/master/LICENSE)

Simple Dockerfile for running [icecast2](https://icecast.org/) in a container. \
Just mount your icecast.xml file and you are good to go!

Works well with containerized [Liquidsoap](https://www.liquidsoap.info/): [pltnk/docker-liquidsoap](https://github.com/pltnk/docker-liquidsoap)

### Installation
- Pull the image from one of public Docker registries
  - Docker Hub `docker pull fcqpl/icecast-kh`

### Configuration
- Mount your icecast.xml to `/etc/icecast2/icecast.xml`
- Publish necessary ports

#### docker run
```
docker run --name icecast2 -d --restart=always \
--publish 8000:8000 \
--volume /path/to/your/icecast.xml:/etc/icecast2/icecast.xml \
fcqpl/icecast-kh
```
#### docker-compose.yml
```
icecast2:
  image: fcqpl/icecast-kh
  container_name: icecast2
  restart: always
  ports:
    - 8000:8000
  volumes:
    - /path/to/your/icecast.xml:/etc/icecast2/icecast.xml
```
