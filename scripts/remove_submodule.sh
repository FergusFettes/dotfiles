#!/usr/bin/env bash

git submodule deinit $1
git rm $1
git commit -m "Removed submodule $1"
rm -rf ".git/modules/$1"
