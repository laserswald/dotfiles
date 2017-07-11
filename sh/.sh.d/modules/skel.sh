# Personal template directory.
export SKELDIR="$HOME/skel"

[[ ! -d "$SKELDIR" ]] && mkdir "$SKELDIR"

# make a skeleton.
skel (){
    cp -r $SKELDIR/$1 $2
}

cskel () {
    cp -r "$2" "$SKELDIR/$1"
}

lsskel () {
    ls "$SKELDIR"
}
