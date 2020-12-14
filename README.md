# My dotfiles

My config files and a couple of scripts (in `./scripts/`) for reinstalling everything on a new laptop. Has been used repeatedly against x220s. There is still some stuff to be done.

# Quickstart

1. Install ssh `apt install openssh-server` on the target machines.
2. Install ansible on the client machine `apt install ansible`.
3. Add the target machines ips to `/etc/ansible/hosts` under '[new-machine]'.

## TODO

* consider adding zsh plugins
* consider adding a selection of vim plugins
* vim plugins need installed
* youcompleteme needs installed (`~/.vim/plugged/youcompleteme/install.sh`)
* change remotes (git remote remove origin)
* dconf load /org/gnome/desktop/wm/keybindings/ < ./dconf/wm/keybindings
* dconf load /org/gnome/desktop/wm/custom-keybindings/ < ./dconf/custom-keybindings/keybindings.dconf
* caps and ctrl need swapped in tweaks
* turn off animations
* replace the desktop background

I think the last three also need to be dont with dconf, though the custom keybindings seem to have worked, so maybe they just weren't saved properly.
