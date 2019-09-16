source /etc/profile

# Universal shell environment
source ~/.shrc
source_dir ~/.sh.d/interact.d
setopt PROMPT_SUBST

# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias zshconfig="$EDITOR ~/.zshrc"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
