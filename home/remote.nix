{ pkgs, username, ... }:

let
  homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
in
{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    bat
    curl
    eza
    fd
    fish
    fzf
    git
    htop
    jq
    neovim
    ripgrep
    stow
    tmux
    tree
    wget
    zoxide
  ];

  home.file = {
    ".config/fish/config.fish".source = ../fish/.config/fish/config.fish;
    ".gitconfig".source = ../git/.gitconfig;
    ".gitmessage".source = ../git/.gitmessage;
    ".config/.git_template/.gitattributes".source = ../git/.config/.git_template/.gitattributes;
    ".config/gitignores/Python.gitignore".source = ../git/.config/gitignores/Python.gitignore;
    ".tmux.conf".source = ../tmux/.tmux.conf;
  };
}
