#!/usr/bin/env bash

sudo apt remove -y gnome-shell-extension-desktop-icons gnome-shell-extension-ubuntu-dock
sudo apt update -y
sudo apt install -y indicator-multiload gnome-tweaks pavucontrol
