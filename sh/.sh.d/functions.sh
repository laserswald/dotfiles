# Make sure any functions in the function files work
for file in ~/.sh.d/modules/*.sh ; do
    . "$file"
done

gd (){ 
    cd "$1" || exit
    ls 
}
