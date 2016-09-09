""" Project specific bindings.

" Build
nnoremap [project] <nop>
nmap <leader>p [project]

" Default binding: build project
nnoremap [project] :Dispatch<cr>  

" e: edit projections
nnoremap [project]e :e ./.projections.json<cr>
