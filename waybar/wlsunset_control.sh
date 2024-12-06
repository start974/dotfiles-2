#!/bin/bash

# Temporary files to store the current temperature and state of wlsunset
TEMP_FILE="/tmp/wlsunset_temp"
STATE_FILE="/tmp/wlsunset_state"

# Default values for Paris
DEFAULT_TEMP=4500        # Default temperature in Kelvin
MAX_TEMP=6500            # Maximum allowed temperature
MIN_TEMP=1000            # Minimum allowed temperature
STEP=500                 # Temperature adjustment step
LATITUDE=48.8566         # Latitude for Paris
LONGITUDE=2.3522         # Longitude for Paris

# Function to toggle wlsunset on/off
toggle_wlsunset() {
  if pgrep -x "wlsunset" > /dev/null; then
    # If wlsunset is running, terminate it
    pkill -TERM wlsunset
    echo "off" > "$STATE_FILE"
  else
    # If wlsunset is not running, start it with the current or default temperature
    local current_temp=$(cat "$TEMP_FILE" 2>/dev/null || echo $DEFAULT_TEMP)
    wlsunset -l $LATITUDE -L $LONGITUDE -t $current_temp -T $MAX_TEMP &
    echo "on" > "$STATE_FILE"
  fi
}

# Function to get the current temperature or state
get_temperature() {
  local state=$(cat "$STATE_FILE" 2>/dev/null || echo "off")
  if [ "$state" = "on" ] && pgrep -x "wlsunset" > /dev/null; then
    # Return the current temperature if wlsunset is running
    echo "$(cat "$TEMP_FILE" 2>/dev/null || echo $DEFAULT_TEMP) K 🔆"
  else
    # Indicate that wlsunset is off
    echo "Off 🌙"
  fi
}

# Function to return only the temperature for tooltip
get_temperature_value() {
  echo "$(cat "$TEMP_FILE" 2>/dev/null || echo $DEFAULT_TEMP) K"
}

# Function to adjust the temperature
adjust_temperature() {
  local direction=$1
  local current_temp=$(cat "$TEMP_FILE" 2>/dev/null || echo $DEFAULT_TEMP)

  if [ "$direction" = "up" ]; then
    # Increase temperature
    local new_temp=$((current_temp + STEP))
    [ $new_temp -gt $MAX_TEMP ] && new_temp=$MAX_TEMP
  elif [ "$direction" = "down" ]; then
    # Decrease temperature
    local new_temp=$((current_temp - STEP))
    [ $new_temp -lt $MIN_TEMP ] && new_temp=$MIN_TEMP
  fi

  # Update the temperature and restart wlsunset with the new value
  echo "$new_temp" > "$TEMP_FILE"
  pkill -USR1 wlsunset
  wlsunset -l $LATITUDE -L $LONGITUDE -t $new_temp -T $MAX_TEMP &
}

# Main script logic based on input arguments
case $1 in
  toggle) toggle_wlsunset ;;           # Toggle wlsunset on/off
  get) get_temperature ;;              # Get the current temperature or state
  get-tooltip) get_temperature_value ;;# Return only the temperature for tooltip
  up) adjust_temperature up ;;         # Increase the temperature
  down) adjust_temperature down ;;     # Decrease the temperature
  *) echo "Usage: $0 {toggle|get|get-tooltip|up|down}" ;; # Show usage information
esac
