export PATH="/home/ffettes/.ebcli-virtual-env/executables:$PATH"
export ALACRITTYRC="/home/$USER/.config/alacritty/alacritty.yml"
export VIMRC="/home/$USER/.config/nvim/init.vim"
export ZSHRC="/home/$USER/.zshrc"

if [ -e /home/ffettes/.nix-profile/etc/profile.d/nix.sh ]; then . /home/ffettes/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# Codon compiler path (added by install script)
export PATH=/home/ffettes/.codon/bin:$PATH
