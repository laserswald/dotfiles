# Laserswald's standard profile.

# Load any files in my shell directory.
if [[ -d ~/.sh.d ]]; then
    for file in $(ls ~/.sh.d); do
        source ~/.sh.d/$file
    done
fi
