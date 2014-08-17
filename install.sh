#!/bin/bash
# Installs this repository.
# Make sure you have cloned this repo in your user directory.
# If your user directory is 'user' then this repo should be "/home/user/dotfiles".

get_subs(){
    git submodule init
    git submodule update
}

inst_vim(){
    ln -s vim ~/.vim
    ln -s vim/vimrc ~/.vimrc
}

inst_xmonad(){
    ln -s xmonad ~/.xmonad
}

inst_tmux(){
    ln -s tmux.conf ~/.tmux.conf
}

inst_urxvt(){
    ln -s Xresources ~/.Xresources
}
get_subs
inst_vim
inst_xmonad
inst_tmux
inst_urxvt
