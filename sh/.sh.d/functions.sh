
# Make sure any functions in the function files work
for file in $(ls ~/.sh.d/modules); do
    source ~/.sh.d/modules/$file
done
