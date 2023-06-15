
PYENV_ROOT="$HOME/pkg/pyenv"

if [ -d "$PYENV_ROOT/bin" ]; then
    export PYENV_ROOT="$HOME/pkg/pyenv"
    insert_path "$PYENV_ROOT/bin"
fi

if command -v pyenv >/dev/null; then
    eval "$(pyenv init -)"
fi

[ -d "$HOME/Library/Python/3.9/bin" ] && insert_path "$HOME/Library/Python/3.9/bin" 
