#!/usr/bin/env sh

sudo apt-get update

# Clean from standard vim
sudo apt-get remove --purge -y vim vim-runtime vim-gnome vim-tiny vim-common vim-gui-common

# Vim dependency
sudo apt-get install -y liblua5.1-dev luajit libluajit-5.1 python-dev libperl-dev libncurses5-dev ruby-dev

# Clean and prepare folders
sudo rm -rf /usr/local/share/vim
sudo rm /usr/bin/vim

sudo apt-get install -y vim.nox

# install pip3 because vim.nox is compiled against python3
sudo apt-get install -y python3-pip

sudo pip3 install faker lorem requests

# I like to use fzf for fuzzy searching in a folder
# TODO This probably means that I need git installed
apt-get install -y git 
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# fzf needs ~/.bashrc to be re-sourced because it adds a new path
source ~/.bashrc
