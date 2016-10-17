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
