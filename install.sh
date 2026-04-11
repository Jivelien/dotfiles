#!/usr/bin/env bash

DOTFILE_PATH=$(dirname $(realpath $0))
$DOTFILE_PATH/zsh/install.sh
$DOTFILE_PATH/tmux/install.sh
$DOTFILE_PATH/nvim/install.sh
