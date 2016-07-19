ding () { 
    echo "\a" 
}

function aa {
    echo "alias $1=$2" >> ~/etc/oh-my-zsh/custom/aliases.zsh
    source ~/.zshrc
}

function search {
    query=$(echo "$@" | tr ' ' +)
    w3m "https://duckduckgo.com/?q=$query"
}
alias ddg=search

