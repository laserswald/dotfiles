# tmp.sh: Create a temporary workspace that gets destroyed on reboot.
#
# This creates a personal directory under /tmp that is linked into your home directory.
# This makes it easy to do weird throwaway things without cluttering up your home directory.

# Check if the folder exists, if not create it.
[ ! -d "/tmp/$USER" ] && mkdir -p /tmp/$USER

# Link the directory
[ ! -L "$HOME/tmp" ] && ln -s /tmp/$USER $HOME/tmp

# Set standard tempdir to our new temp dir
export TMPDIR="$HOME/tmp"

