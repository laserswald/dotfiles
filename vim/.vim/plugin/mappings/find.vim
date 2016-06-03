nnoremap <leader>?  :lvimgrep TODO ./* <cr>
" Find a word in the current project
nnoremap <leader>lw :lvimgrep <cword> ./* <cr>

" Search for a tag in the current project
nnoremap <leader>t  :tag<space>

nnoremap <leader>tb :Unite tag/include -vertical<cr>
" Open a Tagbar window
nnoremap <leader>T  :TagbarToggle<cr>

" Fuzzy find a file.
if NVIM()
    nnoremap <leader>f  :<c-u>Unite file_rec/neovim -start-insert<cr>
else
    if WINDOWS()
        nnoremap <leader>f  :Unite -start-insert file/async<cr>
    else
        nnoremap <leader>f  :Unite -start-insert file_rec/async<cr>
    endif
endif


