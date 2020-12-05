#!/usr/bin/env bash
sed \
-e "s/172.16.38.211/172.17.0.1/" \
$1
