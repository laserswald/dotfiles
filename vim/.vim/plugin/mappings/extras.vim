" Re-align the whole file
nnoremap <leader>= ggVG=

" Execute normal command over visual selection
vnoremap <leader>n  :'<,'>g/^/norm 

" Extract to another file
vnoremap <leader>x  "md:enew<cr>"mp

"Capitalize the word at the cursor.
inoremap <c-u> <esc>viwUea
nnoremap <leader>u viwUe


" Reload configuration
nnoremap <leader>rc :source $MYVIMRC<cr>:runtime! plugin/**/*.vim<cr>
nnoremap <leader>pi :PlugInstall<cr>
