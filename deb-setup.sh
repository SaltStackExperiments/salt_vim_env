#!/usr/bin/env sh

# Clean from standard vim
sudo apt-get remove --purge vim vim-runtime vim-gnome vim-tiny vim-common vim-gui-common
# Vim dependency
sudo apt-get install liblua5.1-dev luajit libluajit-5.1 python-dev libperl-dev libncurses5-dev ruby-dev

# Clean and prepare folders
sudo rm -rf /usr/local/share/vim
sudo rm /usr/bin/vim

sudo apt-get install -y vim.nox

# install pip3 because vim.nox is compiled against python3
sudo apt-get install -y python3-pip

sudo pip install faker lorem requests

# I like to use fzf for fuzzy searching in a folder
# TODO This probably means that I need git installed
apt-get install -y git 
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
