
function! Markdown_makeHeader(number)
    if a:number ==# 1
        normal! yypVr=
    else if a:number ==# 2
        normal! yypVr-
    else 
        execute "normal!" . a:number . "I#"
    endif
endfunction

