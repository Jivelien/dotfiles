#!/usr/bin/env bash

set -x
DOTFILE_NVIM_PATH=$(dirname $(realpath $0))
set -e 
echo '> check if neovim is installed'
if ! command -v nvim >/dev/null 2>&1; then
	echo '> > neovim not installed yet'
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
fi

echo '> backup nvim config if necessary'
if [ -d "$HOME/.config/nvim" ] && ! [ -L "$HOME/.config/nvim" ]; then
    mv $HOME/.config/nvim  $HOME/.config/nvim.$(date '+%Y%m%d%H%M%S').backup  
fi


echo '> link config'
ln -sfn $DOTFILE_NVIM_PATH $HOME/.config/nvim

