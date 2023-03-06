export PYENV_ROOT="$HOME/pkg/pyenv"
command -v pyenv >/dev/null || insert_path "$PYENV_ROOT/bin"
eval "$(pyenv init -)"

[ -d "$HOME/Library/Python/3.9/bin" ] && insert_path "$HOME/Library/Python/3.9/bin" 
