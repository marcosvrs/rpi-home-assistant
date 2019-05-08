FROM balenalib/rpi-raspbian
LABEL maintainer="Marcos V. Rubido <docker@marcosvrs.com>"

ENV ARCH=arm
ENV CROSS_COMPILE=/usr/bin/

# Install some packages
# #1:   20190130 - Added python3, python3-venv, python3-pip, libffi-dev, python3-dev and python3-setuptools for https://www.home-assistant.io/docs/installation/raspberry-pi/
# #2:   20190130 - Added python3-lxml, libxslt-dev, libxml2-dev and zlib1g-dev for https://www.home-assistant.io/components/device_tracker.fritz/
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install --no-install-recommends \
        build-essential libssl-dev python3 python3-venv python3-pip libffi-dev python3-dev python3-setuptools \
        python3-lxml libxslt-dev libxml2-dev zlib1g-dev && \
    useradd -rm homeassistant -G dialout && \
    apt-get -y remove --auto-remove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    python3 -m pip install wheel && \
    pip3 --default-timeout=3600 install --no-cache-dir homeassistant

VOLUME [ "/config" ]

CMD [ "python3", "-m", "homeassistant", "--config", "/config" ]
