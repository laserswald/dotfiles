""" find.vim

" Turn off search highlighting.
noremap <Space> :nohlsearch<cr>

" Fuzzy find any buffer, file, tag or tab.
nnoremap <leader><Space> :Unite -start-insert file_rec buffer tag tab<cr>

" Fuzzy find a buffer.
nnoremap <leader><Space>b :Unite buffer -start-insert<cr>

" Fuzzy find a file.
nnoremap <leader><Space>f :Unite -start-insert file/async<cr>

" Fuzzy find a tag in this file.
nnoremap <leader><Space>t :Unite tag/file -start-insert<cr>

" Find any TODO items in this entire project.
nnoremap <leader>?  :lvimgrep TODO ./* <cr>

" Write the file.
nnoremap <leader>f :w<cr>

" Run this file.
nnoremap <leader>fr :echom "This file isn't runnable. Derp."<cr>

" Find the current word in any file in this project.
nnoremap <leader>sw :lgrep \<cword\> ./* <cr>:lopen<cr>

" Open a browsable tag buffer.
nnoremap <leader>t :Unite tag/include -vertical<cr>

