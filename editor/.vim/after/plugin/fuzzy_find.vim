
if exists("g:loaded_unite")
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
elseif exists("g:loaded_denite")
	call denite#custom#source('file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])

	call denite#custom#map(
	      \ 'insert',
	      \ '<Down>',
	      \ '<denite:move_to_next_line>',
	      \ 'noremap'
	      \)
	call denite#custom#map(
	      \ 'insert',
	      \ '<Up>',
	      \ '<denite:move_to_previous_line>',
	      \ 'noremap'
	      \)

endif

" Fuzzy find anything. Mapping is SPC SPC
if exists("g:loaded_denite")
	call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
    nnoremap <leader><Space> :Denite file_rec buffer tag -split=no<cr>
elseif exists("g:loaded_unite")
    nnoremap <leader><Space> :Unite file_rec buffer tag -start-insert -no-split<cr>
else
    echom "Fuzzy find anything isn't supported without Unite or Denite."
endif

" Find a file.
if exists("g:loaded_denite")
    nnoremap <leader><Space>f :Denite file_rec -split=no<cr>
elseif exists("g:loaded_unite")
    nnoremap <leader><Space>f :Unite -start-insert file_rec/async -no-split<cr>
else
    nnoremap <leader><Space>f :find **/*
endif

" Fuzzy find a tag in this current file.
if exists("g:loaded_denite")
	call denite#custom#var('outline', 'ignore_types', ['v'])
    nnoremap <leader><Space>t :Denite outline -split=no<cr>
elseif exists("g:loaded_unite")
    nnoremap <leader><Space>t :Unite tag/include -start-insert<cr>
else
    nnoremap <leader><Space>t :tag<space><tab>
endif

" Show a list of buffers
if exists("g:loaded_denite")
	call denite#custom#var('outline', 'ignore_types', ['v'])
    nnoremap gb :Denite buffer -split=no<cr>
elseif exists("g:loaded_unite")
    nnoremap gb :Unite buffer -start-insert -no-split<cr>
else
    nnoremap gb :ls<cr>:buffer<space>
endif

