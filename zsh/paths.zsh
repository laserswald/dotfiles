pathdirs=(
    ~/bin
    ~/scripts
    ~/.gem/ruby/2.1.0/bin  
)

for dir in $pathdirs; do
    if [ -d $dir ] ; then
        PATH+=":$dir"
    fi
done
