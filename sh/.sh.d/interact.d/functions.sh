# Make sure any functions in the function files work

search () {
    w3m "duckduckgo.com/?q=$1"
}

godir (){
    cd "$1" || exit
    ls
}

