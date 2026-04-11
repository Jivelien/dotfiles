#!/usr/bin/env bash

set -x
DOTFILE_NVIM_PATH=$(dirname $(realpath $0))
set -e 
echo '> check if neovim is installed'
if ! command -v nvim >/dev/null 2>&1; then
	echo '> > neovim not installed yet'
	sudo apt update
	sudo apt install -y neovim
else
    INSTALLED_VERSION=$(apt-cache policy neovim | grep Installed | awk '{print $2}' | cut -d '-' -f1) 
	AVAILABLE_VERSION=$(apt-cache policy neovim | grep Candidate | awk '{print $2}' | cut -d '-' -f1 )
	if [ "$INSTALLED_VERSION" != "$AVAILABLE_VERSION" ]; then
        	echo "> > upgrading neovim ($INSTALLED_VERSION → $AVAILABLE_VERSION)"
        	sudo apt update
        	sudo apt install -y neovim
    	else
        	echo "> > already installed"
    fi
fi

echo '> backup nvim config if necessary'
if [ -d "$HOME/.config/nvim" ] && ! [ -L "$HOME/.config/nvim" ]; then
    mv $HOME/.config/nvim  $HOME/.config/nvim.$(date '+%Y%m%d%H%M%S').backup  
fi


echo '> link config'
ln -sfn $DOTFILE_NVIM_PATH $HOME/.config/nvim

