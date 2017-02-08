# Make sure any functions in the function files work
for file in ~/.sh.d/modules/*.sh ; do
    . "$file"
done

search () {
    w3m "duckduckgo.com/?q=$1"
}

godir (){ 
    cd "$1" || exit
    ls 
}

