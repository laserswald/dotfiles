#!/bin/bash
# Installs this repository.
# Make sure you have cloned this repo in your user directory.
# If your user directory is 'user' then this repo should be "/home/user/dotfiles".

dfdir="/home/$USER/dotfiles"
. $dfdir/install.cfg

get_subs(){
    git submodule init
    git submodule update
}

#install dot file
idf(){
    if [[ ! -e ~/.$1 ]]; then 
        echo "installing $1 to ~/.$1"
        rm ~/.$1
        ln -s $dfdir/$1 ~/.$1
    else
        echo "skipping install of $1 " 
    fi
}

is_in(){
    echo "checking for in $1"
    for i in $1; do
        if [ $i == $2 ]; then return 0; fi
    done
    return 1
}

install(){
    cd $dfdir
    for file in *; do
        # If the file is in the "do not move" stuff then don't move it
        if is_in ${excludes[@]} $file; then
            echo "Excluding $file .";
        else 
            idf $file
        fi
    done
    cd -
}
install
