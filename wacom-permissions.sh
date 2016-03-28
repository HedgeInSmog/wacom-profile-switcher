#!/bin/bash
sleep 1
/bin/chmod 666 /sys/bus/hid/devices/*/wacom_led/status_led0_select 2>>/tmp/wacom_permissions_err.log

