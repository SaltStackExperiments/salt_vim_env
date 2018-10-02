# Salt VIM Environment #

This repo contains the VIM environment that I would like to have on every SALT master I work on. It includes:

* .vimrc file
* pathogen plugin support
* bundles installed
    * nerdtree
    * Ultisnips
* Plenty of Ultisnips snippets for sls, jinja, yaml, python

## Setup

* Checkout this repo to somewhere on the system
* Symlink the `~/.vim` folder to this checkout repository
* Run `~/.vim/deb-setup.sh` or `~/.vim/rpm-setup.sh`
* That's it.

On vagrant machines I can simply sync a local folder to ~/.vim in the VM.

I keep thinking that I would like this to be part of a salt state. This could be done easily with gitfs, then a `salt-call state.sls my-vim`. The thing about gitfs is that it requires GitPython or pygit2 to be installed. This isn't difficult but adds a step. I suppose that in most cases I would want gitfs or GitPython on a salt-master that I manage.


## Requirements

* uninstall purge packaged vim because it doesn't come with python support
* install vim.nox because it comes with vim support
* pip
* pip install faker
* pip install lorem


## Notes

* vim on Debian does not come bundled with Python support
* must completely purge system of vim packages and install `vim.nox`
* vim.nox comes bundled with support for python3 not python2. This means that we must use pip3 to install the required packages.

```sh
# Clean from standard vim
sudo apt-get remove --purge vim vim-runtime vim-gnome vim-tiny vim-common vim-gui-common
# Vim dependency
sudo apt-get install liblua5.1-dev luajit libluajit-5.1 python-dev libperl-dev libncurses5-dev ruby-dev

# if you want gVim add also this 
sudo apt-get install libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev

# Clean and prepare folders
sudo rm -rf /usr/local/share/vim
sudo rm /usr/bin/vim

sudo apt-get install vim.nox
```

Must install faker and lorem python library

```
apt-get install python3-pip
pip3 install faker lorem
```

Must install fzf for fuzzy searching to work.

```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

more...
```
