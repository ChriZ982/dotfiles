#!/bin/sh
set -eu

ID_LIKE=$(cat /etc/*-release | grep ^ID_LIKE | cut -d= -f2)
if [ "$ID_LIKE" = "debian" ]; then
	sudo apt update
	sudo apt install -y fish bat exa zip make ripgrep fd-find tmux python3-venv
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

	sudo chsh -s "$(which fish)" "$(whoami)"

	curl -sS https://starship.rs/install.sh | sudo sh

	curl -LO https://github.com/neovim/neovim/releases/download/v0.9.4/nvim-linux64.tar.gz
	sudo tar -zxf nvim-linux64.tar.gz -C /usr/local/ --strip-components 1
	rm nvim-linux64.tar.gz
else
	echo "ERROR: Unknown Linux distribution!"
	exit 1
fi
