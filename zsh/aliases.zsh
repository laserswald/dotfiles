# Building blocks for aliases.

# Append to file.
appnd () {
    echo $2 >> $1
}

# Todo.txt aliases.
alias t="todoc -f ~/org/todo.txt"
alias ta="t append"
alias tl="t ls"

# Environment aliases.
alias eal="vim ~/dotfiles/zsh/aliases.zsh"

# Ease of use aliases.
alias ping="ping -c 3"
alias ls="ls --color -xX"
alias eclimd="/usr/share/eclipse/eclimd"
# Script-added aliases. These should be sorted around.
