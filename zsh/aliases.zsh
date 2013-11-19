# Building blocks for aliases.

# Append to file.
appnd () {
    echo $2 >> $1
}

# Todo.txt aliases.
alias t="~/scripts/todo.sh"
alias ta="t append"
alias tl="t ls"

# Environment aliases.
alias eal="vim ~/dotfiles/zsh/aliases.zsh"

# Ease of use aliases.
alias ping="ping -c 3"
alias ls="ls --color -xX"

# Script-added aliases. These should be sorted around.
