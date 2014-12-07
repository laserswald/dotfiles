# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' file-sort access
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=10
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl true
zstyle :compinstall filename '/home/ben/.zshrc'

autoload -Uz compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ben/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U colors && colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
precmd(){
    vcs_info
}

zstyle ':vcs_info:git*' formats " %{$fg[white]%}%r%{$reset_color%} (%{$fg[yellow]%}%b%{$reset_color%}%m%{$fg[red]%}%u%{$reset_color%}%{$fg[magenta]%}%c%{$reset_color%})"
setopt prompt_subst
PROMPT='%{$fg[green]%}%n%{$reset_color%} at %{$fg[blue]%}%m%{$reset_color%}${vcs_info_msg_0_}> '
RPROMPT='%{$fg[yellow]%}%~%{$reset_color%}'
export EDITOR="vim"
source "/home/ben/dotfiles/zsh/aliases.zsh"
source "/home/ben/dotfiles/zsh/functions.zsh"
eval "$(fasd --init auto)"

# Base16 Shell
BASE16_SHELL="$HOME/dotfiles/zsh/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL
