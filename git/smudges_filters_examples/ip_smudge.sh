#!/usr/bin/env bash
local_ip=$(ip a | grep 192 | awk '{ print $4 }')

sed \
-e "s/172.16.38.211/$local_ip/" \
$1
