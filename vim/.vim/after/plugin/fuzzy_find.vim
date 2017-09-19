"
if exists("g:loaded_unite")
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
elseif exists("g:loaded_denite")
	call denite#custom#source(
	\ 'file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])
endif

" Fuzzy find anything. Mapping is SPC SPC
if exists("g:loaded_denite")
    nnoremap <leader><Space> :Denite file_rec buffer tag --no-split<cr>
elseif exists("g:loaded_unite")
    nnoremap <leader><Space> :Unite file_rec buffer tag -start-insert -no-split<cr>
else
    echom "Fuzzy find anything isn't supported without Unite or Denite."
endif

" Find a file.
if exists("g:loaded_denite")
    nnoremap <leader><Space>f :Denite file/async -no-split<cr>
elseif exists("g:loaded_unite")
    nnoremap <leader><Space>f :Unite -start-insert file_rec/async -no-split<cr>
else
    nnoremap <leader><Space>f :find **/*
endif

" Fuzzy find a tag in this file.
if exists("g:loaded_denite")
    nnoremap <leader><Space>t :Denite tag<cr>
elseif exists("g:loaded_unite")
    nnoremap <leader><Space>t :Unite tag/include -start-insert<cr>
else
    nnoremap <leader><Space>t :tag<space><tab>
endif

