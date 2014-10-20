#!/bin/sh
# Installs this repository.
# Make sure you have cloned this repo in your user directory.
# If your user directory is 'user' then this repo should be "/home/user/dotfiles".

dfdir="/home/$USER/dotfiles"

get_subs(){
    git submodule init
    git submodule update
}

#install dot file
idf(){
    ln -s $dfdir/$1 ~/.$1
}

inst_vim(){
    idf vim
    ln -s ~/dotfiles/vim/vimrc ~/.vimrc
}

inst_xmonad(){
    idf xmonad 
}

inst_tmux(){
    idf tmux.conf
}

inst_zsh(){
    ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
    ln -s ~/dotfiles/zsh/zlogin ~/.zlogin
    ln -s ~/dotfiles/zsh/zprofile ~/.zprofile
    ln -s ~/dotfiles/zsh/zshenv ~/.zshenv
}

inst_urxvt(){
    echo $dfdir
    idf Xresources
}


get_subs

inst_vim
inst_xmonad
inst_urxvt
inst_tmux
inst_zsh
