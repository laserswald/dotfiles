" Window management
"
nnoremap [window] <nop>
nmap <leader>w [window]

" Move around easier
noremap <a-j> <c-w>j
noremap <a-k> <c-w>k
noremap <a-l> <c-w>l
noremap <a-h> <c-w>h

" Write. Eh, shoot me.
nnoremap [window]   :w<cr> 

" Switch windows.
nnoremap [window]W  <c-w>w
" Equalize windows.
nnoremap [window]=  <c-w>=

" Focus (make really big) this window.
nnoremap [window]f  :resize <cr> :vertical resize <cr>

" Open message and location windows
nnoremap <leader>m  :copen<cr>
nnoremap <leader>M  :cwindow<cr>
nnoremap <leader>L  :lwindow<cr>

" Splitting
nnoremap <leader>S  :split<cr>
nnoremap <leader>V  :vsplit<cr>


