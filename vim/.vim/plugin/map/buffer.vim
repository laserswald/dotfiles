""" buffer.vim

if exists("g:lazr_config_micro")
    nnoremap gb :ls<cr>:buffer<space>
else
    " Use Unite's quick-buffer matcher to switch buffers.
    nnoremap gb :Unite buffer -direction=dynamicbottom -quick-match<cr>
endif

" Go to the next buffer.
nnoremap <leader>bn :bn<cr>

" Go to the previous buffer.
nnoremap <leader>bp :bp<cr>

" Delete this buffer
nnoremap <leader>bd :Bdelete<cr>
