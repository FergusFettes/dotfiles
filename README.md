# My dotfiles

My config files and a couple of scripts (in `./scripts/`) for reinstalling everything on a new laptop. Has been used repeatedly against x220s. There is still some stuff to be done.

# Quickstart

1. Install ssh `apt install openssh-server` on the target machines.
2. Install ansible on the client machine `apt install ansible`.
3. Add the target machines ips to `/etc/ansible/hosts` under '[new-machine]'.
4. Make sure you have changed the password folder and chosen a password (and created a masked password).  # TODO: make sure there are instructions for creating masked passwords.
5. Run ansible with
```bash
 ansible-playbook scripts/new_laptop_installation.yaml --extra-vars 'ansible_sudo_pass=<SUDO PASS FOR NEW MACHINE>'
 ```
6. Sit back, have a margarita, and watch your work being done for you.

## TODO

* alacritty not working?
* consider adding zsh plugins
* consider adding a selection of vim plugins
* virtualenv deps (ipython and neovim)
* vim plugins need installed
* youcompleteme needs installed (`~/.vim/plugged/youcompleteme/install.sh`)
* change remotes (git remote remove origin)
* dconf load /org/gnome/desktop/wm/keybindings/ < ./dconf/wm/keybindings
* dconf load /org/gnome/desktop/wm/custom-keybindings/ < ./dconf/custom-keybindings/keybindings.dconf
* caps and ctrl need swapped in tweaks
* turn off animations
* replace the desktop background

I think the last three also need to be dont with dconf, though the custom keybindings seem to have worked, so maybe they just weren't saved properly.
