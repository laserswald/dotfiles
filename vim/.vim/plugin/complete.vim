"" Autocompletion
if NVIM()
    let g:deoplete#enable_at_startup = 1
else
    " Work: neocomplete is slow on adev
    let g:neocomplete#enable_at_startup = 0
endif
