#!/usr/bin/env bash
sed \
-e 's/dockerregistry.ondewo.com:5000/localhost:5000/' \
$1
