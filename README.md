# Build
`docker build --rm -t my-rtl433 .`

# Needed environment variables.
`docker run --rm -it --device=/dev/bus/usb -e MQTT_USERNAME=myuser -e MQTT_PASSWORD=mypass -e MQTT_HOST=myhost -e MQTT_PORT=1883 my-rtl433`


# overwriting entrypoint and running rtl_433 interactively
`docker run --rm -it --device=/dev/bus/usb --entrypoint=/bin/bash my-rtl433`
Default config from startapp.sh is `-C si -M protocol -M newmodel -F "mqtt://<yourhost>:1883,user=<myuser>,pass=<mypass>,retain=0,devices=rtl_433/[id]/devices/[model]/[subtype]/[channel]/[id],events=rtl_433/[id]/events"`

# Notes
## debug rtl433 devices
-M level -M stats:2  (2 --> active devices, 3 --> all devices)

