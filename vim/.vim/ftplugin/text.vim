" Plain text with tagging.

function! TagRegex(name)
    return ""
endfunction

function! ToggleTag(name)
    let l:ln = getline(".")

    if match(l:ln, "@".a:name) != -1
        " remove it
        let l:ln = substitute(l:ln, " @".a:name, "", "")
    else
        " add it to the end
        let l:ln .= " @".a:name
    endif

    call setline(".", l:ln)
endfunction

command! ToggleTag

function! ToggleSelection(name)

endfunction

nnoremap <buffer> <localleader>x :call ToggleTag("done")<cr>

