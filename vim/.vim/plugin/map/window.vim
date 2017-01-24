""" window.vim

" Make moving around a lot easier.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h

" Go to the previous window.
nnoremap <leader>w   <c-w>w

" Equalize the windows.
nnoremap <leader>w=  <c-w>=

" Show the location list.
nnoremap <leader>wL  :lwindow<cr>

" Show the error list.
nnoremap <leader>wM  :cwindow<cr>

" Focus only one window.
nnoremap <leader>wf  :resize <cr> :vertical resize <cr>

" Show the error list if there are any errors.
nnoremap <leader>wm  :copen<cr>

" Split this window in half vertically.
nnoremap <leader>ws  :split<cr>

" Split this window in half horizontally.
nnoremap <leader>wv  :vsplit<cr>
