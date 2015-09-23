# My massive alias file. Viewer beware.
# Todo.txt aliases.
alias t="todo.sh"
alias ta="t add"
alias tl="t ls"
alias td="t do"


# Environment aliases.
alias ea="vim ~/etc/oh-my-zsh/custom/aliases.zsh"
alias ei3="vim ~/dotfiles/i3/config"
alias reload="source ~/.zshrc"

# Ease of use aliases.
alias ping="ping -c 3"
alias ls="ls --color -xX"
alias eclimd="/usr/lib/eclipse/eclimd &"

# Tmux aliases
alias tns="tmux new-session -s -A "


## Make this a function. Wheeeee!
alias pomo="sleep 25m && printf '\apomodoro done!\n'"

# usage: ghclone laserswald todoc
ghcl(){
    git clone http://github.com/$1/$2.git
}
alias tmux=tmux -2
#alias vim=nvim
alias sctl="systemctl"
alias sctll="systemctl list-units"
alias nctl="netctl"
alias xm="xrdb -merge ~/.Xresources"
