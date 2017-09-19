" EasyTags
if WINDOWS()
    let g:easytags_cmd = 'C:\Users\Ben\bin\ctags58\ctags.exe'
endif

let g:easytags_dynamic_files = 2
let g:easytags_async = 1

if WINDOWS()
    let g:easytags_by_filetype = '$HOME/vimfiles/tags'
else " UNIX
    let g:easytags_by_filetype = "~/.tags/"
endif
let g:easytags_languages = {
            \   'php': {
            \       'args': ['-php-kinds=-v'],
            \   }
            \}

