" Searching and tagging.

" Ignore case when matching a search...
set ignorecase
" ... except if I put a capital in there.
set smartcase

" Incremental search (and replace autocompletion)
set incsearch
" Highlight what I searched for.
set hlsearch

set inccommand=split

if executable("ag")
    set grepprg=ag\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif
