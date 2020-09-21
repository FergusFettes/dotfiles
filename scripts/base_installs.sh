#!/usr/bin/env bash

sudo apt update -y
sudo apt install -y stow jq parallel tmux zsh python3-neovim mosh et
sudo apt install -y cmake libfreetype6-dev libfontconfig1-dev xclip
cargo install alacritty

echo add eternal terminal
