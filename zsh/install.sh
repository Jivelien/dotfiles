#!/usr/bin/env bash

DOTFILE_ZSH_PATH=$(dirname $(realpath $0))
backup_then_link () {
	local file_name=$1
	echo "> process config file : $file_name"
	echo "> > backup file if exists"
	if [ -e $HOME/${file_name} ]; then
		cp $HOME/${file_name} $HOME/${file_name}.$(date '+%Y%m%d%H%M%S').backup
		rm $HOME/${file_name} 
	fi
	echo "> > hard link dotfile"
	ln ${DOTFILE_ZSH_PATH}/${file_name} $HOME/${file_name}
}

set -e 
echo '> check if zsh is installed'
if ! command -v zsh >/dev/null 2>&1; then
	echo '> > zsh not installed yet'
	sudo apt update
	sudo apt install -y zsh
else
	INSTALLED_VERSION=$(zsh --version | awk '{print $2}')
	AVAILABLE_VERSION=$(apt-cache policy zsh | grep Candidate | awk '{print $2}' | cut -d '-' -f1 )
	if [ "$INSTALLED_VERSION" != "$AVAILABLE_VERSION" ]; then
        	echo "> > upgrading zsh ($INSTALLED_VERSION → $AVAILABLE_VERSION)"
        	sudo apt update
        	sudo apt install -y zsh
    	else
        	echo "> > already installed"
    	fi
fi


echo '> check if go is installed'
if ! command -v go >/dev/null 2>&1; then
	echo '> > go not installed yet'
	sudo apt update
	sudo apt install -y golang
else
    INSTALLED_VERSION=$(apt-cache policy golang | grep Installed | awk '{print $2}' | cut -d '-' -f1) 
	AVAILABLE_VERSION=$(apt-cache policy golang | grep Candidate | awk '{print $2}' | cut -d '-' -f1 )
	if [ "$INSTALLED_VERSION" != "$AVAILABLE_VERSION" ]; then
        	echo "> > upgrading go ($INSTALLED_VERSION → $AVAILABLE_VERSION)"
        	sudo apt update
        	sudo apt install -y golang
    	else
        	echo "> > already installed"
    	fi
fi









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
