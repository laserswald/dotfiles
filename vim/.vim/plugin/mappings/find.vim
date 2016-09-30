" Open a file.

nnoremap <leader>?  :lvimgrep TODO ./* <cr>
" Find a word in the current project
nnoremap <leader>lw :lvimgrep <cword> ./* <cr>

" Search for a tag in the current project
nnoremap <leader>t  :<c-u>Unite -start-insert tag<cr>

nnoremap <leader>tb :<c-u>Unite tag/include -vertical<cr>
" Open a Tagbar window
nnoremap <leader>T  :TagbarToggle<cr>

" Fuzzy find a file.
if NVIM()
    nnoremap <leader>f  :<c-u>Unite file_rec/neovim -start-insert<cr>
else
    if WINDOWS()
        nnoremap <leader>f  :Unite -start-insert file/async<cr>
    else
        nnoremap <leader>f  :find ./**/**<left>
    endif
endif


nnoremap <leader><Space> :<c-u>Unite -start-insert file_rec/async tag buffer tab<cr>
nnoremap gb :<c-u>Unite -quick-match buffer<cr>
nnoremap <leader><Space>f :<c-u>Unite -start-insert file_rec/async<cr>

" Remove highlights when searching
noremap <Space> :nohlsearch<cr>

