IP=""
TARGET_SUDO=""

minimal:
	rm ~/.tmux.conf ~/.vimrc
	cp tmux/.tmux.conf ~/
	cp mini/.vimrc ~/

install_zsh:
	-git clone https://github.com/b4b4r07/enhancd ~/enhancd
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

copy_ssh:
	sudo cp -r $OLD_HOME/.ssh ~/
	sudo chown -R $NEW_USER: ~/.ssh

install_toolbox:
	sudo apt-get update
	sudo apt-get install -y podman podman-toolbox
	toolbox create -i ghcr.io/fergusfettes/boxkit:latest

install_distrobox:
	sudo apt-get update
	sudo apt-get install -y podman podman-toolbox
	curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh
	distrobox create -i ghcr.io/fergusfettes/boxkit:latest

packages: nvim
	sudo add-apt-repository ppa:maveonair/helix-editor
	sudo apt update
	sudo apt install -y stow make zsh fuse helix python3 python3-pip

.PHONY: nvim
nvim:
	curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
	chmod u+x nvim.appimage
	sudo mv nvim.appimage /usr/local/bin/nvim

install:
	ln -s ~/dotfiles ~/dt
	./bin/setup_symlinks
	cd ~/dt/ && git remote remove origin && git remote add origin git@github.com:fergusfettes/dotfiles && git branch --set-upstream-to=origin/master master
	stow git
	stow helix

stow_zsh:
	-rm ~/.profile
	-rm ~/.zshrc
	cd ~/dotfiles && stow zsh

boxkit_install:
	sudo ln -s /dotfiles ~/dt
	~/dt/bin/setup_symlinks
	cd ~/dt/ && git remote remove origin && git remote add origin git@github.com:fergusfettes/dotfiles && git branch --set-upstream-to=origin/master master
	stow vim
	rm ~/.profile
	stow zsh

target-pre:
	sudo apt install openssh-server

target-post:
	cd ~/dt/ && git remote remove origin && git remote add origin git@github.com:fergusfettes/dotfiles
	/dt/bin/setup_symlinks
	curl -fsSL https://fnm.vercel.app/install | bash
	fnm install v16.18.0
	sudo snap install universal-ctags
	setup_syncthing
	cd ~/.vim/plugged/youcompleteme && ./install.py
	make setup-moc
	sudo service postgresql stop
	sudo systemctl disable postgresql.service
	git clone https://github.com/sharkdp/trigger ~/.trigger

install-regolith:
	wget -qO - https://regolith-desktop.org/regolith.key | \
		gpg --dearmor | sudo tee /usr/share/keyrings/regolith-archive-keyring.gpg > /dev/null
	echo deb "[arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] \
		https://regolith-desktop.org/release-ubuntu-jammy-amd64 jammy main" | \
		sudo tee /etc/apt/sources.list.d/regolith.list
	sudo apt update
	sudo apt install regolith-desktop

install-qbittorrent:
	sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable -y
	sudo apt update
	sudo apt install -y qbittorrent

install-rclone:
	sudo -v ; curl https://rclone.org/install.sh | sudo bash

client: setup-ansible run-ansible
	echo success!

setup-ansible:
	sudo apt install -y ansible
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
	mkdir -p /tmp/ansible-pass
	cd /tmp/ansible-pass && /c/scripts/linux/password_manager.sh -u ffettes -p temppass123 -l
	mv /tmp/ansible-pass/masked-ffettes /pa/
	ssh-keygen -R ${IP}
	ssh-copy-id ffettes@${IP}
	scp ~/.zsh_history ${IP}:~/.zsh_history

run-ansible:
	ansible-playbook scripts/new_laptop_installation.yaml --extra-vars 'ansible_sudo_pass=${TARGET_SUDO}'

setup-moc:
	cp -r /dt/moc/.moc/* ~/.moc/
	chmod 600 ~/.moc/config

setup-gcloud:
	sudo apt-get install apt-transport-https ca-certificates gnupg
	echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
	curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
	sudo apt-get update && sudo apt-get install google-cloud-cli
	gcloud init

build:
	docker build -t $(IMAGE) -f /b/Dockerfile.$(IMAGE) /b/
