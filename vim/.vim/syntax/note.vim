" Vim syntax file
"
if exists("b:current_syntax")
    finish
endif 

syn match taskpaperTag '@\i+'
syn match taskpaperSection '\s*.*:\s*$' contains=taskpaperTag
syn match taskpaperTask '^\s*-.*$' contains=taskpaperTag
syn match taskpaperDone '^\s*-.*@done.*$' 


hi def link taskpaperSection Function
hi def link taskpaperTask Keyword
hi def link taskpaperDone Comment
hi def link taskpaperTag Variable

let b:current_syntax = "taskpaper"
