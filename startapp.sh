#!/bin/bash

python3 rtl_433_mqtt_hass.py -H ${MQTT_HOST} -p ${MQTT_PORT} -R rtl_433/+/events &

rtl_433 -C si -M protocol -M newmodel -F "mqtt://${MQTT_HOST}:${MQTT_PORT},user=${MQTT_USERNAME},pass=${MQTT_PASSWORD},retain=0,devices=rtl_433/[id]/devices/[model]/[subtype]/[channel]/[id],events=rtl_433/[id]/events"
