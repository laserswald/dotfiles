" Vim syntax file
"
if exists("b:current_syntax")
    finish
endif

" Match a tag
syn match textTag '@\i*\w'
syn match textTag '@\i*(.*)\w'
hi! def link textTag Type

" some tags comment their whole line. You can mark off items this way
if !exists("g:text_tags_hide")
    let g:text_tags_hide = {"done": "", "complete": "", "x": ""}
endif

function! TextTagsSetFullLine(names, matchtype)
    for [l:key, l:value] in items(a:names)
        " Let things that are set to blank not need the parens
        if l:value ==# ""
            let l:tagregex = "^.*@" . l:key . ".*$"
        else
            let l:tagregex = "^.*@".l:key."(".l:value.").*$"
        endif
        execute "syn match ".a:matchtype." '" . l:tagregex . "' contains=textTag"
    endfor
endfunction

syn match textTask '^\s*\..*' contains=textTag
call TextTagsSetFullLine({"priority": "a"}, "textPriorityA")
call TextTagsSetFullLine({"priority": "b"}, "textPriorityB")
call TextTagsSetFullLine({"priority": "c"}, "textPriorityC")


call TextTagsSetFullLine(g:text_tags_hide, "textHide")
hi! def link textPriorityA Statement
hi! def link textPriorityB Constant
hi! def link textPriorityC String
hi! def link textImportant Constant
hi! def link textTask Structure
hi! def link textHide Comment

let b:current_syntax = "text"
