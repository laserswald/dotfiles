export PYENV_ROOT="$HOME/pkg/pyenv"
command -v pyenv >/dev/null || insert_path "$PYENV_ROOT/bin"
eval "$(pyenv init -)"
