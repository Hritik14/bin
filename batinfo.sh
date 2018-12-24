#!/bin/bash

BATTERY=0
BATTERY_INFO=$(upower -i $(upower -e| grep BAT))
BATTERY_STATE=$(echo "${BATTERY_INFO}" | grep -wo "full\|charging\|discharging" -m 1)
BATTERY_POWER=$(echo "${BATTERY_INFO}" | grep -o '[0-9]\+%' -m 1 | cut -d% -f 1)

echo ${BATTERY_POWER}%
