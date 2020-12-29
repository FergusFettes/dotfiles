#!/usr/bin/env bash

sudo apt install -y ansible

ansible-galaxy install geerlingguy.pip geerlingguy.docker robertdebock.cargo gantsign.fd gantsign.bat gantsign.ctop gantsign.atom gantsign.antigen

echo "now add the target ip to

/etc/ansible/hosts

under the heading

[new-machine]"

echo "then, run ansible with

ansible-playbook scripts/new_laptop_installation.yaml --extra-vars 'ansible_sudo_pass=<SUDO PASS FOR NEW MACHINE>'"
