#!/usr/bin/env zsh

exec nvim -p \
  $VIMRC \
  $ALACRITTYRC \
  /home/$USER/.tmux.conf \
  /home/$USER/.zshrc \
  /home/$USER/.config/personal/.zshrc.alias \
  /home/$USER/.config/personal/.zshrc.vars \
  /home/$USER/.config/personal/.zshrc.work \
  /home/$USER/.config/personal/.zshrc.func \
  /home/$USER/.config/regolith/i3/config
