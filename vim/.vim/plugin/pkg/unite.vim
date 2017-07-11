" Unite and Denite

if exists("g:loaded_unite")
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
elseif exists("g:loaded_denite")
	call denite#custom#source(
	\ 'file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])
endif
