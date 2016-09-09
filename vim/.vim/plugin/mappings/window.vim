" Window management
"
nnoremap [window] <nop>
nmap <leader>w [window]

" Move around easier
noremap <a-j> <c-w>j
noremap <a-k> <c-w>k
noremap <a-l> <c-w>l
noremap <a-h> <c-w>h

" Default action: switch between last windows.
nnoremap [window]   <c-w>w

" Equalize windows.
nnoremap [window]=  <c-w>=

" Focus (make really big) this window.
nnoremap [window]f  :resize <cr> :vertical resize <cr>

" Open message and location windows
nnoremap [window]m  :copen<cr>
nnoremap [window]M  :cwindow<cr>
nnoremap [window]L  :lwindow<cr>

" Splitting
nnoremap [window]s  :split<cr>
nnoremap [window]v  :vsplit<cr>


