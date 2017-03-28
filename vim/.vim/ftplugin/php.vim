setlocal noexpandtab
" Run unit tests.
nnoremap <buffer> <localleader>b :!php %<cr>
nnoremap <buffer> <localleader>l :!php -l %<cr>
nnoremap <buffer> <localleader>t :!vendor/bin/phpunit %<cr>

function! PHP_DebugIncludes()
    " Find each instance of an include
    cursor(1, 1)
    let l:match = 0
    while l:match = search("^(require|include)", 'W') > 0
        " go up a line
        normal O
        call append('echo "Requiring a file:'.reqfile.'"')
    endwhile
endfunction

syntax keyword PHPPublic public
syntax keyword PHPPrivate private
syntax keyword PHPProtected protected

hi PHPPublic cterm=bold ctermfg=White
hi PHPPrivate cterm=bold ctermfg=Black
hi PHPProtected cterm=bold ctermfg=Cyan


call automark#Mark("class", 'c')
