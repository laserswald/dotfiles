"" Autocompletion
if NVIM()
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
    let g:deoplete#ignore_sources.php = ['omni', 'phpcs']
else
    " Work: neocomplete is slow on adev
    let g:neocomplete#enable_at_startup = 0
endif
