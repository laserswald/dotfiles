#!/bin/bash
# Installs this repository.
# Make sure you have cloned this repo in your user directory.
# If your user directory is 'user' then this repo should be "/home/user/dotfiles".

get_subs(){
    git submodule init
    git submodule update
}

inst_vim(){
    ln -s ~/.vim vim
    ln -s ~/.vimrc vim/vimrc
}
inst_xmonad(){
    ln -s ~/.xmonad xmonad
}

get_subs
inst_vim
inst_xmonad

