
if test -z "$CHIBI_MODULE_PATH"; then
    CHIBI_MODULE_PATH="$CHIBI_MODULE_PATH:$HOME/.local/lib/scm"
else
    CHIBI_MODULE_PATH="$HOME/.local/lib/scm"
fi
export CHIBI_MODULE_PATH
