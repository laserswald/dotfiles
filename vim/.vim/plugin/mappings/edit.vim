
" Edit snippets files.
nnoremap <leader>n      :e ~/notes.txt<cr>

" Edit the current projection file

function! GetFiletypeFile()
    return g:vimdir . '/ftplugin/' . &filetype . '.vim'
endfunction

nnoremap [edit]ft :execute "e " . GetFiletypeFile()<cr>
