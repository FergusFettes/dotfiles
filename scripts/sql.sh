#!/usr/bin/env zsh

case "$1" in
  test) tmux -L sys attach -t output_test;;
  prod) tmux -L sys attach -t output_prod;;
esac
