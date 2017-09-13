""" buffer.vim

" nnoremap gb :ls<cr>:buffer<space>

" Use Unite's quick-buffer matcher to switch buffers.
nnoremap gb  :Denite buffer -quick-match<cr>


" Go to the next buffer.
nnoremap <leader>bn :bn<cr>

" Go to the previous buffer.
nnoremap <leader>bp :bp<cr>

" Delete this buffer
nnoremap <leader>bd :Bdelete<cr>
