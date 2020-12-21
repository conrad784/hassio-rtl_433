FROM debian:buster-slim

MAINTAINER Conrad Sachweh

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
    mkdir build && \
    cd build && \
    cmake ../ && \
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/rtl_433

# now binary is in /tmp/rtl_433/build/src/rtl_433

WORKDIR /

ADD https://raw.githubusercontent.com/merbanan/rtl_433/20.11/examples/rtl_433_mqtt_hass.py rtl_433_mqtt_hass.py
COPY startapp.sh startapp.sh

ENTRYPOINT ["/startapp.sh"]