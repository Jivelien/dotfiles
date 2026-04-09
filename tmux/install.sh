#!/usr/bin/env bash

DOTFILE_tmux_PATH=$(dirname $(realpath $0))
backup_then_link () {
	local file_name=$1
	echo "> process config file : $file_name"
	echo "> > backup file if exists"
	if [ -e $HOME/${file_name} ]; then
		cp $HOME/${file_name} $HOME/${file_name}.$(date '+%Y%m%d%H%M%S').backup
		rm $HOME/${file_name} 
	fi
	echo "> > hard link dotfile"
	ln ${DOTFILE_tmux_PATH}/${file_name} $HOME/${file_name}
}

set -e 
echo '> check if tmux is installed'
if ! command -v tmux >/dev/null 2>&1; then
	echo '> > tmux not installed yet'
	sudo apt update
	sudo apt install -y tmux
else
	INSTALLED_VERSION=$(apt-cache policy tmux | grep Installed | awk '{print $2}' | cut -d '-' -f1 )
	AVAILABLE_VERSION=$(apt-cache policy tmux | grep Candidate | awk '{print $2}' | cut -d '-' -f1 )
	if [ "$INSTALLED_VERSION" != "$AVAILABLE_VERSION" ]; then
        	echo "> > upgrading tmux ($INSTALLED_VERSION → $AVAILABLE_VERSION)"
        	sudo apt update
        	sudo apt install -y tmux
    	else
        	echo "> > already installed"
    	fi
fi

echo '> check if tpm is available'
TPM_PLUGIN_PATH="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_PLUGIN_PATH" ]; then
	echo '> > tpm not available yet'
	mkdir -p "$(dirname $TPM_PLUGIN_PATH)"
	git clone https://github.com/tmux-plugins/tpm $TPM_PLUGIN_PATH
fi

backup_then_link .tmux.conf 
tmux source-file $HOME/.tmux.conf
$HOME/.tmux/plugins/tpm/bindings/install_plugins

