""" buffer.vim

if exists("g:loaded_unite")
    nnoremap gb :Unite buffer -direction=botright -start-insert<cr>
elseif exists("g:loaded_denite")
    nnoremap gb :Denite buffer<cr>
else
    nnoremap gb :ls<cr>:buffer<space><tab>
endif

" Go to the next buffer.
nnoremap <leader>bn :bn<cr>

" Go to the previous buffer.
nnoremap <leader>bp :bp<cr>

" Delete this buffer
nnoremap <leader>bd :Bdelete<cr>
