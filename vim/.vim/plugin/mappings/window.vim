""" window.vim

" Make moving around a lot easier.
noremap <a-j> <c-w>j
noremap <a-k> <c-w>k
noremap <a-l> <c-w>l
noremap <a-h> <c-w>h

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

" Split this window in half vertically
nnoremap <leader>ws  :split<cr>

" Split this window in half horizontally.
nnoremap <leader>wv  :vsplit<cr>
