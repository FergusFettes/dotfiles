# My dotfiles

My config files and a couple of scripts (in `./scripts/`) for reinstalling everything on a new laptop. Has been used repeatedly against x220s. There is still some stuff to be done.

# Quickstart

1. Install ssh `apt install openssh-server` on the target machines.
2. Install ansible on the client machine `apt install ansible`.
3. Install ansible roles `ansible-galaxy install geerlingguy.pip geerlingguy.docker robertdebock.cargo gantsign.fd gantsign.bat gantsign.ctop gantsign.atom gantsign.antigen`
4. Add the target machines ips to `/etc/ansible/hosts` under '[new-machine]'.
5. Make sure you have changed the password folder and chosen a password (and created a masked password).
6. WARNING: if you are running the install from the taget machine, make sure you have a copy of the password, or you will get locked out!
7. Run ansible with
```bash
 ansible-playbook scripts/new_laptop_installation.yaml --extra-vars 'ansible_sudo_pass=<SUDO PASS FOR NEW MACHINE>'
 ```
8. Sit back, have a margarita, and watch your work being done for you.

## TODO

* alacritty not working?
* consider adding zsh plugins
* consider adding a selection of vim plugins
* virtualenv deps (ipython and neovim)
* vim plugins need installed
* youcompleteme needs installed (`~/.vim/plugged/youcompleteme/install.sh`)
* change remotes (git remote remove origin)
* sign in to firefox!
* dconf load /org/gnome/desktop/wm/keybindings/ < ./dconf/wm/keybindings
* dconf load /org/gnome/desktop/wm/custom-keybindings/ < ./dconf/wm/keybindings
* dconf load /org/gnome/desktop/input-sources/ < ./dconf/input-sources
* caps and ctrl need swapped in tweaks
* turn off animations
* replace the desktop background
* skip all the canonical startup stuff

I think the last ones also need to be dont with dconf, though the custom keybindings seem to have worked, so maybe they just weren't saved properly.
