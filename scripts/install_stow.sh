#!/usr/bin/env bash

mkdir -p ~/.local/
curl -fLo ~/.local/stow.tar.gz http://mirror.easyname.at/gnu/stow/stow-latest.tar.gz

cd ~/.local
tar xvf stow.tar.gz
cd stow

sudo ./configure && sudo make install
