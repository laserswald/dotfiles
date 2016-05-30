
" Execute normal command over visual selection
vnoremap <leader>n  :'<,'>g/^/norm 

" Extract to another file
vnoremap <leader>x  "md:enew<cr>"mp

"Capitalize the word at the cursor.
inoremap <c-u> <esc>viwUea
nnoremap <leader>u viwUe

" Jetpack engage.
nnoremap gb         :ls<cr>:buffer<space>

