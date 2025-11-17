#!/bin/bash

# Get network download speed on macOS
# This script measures the download speed over a 1-second interval

# Cache file to store previous measurement
CACHE_DIR="${TMPDIR:-/tmp}/tmux-network-speed"
CACHE_FILE="$CACHE_DIR/network_speed.cache"

# Create cache directory if it doesn't exist
mkdir -p "$CACHE_DIR"

# Get the default network interface (usually en0 for WiFi, en1 for Ethernet)
INTERFACE=$(route get default 2>/dev/null | grep interface | awk '{print $2}')

# Fallback to en0 if no default route
if [ -z "$INTERFACE" ]; then
    INTERFACE="en0"
fi

# Get current bytes received
get_bytes() {
    netstat -ibn | grep -m1 "$INTERFACE" | awk '{print $7}'
}

# Read previous measurement
if [ -f "$CACHE_FILE" ]; then
    read -r PREV_BYTES PREV_TIME <"$CACHE_FILE"
else
    PREV_BYTES=0
    PREV_TIME=0
fi

# Get current measurement
CURR_BYTES=$(get_bytes)
CURR_TIME=$(date +%s)

# Calculate time difference
TIME_DIFF=$((CURR_TIME - PREV_TIME))

# Only calculate speed if we have a previous measurement and time diff is reasonable
if [ "$TIME_DIFF" -gt 0 ] && [ "$TIME_DIFF" -lt 10 ]; then
    BYTES_DIFF=$((CURR_BYTES - PREV_BYTES))

    # Calculate bytes per second
    BYTES_PER_SEC=$((BYTES_DIFF / TIME_DIFF))

    # Convert to MB/s with decimal precision
    SPEED=$(awk "BEGIN {printf \"%.2f\", $BYTES_PER_SEC / 1048576}")
    SPEED="${SPEED}MB/s"
else
    SPEED="--"
fi

# Save current measurement for next time
echo "$CURR_BYTES $CURR_TIME" >"$CACHE_FILE"

# Output the speed with download icon
echo "↓${SPEED}"
