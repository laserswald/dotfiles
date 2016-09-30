" Appearance.

set laststatus=2
set linebreak
set matchtime=5    " Length of time in 10ths of a second to show matching parens
set number         " Line numbers.
set numberwidth=3  " Width of line number section
set relativenumber " Relative numbers to the current line
set wrap           " Line wrapping
set visualbell     " Blink the screen instead of dinging
colors chameleon
set background=light
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<

function! InsertStatusColor(mode)
    if a:mode == 'i'
        hi StatusLine ctermbg=2
        hi User1 ctermbg=2
    elseif a:mode == 'r'
        hi StatusLine ctermbg=1
        hi User1 ctermbg=1
    elseif a:mode == 'n'
        hi StatusLine ctermbg=4
        hi User1 ctermbg=4
    else 
        hi StatusLine ctermbg=6
        hi User1 ctermbg=6
    endif  
endfunction

augroup STATUSCOLOR
    autocmd InsertEnter,InsertChange * call InsertStatusColor(v:insertmode)
    autocmd InsertLeave *  call InsertStatusColor('n')
augroup end

hi User1 cterm=bold ctermfg=7 ctermbg=4
" Filename
set statusline=%{expand('%:h')}/%1*%t%*
" Git repo
set statusline+=\ %{fugitive#head()}%*
