#!/usr/bin/env bash

sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible

sudo apt install -y ansible ansible-core

ansible-galaxy install geerlingguy.ruby geerlingguy.pip geerlingguy.docker robertdebock.cargo gantsign.fd gantsign.ctop gantsign.antigen tyhal.cuda nvidia.nvidia_driver
sudo mkdir -p /etc/ansible/
echo "now add the target ip to

/etc/ansible/hosts

under the heading

[new-machine]"

echo "[new-machine]" | sudo tee /etc/ansible/hosts

echo "then, run ansible with

ansible-playbook scripts/new_laptop_installation.yaml --extra-vars 'ansible_sudo_pass=<SUDO PASS FOR NEW MACHINE>'"
