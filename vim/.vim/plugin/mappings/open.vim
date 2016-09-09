
" Special remap trick to allow consistent 'sub-mappings'
nnoremap [edit] <nop>
nmap <leader>e [edit]

" Edit my Vimrc, and then load it.
nnoremap [edit]v 

" Edit snippets files.
nnoremap [edit]sn     :UltiSnipsEdit<cr>
nnoremap [edit]n      :e ~/notes.txt<cr>

" Edit the current projection file
nnoremap [edit]p :e ./.projections.json<cr>

