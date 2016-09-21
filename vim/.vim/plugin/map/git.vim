""" git.vim

" Write this file and add it to the Git index.
nnoremap <leader>gw  :Gwrite<cr>

" Commit this repository.
nnoremap <leader>gc  :Gcommit<cr>

" Show the status of this repository.
nnoremap <leader>gs  :Gstatus<cr>

" Show the differences between the committed file and the current file.
nnoremap <leader>gd  :Gvdiff<cr>

" Push any changes to the default remote repository.
nnoremap <leader>gp  :Gpush<cr>

