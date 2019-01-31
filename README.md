[![Build Status](https://travis-ci.org/marcosvrs/rpi-home-assistant.svg?branch=master)](https://travis-ci.org/marcosvrs/rpi-home-assistant)
[![Docker Version](https://images.microbadger.com/badges/version/marcosvrs/rpi-home-assistant.svg)](https://hub.docker.com/r/marcosvrs/rpi-home-assistant/)
[![PyPI homeassistant version](https://img.shields.io/pypi/v/homeassistant.svg?label=PyPI%20homeassistant&style=flat)](https://pypi.org/project/homeassistant/)

# Home Assistant Docker image for Raspberry Pi

## Simple usage
`docker run -d --name hass -v /etc/localtime:/etc/localtime:ro marcosvrs/rpi-home-assistant:latest`

## Additional parameters
### Persistent configuration
Create a folder where you want to store your Home Assistant configuration (/home/pi/home-assistant/configuration for example) and add this data volume to the container using the `-v` flag.

`docker run -d --name hass -v /etc/localtime:/etc/localtime:ro -v /home/pi/home-assistant/configuration:/config marcosvrs/rpi-home-assistant:latest`

### Enable uPnP discovery
In order to enable the discovery feature (for devices such as Google Chromecasts, Belkin WeMo switches, Sonos speakers, ...) Home Assistant must run on the same network as the devices. The `--net=host` Docker option is needed.

`docker run -d --name hass --net=host -v /etc/localtime:/etc/localtime:ro marcosvrs/rpi-home-assistant:latest`

## Usage
### One-liner
`docker run -d --name hass --net=host -v /etc/localtime:/etc/localtime:ro -v /home/pi/home-assistant/configuration:/config marcosvrs/rpi-home-assistant:latest`

### With Docker Compose

```yml
# docker-compose.yml
hass:
  container_name: hass
  image: marcosvrs/rpi-home-assistant:latest
  net: host
  volumes:
    - /home/pi/home-assistant/configuration:/config
    - /etc/localtime:/etc/localtime:ro
```

`docker-compose run -d --service-ports hass`

## References
* [Setup a simple CI pipeline to build Docker images for ARM - Hypriot](https://blog.hypriot.com/post/setup-simple-ci-pipeline-for-arm-images/)
* [lroguet Repository](https://github.com/lroguet/rpi-home-assistant)

## Links
* [Docker public repository](https://hub.docker.com/r/marcosvrs/rpi-home-assistant/)
* [Home Assistant](https://home-assistant.io/)
