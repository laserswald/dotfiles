# Source the machine's profile, if it exists.
[ -f "/etc/profile" ] && source "/etc/profile"

# Load my universal shell environment (source .shrc)

source "$HOME/.shrc"
source_dir "$HOME/.sh.d/interact.d"
setopt PROMPT_SUBST

# zsh specifics: completion

autoload -U compinit
compinit

alias zshconfig="$EDITOR ~/.zshrc"

#
# Oh My Zsh configuration
#

plugins=(
    # Stuff I find useful everywhere.
    direnv
    tmux
    # emacs
    pass
    vi-mode
    git

    # Infrastructure and work
    jira
    ansible
    minikube

    # Language plugins
    lein
)

# This shell theme is really similar to my standard shell theme.
# Let's just use it for a while.
ZSH_THEME=""

