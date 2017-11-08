" Appearance.

" Always show the status bar.
set laststatus=2

" Break lines at a good place, not in the middle of a word
set linebreak

" Length of time in 10ths of a second to show matching parens
set matchtime=5

" Line numbers.
set number

" Width of line number section
set numberwidth=3

" Relative numbers to the current line
set relativenumber

" Line wrapping
set wrap

" Blink the screen instead of dinging
set visualbell

colors mono
set background=dark
set listchars=eol:¬,tab:>·,trail:-,extends:>,precedes:<

" Git highlight group
hi User1 ctermfg=yellow ctermbg=7
hi User2 ctermfg=darkred ctermbg=7
set statusline=%<%t
set statusline+=\ %2*%M%*
set statusline+=\ %1*%{fugitive#head()}%*
