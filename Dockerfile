FROM debian:bullseye-slim

MAINTAINER Conrad Sachweh

WORKDIR /tmp


# RUN git clone https://github.com/merbanan/rtl_433.git && \
#     cd rtl_433 && \
#     mkdir build && \
#     cd build && \
#     cmake ../ && \
#     make && \
#     make install && \
#     cd / && \
#     rm -rf /tmp/rtl_433

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    rtl-433 \
    python3-minimal \
    python3-paho-mqtt \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /

ADD https://raw.githubusercontent.com/merbanan/rtl_433/20.11/examples/rtl_433_mqtt_hass.py rtl_433_mqtt_hass.py
COPY startapp.sh startapp.sh

ENTRYPOINT ["/startapp.sh"]