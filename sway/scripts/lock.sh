#!/bin/sh

pgrep -x swaylock > /dev/null || swaylock -f
