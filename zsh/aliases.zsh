# Building blocks for aliases.

# Append to file.
appnd () {
    echo $2 >> $1
}

# Todo.txt aliases.
alias t="todo.sh"
alias ta="t add"
alias tl="t ls"

# Environment aliases.
alias eal="vim ~/dotfiles/zsh/aliases.zsh"

# Ease of use aliases.
alias ping="ping -c 3"
alias ls="ls --color -xX"
alias eclimd="/usr/share/eclipse/eclimd"
alias v="f -e vim"
## Make this a function. Wheeeee!
alias pomo="sleep 25m && printf '\apomodoro done!\n'"

# Git flow aliases
gfmkfeat(){
    git checkout -b $1 develop
}
gfmgfeat(){
    git checkout $2
    git merge --no-ff $1
}


# Script-added aliases. These should be sorted around.
