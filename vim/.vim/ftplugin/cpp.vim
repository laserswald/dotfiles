setlocal omnifunc=omni#cpp#complete#Main

" Build a single file
nnoremap <buffer> <localleader>b :!./g++ -o %:h %<cr>

" Turn declarations into function bodies
nnoremap <buffer> <localleader>d :%s/;/{\r}/g<cr>

