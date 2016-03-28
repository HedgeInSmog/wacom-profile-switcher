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

# check if mode_state file exists, if not create it and set to 0
if [ ! -f /tmp/mode_state ]; then
        echo 0 > /tmp/mode_state
fi

# read mode state value from temporary file
MODE=`cat /tmp/mode_state`

# refresh mode if param present
#if [ "$1" != "1" ]; then
#    MODE=$((MODE -= 1))
#fi

# select touch ring mode status LED for current mode state
echo $MODE > /sys/bus/hid/devices/*/wacom_led/status_led0_select

# for DEVICE use the pad "device name" from 'xinput list'
#DEVICE="Wacom Intuos4 6x9 pad"
#DEVICE="Wacom Intuos5 touch M Pen pad"
#DEVICE="Wacom Intuos Pro S Pen pad"
DEVICE=`xsetwacom list dev | grep -E -o ".*Pad pad"`

# set touch ring function option and notification for the 4 toggled modes
if [ "$MODE" == 0 ]; then
        xsetwacom set  "$DEVICE" AbsWheelUp 4  # scroll down
        xsetwacom set  "$DEVICE" AbsWheelDown 5  # scroll up
        notify-send "Mode 1: Scroll"
elif [ "$MODE" == 1 ]; then
        xsetwacom set  "$DEVICE" AbsWheelUp "key alt right"
        xsetwacom set  "$DEVICE" AbsWheelDown "key alt left"
        notify-send "Mode 2: Navigation Alt+right Alt+left"
elif [ "$MODE" == 2 ]; then
        xsetwacom set  "$DEVICE" AbsWheelUp "key +ctrl 4 -ctrl"
        xsetwacom set  "$DEVICE" AbsWheelDown "key +ctrl 5 -ctrl"
        notify-send "Mode 3: Zoom"
elif [ "$MODE" == 3 ]; then
        xsetwacom set  "$DEVICE" AbsWheelUp "key PgUp"
        xsetwacom set  "$DEVICE" AbsWheelDown "key PgDn"
        notify-send "Mode 4: Page Up - Page Down"
fi

#if [ "$1" != "1" ]; then

# toggle button increment counter
MODE=$((MODE += 1))
#fi

# set next mode state
if (( "$MODE" > 3 )); then  # roll over to 0, only 4 mode states available
        echo 0 > /tmp/mode_state
else
        echo $MODE > /tmp/mode_state
fi


#fi