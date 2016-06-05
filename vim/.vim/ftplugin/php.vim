setlocal noexpandtab 
" Run unit tests.
nnoremap <buffer> <localleader>b :!php %<cr>
nnoremap <buffer> <localleader>l :!php -l %<cr>
nnoremap <buffer> <localleader>t :!vendor/bin/phpunit %<cr>

function! PHP_DebugIncludes()
    " Find each instance of an include 
    cursor(1, 1)
    let l:match = 0
    while l:match = search("^require", 'W') > 0 
        " go up a line


        normal k
        call append('echo "Requiring a file";') 
    endwhile
endfunction

call Automark("__construct", 'c')
