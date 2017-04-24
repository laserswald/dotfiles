au QuickFixCmdPost [^l]* cwindow
au QuickFixCmdPost l* lwindow

"" Set up the best grep available
let g:lazr_greps = [ [ 'ag', "ag --vimgrep" ], [ 'ack', "ack --" ] ]
for [s:name, s:cmd] in g:lazr_greps
    if executable(s:name)
        exec "set grepprg=" . escape(s:cmd, ' ')
        break
    endif
endfor
