# Personal template directory.
export SKEL_PATH=${SKEL_PATH:-"$XDG_TEMPLATES_DIR"}

[[ ! -d "$SKEL_PATH" ]] && mkdir "$SKEL_PATH"

# make a skeleton.
skel (){
    cp -r "$SKEL_PATH/$1" "$2"
}

cskel () {
    cp -r "$2" "$SKEL_PATH/$1"
}

lsskel () {
    ls "$SKEL_PATH"
}
