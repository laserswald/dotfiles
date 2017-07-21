""" find.vim
""
"" Shortcuts in order to find items.


" Find any TODO items in this entire project.
nnoremap <leader>?  :grep -R TODO .<cr>

" Find the current word in any file in this project. (Reverse of C-])
nnoremap <leader>]  :silent! lgrep -R <cword> . <cr>

" Write the file.
nnoremap <leader>f :w<cr>

" Run this file.
nnoremap <leader>fr :echom "This file isn't runnable. Derp."<cr>

" Turn off search highlighting.
noremap <Space> :nohlsearch<cr>
