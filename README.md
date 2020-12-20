# Build
`docker build --rm -t my-rtl433 .`

# Needed environment variables.
`docker run --rm -it --device=/dev/bus/usb -e MQTT_USERNAME=myuser -e MQTT_PASSWORD=mypass -e MQTT_HOST=myhost -e MQTT_PORT=1883 my-rtl433`


# overriting entrypoint and running rtl_433 only
`docker run --rm -it --device=/dev/bus/usb my-rtl433 -C si -M protocol -M newmodel -F "mqtt://<yourhost>:1883,user=<myuser>,pass=<mypass>,retain=0,devices=rtl_433/[id]/devices/[model]/[subtype]/[channel]/[id],events=rtl_433/[id]/events"`

