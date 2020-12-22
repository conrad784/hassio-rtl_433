FROM debian:buster-slim

MAINTAINER Conrad Sachweh

ENV RTL_433_VERSION=20.11

WORKDIR /tmp

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    librtlsdr-dev \
    doxygen \
    python3-minimal \
    python3-paho-mqtt \
    git \
    ca-certificates \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*


RUN git clone https://github.com/merbanan/rtl_433.git && \
    cd rtl_433 && \
    git checkout $RTL_433_VERSION && \
    mkdir build && \
    cd build && \
    cmake ../ && \
    make && \
    make install

RUN apt-get purge -y cmake \
    build-essential \
    git \
    doxygen

WORKDIR /

ADD https://raw.githubusercontent.com/merbanan/rtl_433/$RTL_433_VERSION/examples/rtl_433_mqtt_hass.py rtl_433_mqtt_hass.py

COPY startapp.sh startapp.sh

ENTRYPOINT ["/startapp.sh"]