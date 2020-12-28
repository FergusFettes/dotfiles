#!/usr/bin/env bash

end=$((SECONDS+3))

echo "watching the CPU speed (press ctrl+C to continue)"
watch -d -n 0.2 "lscpu |egrep 'Model name|MHz'"

echo "checking cpu profiles"
sudo tlp-stat -p | grep 'scaling_available_governors'

sudo cpupower frequency-set -g powersave # set governor profile to powersave

sudo cpupower frequency-set --max 3200000  # set Turbo Boost max CPU freq to 3.4GHz

# This sets the cpu max frequency to 3.2GHz, normal for a x220 i5. For an i7, change it according to needs.
