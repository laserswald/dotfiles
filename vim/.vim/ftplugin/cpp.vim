setlocal omnifunc=omni#cpp#complete#Main

nnoremap <buffer> <localleader>b :!./g++ -o %:h %<cr>

