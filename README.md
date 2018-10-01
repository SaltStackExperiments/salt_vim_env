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
* That's it.

On vagrant machines I can simply sync a local folder to ~/.vim in the VM.

I keep thinking that I would like this to be part of a salt state. This could be done easily with gitfs, then a `salt-call state.sls my-vim`. The thing about gitfs is that it requires GitPython or pygit2 to be installed. This isn't difficult but adds a step. I suppose that in most cases I would want gitfs or GitPython on a salt-master that I manage.


## Requirements

* pip
* pip install faker
* pip install lorem


