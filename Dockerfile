FROM resin/rpi-raspbian:stretch
LABEL maintainer="Marcos V. Rubido <docker@marcosvrs.com>"

# Base layer
ENV ARCH=arm
ENV CROSS_COMPILE=/usr/bin/

# Install some packages
# #1:   20190130 - Added python3, python3-venv, python3-pip, libffi-dev, python3-dev and python3-setuptools for https://www.home-assistant.io/docs/installation/raspberry-pi/
# #2:   20190130 - Added python3-lxml, libxslt-dev, libxml2-dev and zlib1g-dev for https://www.home-assistant.io/components/device_tracker.fritz/
RUN apt-get -qqy update && \
    apt-get -qqy upgrade && \
    apt-get -qqy install --no-install-recommends \
        python3 python3-venv python3-pip libffi-dev python3-dev python3-setuptools \
        python3-lxml libxslt-dev libxml2-dev zlib1g-dev && \
    apt-get -qqy autoremove && \
    apt-get -qqy clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    pip3 install -q --no-cache-dir wheel homeassistant

# Mouting point for the user's configuration
VOLUME /config

# Start Home Assistant
CMD [ "python3", "-m", "homeassistant", "--config", "/config" ]