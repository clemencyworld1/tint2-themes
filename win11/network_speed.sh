#!/bin/bash

# Paths to the temporary files
RX_PREV="/tmp/rx_prev"
RX_TOTAL="/tmp/rx_total"

INTERFACE="wlan0"

# Read previous values
if [[ -f $RX_PREV ]]; then
    RX_PREV_VAL=$(cat $RX_PREV)
else
    RX_PREV_VAL=0
fi

# Read total values
if [[ -f $RX_TOTAL ]]; then
    RX_TOTAL_VAL=$(cat $RX_TOTAL)
else
    RX_TOTAL_VAL=0
fi

# Get current values
RX_CURR=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)

# Calculate speed (bytes per second)
RX_SPEED=$(( RX_CURR - RX_PREV_VAL ))

# Update total downloaded
RX_TOTAL_VAL=$(( RX_TOTAL_VAL + RX_SPEED ))

# Save current values for next check
echo $RX_CURR > $RX_PREV
echo $RX_TOTAL_VAL > $RX_TOTAL

# Convert to kilobytes and megabytes
RX_SPEED_KBPS=$(( RX_SPEED / 1024 ))
RX_TOTAL_MB=$(( RX_TOTAL_VAL / 1024 / 1024 ))

# Output the result with Unicode icons
echo ": ${RX_SPEED_KBPS}KB/s 
:${RX_TOTAL_MB}MB"
