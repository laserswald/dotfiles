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
nnoremap <leader>vr :call ReloadAll()<cr> 

" Edit the vim configuration for this filetype.
function! GetFiletypeFile()
    return g:vimdir . '/ftplugin/' . &filetype . '.vim'
endfunction
nnoremap <leader>vf :execute "e " . GetFiletypeFile()<cr>

function! EditMapping(...)
    call setloclist(0, [], ' ', "EditMapping") 
    if 0 == len(a:000)
        execute ":silent lgrep! 'let mapleader' " . g:vimdir . "/plugin/**/*.vim " . $MYVIMRC
    else 
        for mapname in a:000
            execute ":silent lgrepa! 'map <leader>".mapname."' ".g:vimdir."/plugin/**/*.vim ".$MYVIMRC
        endfor
    endif
    execute ":silent lwindow"
endfunction

command! -nargs=? EditMapping :call EditMapping(<f-args>)
