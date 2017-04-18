" GUI and Mouse
set mouse=a 
if has("gui_running")
    set guioptions=aegirLt
    set background=dark
    colors base16-default
    if has("gui_gtk2")
        set guifont="Source Code Pro for Powerline 8"
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
        set guifont=inconsolata:h12
        cd ~
    endif
endif

