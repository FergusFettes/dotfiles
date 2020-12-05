#!/usr/bin/env bash
sed \
-e "s/localhost:5000/dockerregistry.ondewo.com:5000/" \
$1
