#!/usr/bin/env bash

DOTFILE_ZSH_PATH=$(dirname $(realpath $0))
backup_then_link () {
	local file_name=$1
	
	echo "> backup $file_name if exists"
	if [ -e $HOME/${file_name} ]; then
		cp $HOME/${file_name} $HOME/${file_name}.$(date '+%Y%m%d%H%M%S').backup
		rm $HOME/${file_name} 
	fi
	echo "> hard link dotfile config"
	ln ${DOTFILE_ZSH_PATH}/${file_name} $HOME/${file_name}
}

set -e 
echo '> Install zsh'
sudo apt update
sudo apt install zsh

echo "> Check default shell..."
if [ "$SHELL" != "$(which zsh)" ]; then
    	echo '> > Updating default shell to zsh'
    	chsh -s "$(which zsh)"
else
	echo '> > zsh is already default'
fi

echo "> Check if fzf is installed"
if ! command -v fzf &> /dev/null; then
	echo '> > Installing fzf'
	git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
	$HOME/.fzf/install
else
   	 echo '> > fzf is already installed'
fi

backup_then_link .zshrc
backup_then_link .p10k.zsh
backup_then_link .aliases

echo "> zsh setup done"
