IP=""
TARGET_SUDO=""

target-pre:
	sudo apt install openssh-server

target-post:
	cd /dt/ && git remote remove origin && git remote add origin git@github.com:fergusfettes/dotgiles
	/dt/bin/setup_symlinks
	curl -fsSL https://fnm.vercel.app/install | bash
	fnm install v16.18.0
	sudo snap install universal-ctags
	setup_syncthing
	cd /h/.vim/plugged/youcompleteme && ./install.py

install-regolith:
	wget -qO - https://regolith-desktop.org/regolith.key | \
		gpg --dearmor | sudo tee /usr/share/keyrings/regolith-archive-keyring.gpg > /dev/null
	echo deb "[arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] \
		https://regolith-desktop.org/release-ubuntu-jammy-amd64 jammy main" | \
		sudo tee /etc/apt/sources.list.d/regolith.list
	sudo apt update
	sudo apt install regolith-desktop

install-rclone:
	sudo -v ; curl https://rclone.org/install.sh | sudo bash

client: setup-ansible run-ansible
	echo success!

setup-ansible:
	sudo apt install ansible ansible-core
	ansible-galaxy install \
		geerlingguy.ruby \
		geerlingguy.pip \
		geerlingguy.docker \
		robertdebock.cargo \
		gantsign.fd \
		gantsign.ctop \
		gantsign.antigen
	sudo mkdir -p /etc/ansible/
	echo '[new-machine]' | sudo tee /etc/ansible/hosts
	echo ${IP} | sudo tee -a /etc/ansible/hosts
	mkdir /tmp/ansible-pass
	cd /tmp/ansible-pass && /c/scripts/linux/password_manager.sh -u ffettes -p temppass123 -l
	mv /tmp/ansible-pass/masked-ffettes /pa/
	ssh-copy-id ffettes@${IP}
	scp ~/.zsh_history ${IP}:~/.zsh_history

run-ansible:
	ansible-playbook scripts/new_laptop_installation.yaml --extra-vars 'ansible_sudo_pass=${TARGET_SUDO}'

setup-moc:
	cp -r /dt/.moc/* ~/.moc/
	chmod 600 ~/.moc/config
