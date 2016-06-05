function! Automark(regex, character)
    call cursor(1, 1)
    " Get the first result of the regex 
    let line = search(a:regex, 'cWn')
    if line !=# 0
        call setpos("'".a:character, [0, line, 1, 0])
    else 
        throw "Automark: regex not found, no mark set."
    endif
endfunction

