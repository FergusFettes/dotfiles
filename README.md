# My dotfiles

My config files and a couple of scripts (in `./scripts/`) for reinstalling everything on a new laptop. Has been used repeatedly against x220s. There is still some stuff to be done.

# Quickstart

0. Ensure ssh installed on target: `apt install openssh-server`
1. [Optional, if using one machine as taget and client]: create ssh keys and add them to authorized_keys list: `ssh-keygen -t rsa -b 4096 -C "test@fake.com" -N ''`
2. [Client]: install ansible: `apt install ansible`.
3. [Client]: install ansible roles: 
```
ansible-galaxy install geerlingguy.ruby geerlingguy.pip geerlingguy.docker robertdebock.cargo gantsign.fd gantsign.bat gantsign.ctop gantsign.atom gantsign.antigen
```
4. [Client]: Add the target machines ips to `/etc/ansible/hosts` under '[new-machine]'.
5. [Client]: Create a masked password: `take /tmp/ansible-pass; /c/scripts/linux/password_manager.sh ffettes; mv /tmp/ansible-pass/masked-ffettes /pa/`
6. [Optional, if using one machine as target and client]: make sure you have a copy of the password, or you will get locked out! You must be able to type it in!
7. [Client]: authorize self at target: `ssh-copy-id ffettes@<target ip>`
8. Run ansible with
```bash
 ansible-playbook scripts/new_laptop_installation.yaml --extra-vars 'ansible_sudo_pass=<SUDO PASS FOR NEW MACHINE>'
 ```
9. Sit back, have a margarita, and watch your work being done for you. The new machines password will be changed to the password in `/tmp/ansible-pass/plaintext-ffettes`

## TODO

* update password handling to use libsodium
<!-- * install node handler: `https://github.com/Schniz/fnm` -- forget this, use nix-packages instead -->
* install notes: `curl -Ls https://raw.githubusercontent.com/pimterry/notes/latest-release/install.sh | sudo bash`
* tmux plugins: prefix + I
<!-- * install cronjobs -->
* consider adding a selection of vim plugins
* virtualenv deps (ipython and neovim)
* vim plugins need installed
* youcompleteme needs installed (`~/.vim/plugged/youcompleteme/install.sh`)
* change remotes (git remote remove origin)
* sign in to firefox!
* caps and ctrl need swapped in tweaks
* setup symlinks `./scripts/setup_symlinks.sh`
* install brave `./scripts/setup_brave.sh`
* install chrome (download from website, `dpkg -i /d/<download>`)
* add the zshprofle? so that zsh vars get initialized even when used as a script.
