nnoremap [settings] <nop>
nmap <leader>v [settings]
nnoremap [settings]  :e $MYVIMRC<cr>
nnoremap [settings]w :set list!<cr>
" Reload configuration
nnoremap [settings]r :source $MYVIMRC<cr>:runtime! plugin/**/*.vim<cr>
nnoremap [settings]i :PlugInstall<cr>
nnoremap [settings]u :PlugUpgrade<cr>

function! GetFiletypeFile()
    return g:vimdir . '/ftplugin/' . &filetype . '.vim'
endfunction

nnoremap [settings]f :execute "e " . GetFiletypeFile()<cr>
