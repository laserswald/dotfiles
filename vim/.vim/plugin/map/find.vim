""" find.vim
""
"" Shortcuts in order to find items.

" Turn off search highlighting.
noremap <Space> :nohlsearch<cr>

" Fuzzy find any buffer, file, tag or tab.
nnoremap <leader><Space> :Unite -start-insert file_rec buffer tag tab<cr>

" Find a buffer.
if exists("g:loaded_unite")
    nnoremap <leader><Space>b :Unite buffer -start-insert<cr>
else
    nnoremap <leader><Space>b :buffer
endif

" Find a file.
if exists("g:loaded_unite")
    nnoremap <leader><Space>f :Unite -start-insert file_rec/async<cr>
else
    nnoremap <leader><Space>f :find **/*
endif

" Fuzzy find a tag in this file.
if exists("g:loaded_unite")
    nnoremap <leader><Space>t :Unite tag/file -start-insert<cr>
else
    nnoremap <leader><Space>t :tag
endif

" Find any TODO items in this entire project.
nnoremap <leader>?  :lvimgrep TODO ./* <cr>

" Find the current word in any file in this project.
nnoremap <leader>sw :lgrep \<cword\> ./* <cr>:lopen<cr>

" Open a browsable tag buffer.
nnoremap <leader>t :Unite tag/include -vertical<cr>

" Write the file.
nnoremap <leader>f :w<cr>

" Run this file.
nnoremap <leader>fr :echom "This file isn't runnable. Derp."<cr>
