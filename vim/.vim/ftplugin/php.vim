
setlocal noexpandtab 
" Run unit tests.
nnoremap <buffer> <localleader>b :!php %<cr>
nnoremap <buffer> <localleader>l :!php -l %<cr>
unmap <buffer> <leader>b
nnoremap <buffer> <leader>b 

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


