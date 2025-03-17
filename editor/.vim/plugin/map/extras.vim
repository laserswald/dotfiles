""" extras.vim

" Turn the current word to all-caps.
inoremap <c-u> <esc>viwUea

" Realign the entire file.
nnoremap <leader>= ggVG=

" Uppercase this word.
nnoremap <leader>u viwUe

" Execute a normal command over the entire selection.
vnoremap <leader>n  :g/^/norm 

" Extract the current selection to a new buffer.
vnoremap <leader>x  "md:enew<cr>"mp

