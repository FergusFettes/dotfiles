#!/usr/bin/env bash
local_ip=$(ip a | grep 192 | awk '{ print $4 }')

sed \
-e "s/$local_ip/172.16.38.211/" \
$1
