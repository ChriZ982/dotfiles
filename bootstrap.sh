#!/bin/bash
set -euxo pipefail

OS=$(grep -ioP '^ID_LIKE=\K.+' /etc/os-release)

if [[ $OS == "debian" ]]; then
    sudo apt update && sudo apt install -y \
        bat \
        exa \
        fish
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
# elif [[ $OS == "arch" ]]; then

fi

chsh -s "$(which fish)"

mkdir -p ~/.config/fish/completions
ln -f -s "$(pwd)/.config/fish/config.fish" ~/.config/fish/config.fish
ln -f -s "$(pwd)/.config/fish/completions/docker.fish" ~/.config/fish/completions/docker.fish
ln -f -s "$(pwd)/.config/starship.toml" ~/.config/starship.toml
ln -f -s "$(pwd)/.vimrc" ~/.vimrc
