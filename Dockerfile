FROM balenalib/rpi-raspbian:stretch
LABEL maintainer="Marcos V. Rubido <docker@marcosvrs.com>"

ENV ARCH=arm
ENV CROSS_COMPILE=/usr/bin/

VOLUME /config

WORKDIR /usr/src/app

# Install some packages
# #1:   20190130 - Added python3, python3-venv, python3-pip, libffi-dev, python3-dev and python3-setuptools for https://www.home-assistant.io/docs/installation/raspberry-pi/
# #2:   20190130 - Added python3-lxml, libxslt-dev, libxml2-dev and zlib1g-dev for https://www.home-assistant.io/components/device_tracker.fritz/
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential libssl-dev python3 python3-venv python3-pip libffi-dev python3-dev python3-setuptools \
        python3-lxml libxslt-dev libxml2-dev zlib1g-dev && \
    apt-get -y --purge autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/src/app/build/ && \
    pip3 install --no-cache-dir homeassistant

CMD [ "python3", "-m", "homeassistant", "--config", "/config" ]
