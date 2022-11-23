IP=""
TARGET_SUDO=""

target-pre:
	sudo apt install openssh-server

target-post:
	cd /dt/ && git remote remove origin && git remote add origin git@github.com:fergusfettes/dotgiles
	/dt/scripts/setup_symlinks.sh
	curl -fsSL https://fnm.vercel.app/install | bash
	fnm install v16.18.0
	npm install -g hexo-cli
	snap install universal-ctags
	setup_syncthing

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
	sudo echo '[new-machine]' > /etc/ansible/hosts
	sudo echo ${IP} >> /etc/ansible/hosts
	take /tmp/ansible-pass && /c/scripts/linux/password_manager -u ffettes -p temppass123 -l
	mv /tmp/ansible-pass/masked-ffettes /pa/
	ssh-copy-id ffettes@${IP}
	scp ~/.zsh_history ${IP}:~/.zsh_history

run-ansible:
	ansible-playbook scripts/new_laptop_installation.yaml --extra-vars 'ansible_sudo_pass=${TARGET_SUDO}'

setup-moc:
	cp -r /dt/.moc/* ~/.moc/
	chmod 600 ~/.moc/config
