#!/bin/bash

path="$1"
direction="$2"

# Get the filename without the directory
filename=$(basename "$path")

# Move the file to the appropriate directory
if [ "$direction" = "up" ]; then
  mv "$path" "/home/ffettes/pr/up/$filename"
else
  mv "$path" "/home/ffettes/pr/.del/$filename"
fi
