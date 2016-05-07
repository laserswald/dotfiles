
setlocal omnifunc=OmniSharp#Complete
nnoremap <buffer> <leader>b :OmniSharpBuildAsync<cr>
nnoremap <buffer> <localleader>i :OmniSharpFixUsings<cr>
nnoremap <buffer> <c-]> :OmniSharpGotoDefinition<cr>
nnoremap <buffer> <localleader>t :OmniSharpFindSymbol<cr>

au cursorhold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
au bufwritepost *.cs call OmniSharp#AddToProject()
au BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

