FROM alpine:latest as base
ENV RTL_433_VERSION=20.11

FROM base as builder

RUN apk add --no-cache --virtual .buildDeps \
    build-base \
    libusb-dev \
    librtlsdr-dev \
    cmake \
    git

WORKDIR /build
RUN git clone https://github.com/merbanan/rtl_433
WORKDIR ./rtl_433
RUN git checkout ${RTL_433_VERSION}
WORKDIR ./build

RUN cmake ..
RUN make -j
WORKDIR /build/rtl_433/build
RUN make DESTDIR=/build/root/ install


FROM base

RUN apk add --no-cache \
    libusb \
    librtlsdr \
    py3-paho-mqtt
COPY --from=builder /build/root/ /

WORKDIR /

ADD https://raw.githubusercontent.com/merbanan/rtl_433/$RTL_433_VERSION/examples/rtl_433_mqtt_hass.py rtl_433_mqtt_hass.py

COPY startapp.sh startapp.sh

MAINTAINER Conrad Sachweh

ENTRYPOINT ["tini", "--", "/startapp.sh"]