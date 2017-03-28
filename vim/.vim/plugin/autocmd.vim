" Auto commands.

" Every file
augroup autocommands
    au!
    au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
    " Oh my god, a templating thing.
	autocmd BufNewFile *.* silent! exe '0r ' . g:vimdir . 'templates/' . expand("<afile>:e")
    if NVIM()
        autocmd BufWritePost * Neomake
    endif

    au bufread,BufNewFile *.txt set filetype=notes.txt

    au BufWritePre * silent! %s/\s\+$//e
augroup end
