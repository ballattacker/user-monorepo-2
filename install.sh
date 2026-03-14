#!/bin/sh

name=zsh
usrp install yazi
nix profile add nixpkgs#$name
ln -fnrs . "$XDG_CONFIG_HOME"/$name
ln -fnrs ./.zshenv "$POSIX_DIR"/"$name".sh

nix profile add nixpkgs#fzf
nix profile add nixpkgs#starship

git clone https://github.com/Aloxaf/fzf-tab plugins/fzf-tab
git -C plugins/fzf-tab checkout 5a81e13
git clone https://github.com/zsh-users/zsh-autosuggestions plugins/zsh-autosuggestions
git -C plugins/zsh-autosuggestions checkout 85919cd
git clone https://github.com/zsh-users/zsh-history-substring-search plugins/zsh-history-substring-search
git -C plugins/zsh-history-substring-search checkout 14c8d2e
git clone https://github.com/zsh-users/zsh-syntax-highlighting plugins/zsh-syntax-highlighting
git -C plugins/zsh-syntax-highlighting checkout 1d85c69
