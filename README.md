# My dotfiles

My config files and a couple of scripts (in `./scripts/`) for reinstalling everything on a new laptop. Has been used repeatedly against x220s. There is still some stuff to be done.

# Quickstart

1. Install ssh `apt install openssh-server` on the target machines.
2. If you are installing from the target machine, create ssh keys and add them to authorized_keys list: `ssh-keygen -t rsa -b 4096 -C "maxfettes@hotmail.com" -N ''`
3. Install ansible on the client machine `apt install ansible`.
4. Install ansible roles `ansible-galaxy install geerlingguy.pip geerlingguy.docker robertdebock.cargo gantsign.fd gantsign.bat gantsign.ctop gantsign.atom gantsign.antigen`
5. Add the target machines ips to `/etc/ansible/hosts` under '[new-machine]'.
6. Make sure you have changed the password folder and chosen a password (and created a masked password).
7. WARNING: if you are running the install from the taget machine, make sure you have a copy of the password, or you will get locked out!
8. Run ansible with
```bash
 ansible-playbook scripts/new_laptop_installation.yaml --extra-vars 'ansible_sudo_pass=<SUDO PASS FOR NEW MACHINE>'
 ```
9. Sit back, have a margarita, and watch your work being done for you.

## TODO

* install node handler: `https://github.com/Schniz/fnm`
* install notes: `curl -Ls https://raw.githubusercontent.com/pimterry/notes/latest-release/install.sh | sudo bash`
* install vscode
* tmux plugins: prefix + I
* install cronjobs
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

install notes-- is this the one?
https://github.com/rhysd/notes-cli
