""" settings.vim

" Edit my (n)vim configuration file.
nnoremap <leader>v  :e $MYVIMRC<cr>

" Toggle showing whitespace as characters.
nnoremap <leader>vw :set list!<cr>

" Reload my entire Vim configuration.
function! ReloadAll()
    source $MYVIMRC
    runtime! plugin/**/*.vim
    execute ":PlugInstall" 
    execute ":quit"
    execute ":PlugUpdate" 
    execute ":quit"
endfunction
nnoremap <leader>vr call ReloadAll()<cr> 

" Edit the vim configuration for this filetype.
function! GetFiletypeFile()
    return g:vimdir . '/ftplugin/' . &filetype . '.vim'
endfunction
nnoremap <leader>vf :execute "e " . GetFiletypeFile()<cr>

