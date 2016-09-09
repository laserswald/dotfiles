" Getting around with defaults and Unite.
" 
nnoremap [unite] <nop>
nmap <leader><Space> [unite]

" Find a little bit of anything. Can be slow.
nnoremap [unite] :Unite -start-insert file_rec buffer tag tab<cr>
nnoremap [unite]t :Unite tag/file -start-insert<cr>
nnoremap [unite]/ :Unite line -start-insert<cr>
nnoremap [unite]f :Unite -start-insert file/async<cr>
nnoremap [unite]b :Unite buffer -start-insert<cr>

" Open A file.  
nnoremap <leader>?  :lvimgrep TODO ./* <cr>

" Find a word in the current project
nnoremap <leader>lw :lvimgrep <cword> ./* <cr>

" Open a Tagbar window
nnoremap <leader>t :Unite tag/include -vertical<cr>

nnoremap [file] <nop>
nmap <leader>f [file]

nnoremap [file] :w<cr>
nnoremap [file]r :echom "This file isn't runnable. Derp."<cr>
nnoremap [file]s     :UltiSnipsEdit<cr>

" Remove highlights when searching
noremap <Space> :nohlsearch<cr>

