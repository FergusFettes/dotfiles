#!/usr/bin/env bash

function dcr-soft() {
  if [ -z $1 ]
  then
    file=docker-compose.yaml
  else
    file=$1
  fi
  echo "stopping, building and restarting $file"
  docker-compose -f $file down
  docker-compose -f $file build
  docker-compose -f $file up -d
  docker-compose -f $file logs -f
}

function dcr-hard() {
  if [ -z $1 ]
  then
    file=docker-compose.yaml
  else
    file=$1
  fi
  echo "killing, rming, building and restarting $file"
  docker-compose -f $file kill
  docker-compose -f $file rm -f
  docker-compose -f $file build
  docker-compose -f $file up -d
  docker-compose -f $file logs -f
}
