#!/bin/bash

## Touch ring toggle script
##
## Bind Button 1 (button center of touch ring) to the script.
##
## To allow script to select mode status LEDs edit rc.local to change root
## only permissions on the sysfs status_led0_select file:
##   gksudo gedit /etc/rc.local
## Add the following comment and command (before 'exit 0'):
##   # Change permissions on status_led0_select file so being root isn't
##   # required to switch Wacom touch ring mode status LEDs.
##   /bin/chmod 666 /sys/bus/usb/devices/*/wacom_led/status_led0_select
##
## Intuos - status_led0_select file = the left (only) ring status LEDs.
## Cintiq - status_led1_select = the left ring; status_led0_select =
## the right ring status LEDs.  Same for the touchstrips.
##
## For mode state notification use:
##   sudo apt-get install libnotify-bin
## Otherwise comment (#) out the notify-send lines.  If libnotify-bin
## installed see 'man notify-send' for details.

# for DEVICE use the pad "device name" from 'xinput list'
#DEVICE="Wacom Intuos Pro S Pen pad"
DEVICE=`xsetwacom list dev | grep -E -o ".*Pad pad"`

MODE=`cat /sys/bus/hid/devices/*/wacom_led/status_led0_select`

# set touch ring function option and notification for the 4 toggled modes
if [ "$MODE" == 0 ]; then
    xsetwacom set  "$DEVICE" AbsWheelUp "key PgUp"
    xsetwacom set  "$DEVICE" AbsWheelDown "key PgDn"
    notify-send --hint int:transient:1 "FireFox" "Mode 1: Scroll"
elif [ "$MODE" == 1 ]; then
    xsetwacom set  "$DEVICE" AbsWheelUp "key +ctrl - -ctrl"
    xsetwacom set  "$DEVICE" AbsWheelDown "key +ctrl = -ctrl"
    notify-send --hint int:transient:1 "FireFox" "Mode 2: Zoom"
elif [ "$MODE" == 2 ]; then
    xsetwacom set  "$DEVICE" AbsWheelUp "key +ctrl PgUp -ctrl"
    xsetwacom set  "$DEVICE" AbsWheelDown "key +ctrl PgDn -ctrl"
    notify-send --hint int:transient:1 "FireFox" "Mode 3: Scroll Tabs"
elif [ "$MODE" == 3 ]; then
    xsetwacom set  "$DEVICE" AbsWheelUp "key alt right"
    xsetwacom set  "$DEVICE" AbsWheelDown "key alt left"
    notify-send --hint int:transient:1 "FireFox" "Mode 4: Navigation Alt+right Alt+left"
fi

                                               