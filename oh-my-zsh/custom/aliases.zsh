# My massive alias file. Viewer beware.
# Todo.txt aliases.
alias t="todo.sh"
alias ta="t add"
alias tl="clear; t ls"
alias td="t do"


# Environment aliases.
alias ea="vim ~/dotfiles/oh-my-zsh/custom/aliases.zsh"
function aa {
    echo "alias $1='$2'" >> ~/dotfiles/oh-my-zsh/custom/aliases.zsh
    source ~/.zshrc
}
alias ei3="vim ~/dotfiles/i3/config"
alias reload="source ~/.zshrc"

# Ease of use aliases.
alias ping="ping -c 3"
alias ls="ls --color -xX"
alias eclimd="/usr/share/eclipse/eclimd &"

# Tmux aliases
alias tmn="tmux new-session -s -A "

## Make this a function. Wheeeee!
alias pomo="sleep 25m && printf '\apomodoro done!\n'"

# usage: ghclone laserswald todoc
ghcl(){
    git clone http://github.com/$1/$2.git
}


