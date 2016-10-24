" Vim syntax file
"
syn match notetxtTag '@\i*'
syn match notetxtSection '\s*.*:\s*$' contains=notetxtTag
syn match notetxtTask '^\s*-.*$' contains=notetxtTag
syn match notetxtDone '^\s*-.*@done.*$' 

let b:current_syntax = "note.txt"

hi def link notetxtSection Function
hi def link notetxtTask Keyword
hi def link notetxtDone Comment
hi def link notetxtTag Variable
