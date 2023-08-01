source /etc/profile

# Universal shell environment
source "$HOME/.shrc"
source_dir "$HOME/.sh.d/interact.d"
setopt PROMPT_SUBST

# zsh specifics: completion
autoload -U compinit
compinit

# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias zshconfig="$EDITOR ~/.zshrc"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/phpbrew/bashrc ] && source ~/.phpbrew/bashrc

PATH="/home/ben/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/ben/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/ben/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/ben/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/ben/perl5"; export PERL_MM_OPT;
