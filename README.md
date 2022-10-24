# My dotfiles

My config files and a couple of scripts (in `./scripts/`) for reinstalling everything on a new laptop. Has been used repeatedly against x220s. There is still some stuff to be done.

# Quickstart

Clone and run `make target-pre` on the target machine.

Run `make client IP=<ip of target> TARGET_SUDO=<sudo password of target>`.

1. [Optional, if using one machine as taget and client]: create ssh keys and add them to authorized_keys list: `ssh-keygen -t rsa -b 4096 -C "test@fake.com" -N ''`
2. [Optional, if using one machine as target and client]: make sure you have a copy of the password, or you will get locked out! You must be able to type it in!

## TODO

* update password handling to use libsodium
* virtualenv deps (ipython and neovim) -- needs to be updated for poetry

## Post install steps:
* install cronjobs
* tmux plugins: prefix + I
* vim plugins need installed
* youcompleteme needs installed (`~/.vim/plugged/youcompleteme/install.sh`)
* install aws cli (this can be done in the makefile?)
* install terraform (likewise?)
* install gh cli (also likewise?)

* sign in to firefox!
* caps and ctrl need swapped in tweaks
* install brave `./scripts/setup_brave.sh`
* install chrome (download from website, `dpkg -i /d/<download>`)
* add the zshprofle? so that zsh vars get initialized even when used as a script.
