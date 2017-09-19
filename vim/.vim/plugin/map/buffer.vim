""" buffer.vim

" Use Unite's quick-buffer matcher to switch buffers.
if exists("g:loaded_unite")
    nnoremap gb :Unite buffer -direction=dynamicbottom -quick-match<cr>
elseif exists("g:loaded_denite")
    nnoremap gb :Denite buffer<cr>
else
    nnoremap gb :ls<cr>:buffer<space>
endif

" Go to the next buffer.
nnoremap <leader>bn :bn<cr>

" Go to the previous buffer.
nnoremap <leader>bp :bp<cr>

" Delete this buffer
nnoremap <leader>bd :Bdelete<cr>
