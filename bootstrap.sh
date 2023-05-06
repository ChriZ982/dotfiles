#!/bin/bash

sudo apt update && sudo apt install -y \
    fish \
    bat
curl -sS https://starship.rs/install.sh | sh -s -- --yes

chsh -s "$(which fish)"

mkdir -p ~/.config/fish
cp ./.config/fish/config.fish ~/.config/fish/config.fish
cp ./.config/starship.toml ~/.config/starship.toml
cp ./.vimrc ~/.vimrc
