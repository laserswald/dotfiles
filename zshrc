
autoload -U colors && colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn bzr hg 
zstyle ':vcs_info:*' check-for-changes true
precmd(){
    vcs_info
}

zstyle ':vcs_info:git*' formats " %{$fg[white]%}%r%{$reset_color%} (%{$fg[yellow]%}%b%{$reset_color%}%m%{$fg[red]%}%u%{$reset_color%}%{$fg[magenta]%}%c%{$reset_color%})"
setopt prompt_subst
PROMPT='%{$fg[green]%}%n%{$reset_color%} at %{$fg[blue]%}%m%{$reset_color%} in %{$fg[yellow]%}%~%{$reset_color%} > '
RPROMPT='${vcs_info_msg_0_}'


