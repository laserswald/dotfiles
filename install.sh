#!/bin/bash
# Installs this repository.
# Make sure you have cloned this repo in your user directory.
# If your user directory is 'user' then this repo should be "/home/user/dotfiles".

get_subs(){
    git submodule init
    git submodule update
}

inst_vim(){
    ln -s ~/dotfiles/vim ~/.vim
    ln -s ~/dotfiles/vim/vimrc ~/.vimrc
}

inst_xmonad(){
    ln -s ~/dotfiles/xmonad ~/.xmonad
}

inst_tmux(){
    ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
}

inst_zsh(){
    ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
    ln -s ~/dotfiles/zsh/zlogin ~/.zlogin
    ln -s ~/dotfiles/zsh/zprofile ~/.zprofile
    ln -s ~/dotfiles/zsh/zshenv ~/.zshenv
}

get_subs
inst_vim
inst_xmonad
inst_tmux
inst_zsh
