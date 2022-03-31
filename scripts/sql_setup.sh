#!/usr/bin/env zsh

if [ -z `tmux -L sys list-sessions | rg "output_$1"`]; then
  case "$1" in
    test) echo starting and attaching to test && tmuxinator sql_input_test && tmuxinator sql_output_test;;
    prod) echo starting and attaching to test && tmuxinator sql_input_prod && tmuxinator sql_output_prod;;
  esac

  case "$1" in
    test) echo starting watch command && tmux -L sys send-keys "watch -d -n 0.2 cat /tmp/sql_output_test" ENTER;;
    prod) echo starting watch command && tmux -L sys send-keys "watch -d -n 0.2 cat /tmp/sql_output_prod" ENTER;;
  esac
fi
