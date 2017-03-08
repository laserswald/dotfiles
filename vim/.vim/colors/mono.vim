set background=dark
if version > 580
    highlight clear
    if exists("g:syntax_on")
        syntax reset
    endif
endif
let g:colors_name="mono"

" 0:black 1:red 2:green 3:yellow 4:blue 5:purple 6:cyan 7:white

"" In order of 'importance'

" bold white
highlight Statement    term=none cterm=bold ctermfg=15  ctermbg=none
" bright white
highlight Function   term=none cterm=bold ctermfg=15    ctermbg=none
" bold color
highlight Type term=none cterm=bold ctermfg=4 ctermbg=none
" bright color
highlight Special term=none cterm=none ctermfg=12    ctermbg=none
" color
highlight Constant     term=none cterm=none ctermfg=4    ctermbg=none
" white
highlight Identifier   term=none cterm=none ctermfg=7    ctermbg=none
highlight Operator      term=none cterm=none ctermfg=7    ctermbg=none
" foreground
" bold grey
highlight StorageClass term=none cterm=bold ctermfg=8    ctermbg=none
" grey
highlight Comment      term=none cterm=none ctermfg=8    ctermbg=none
" black

highlight FoldColumn   term=none cterm=none ctermfg=0    ctermbg=none
highlight Folded       term=none cterm=none ctermfg=15   ctermbg=1

highlight IncSearch       term=none cterm=bold ctermfg=8    ctermbg=0
highlight Search       term=none cterm=none ctermfg=8    ctermbg=0

" Other symbols.
highlight ColorColumn  term=none cterm=none ctermfg=none ctermbg=3
highlight Cursor       term=none cterm=none ctermfg=3    ctermbg=none
highlight CursorLine   term=none cterm=none ctermfg=none ctermbg=none
highlight DiffAdd      term=none cterm=none ctermfg=2    ctermbg=none
highlight DiffChange   term=none cterm=none ctermfg=none ctermbg=none
highlight DiffDelete   term=none cterm=none ctermfg=7    ctermbg=1
highlight DiffText     term=none cterm=none ctermfg=7    ctermbg=4
highlight Directory    term=none cterm=none ctermfg=4    ctermbg=0
highlight Error        term=none cterm=none ctermfg=0    ctermbg=1
highlight ErrorMsg     term=none cterm=none ctermfg=1    ctermbg=0

highlight NonText      term=none cterm=none ctermfg=0    ctermbg=none
highlight Normal       term=none cterm=none ctermfg=7    ctermbg=none
highlight Pmenu        term=none cterm=none ctermfg=0    ctermbg=7
highlight SpecialKey   term=none cterm=none ctermfg=0    ctermbg=none
highlight StatusLine   term=none cterm=none ctermfg=0    ctermbg=none
" highlight StatusLineNC term=none cterm=bold ctermfg=0    ctermbg=none
highlight TabLineSel   term=none cterm=none ctermfg=7    ctermbg=none
highlight Todo         term=none cterm=none ctermfg=3    ctermbg=1
highlight Underlined   term=underline cterm=underline ctermfg=none   ctermbg=none
highlight VertSplit    term=none cterm=none ctermfg=6    ctermbg=0
highlight Visual       term=none cterm=none ctermfg=0    ctermbg=7
highlight WarningMsg   term=none cterm=none ctermfg=3    ctermbg=none

" General highlighting group links.
highlight! link diffAdded       DiffAdd
highlight! link diffRemoved     DiffDelete
highlight! link diffChanged     DiffChange
highlight! link StatusLineNC    StatusLine
highlight! link Title           Normal
highlight! link LineNr          NonText
highlight! link MoreMsg         Normal
highlight! link Question        DiffChange
highlight! link TabLine         StatusLineNC
highlight! link TabLineFill     StatusLineNC
highlight! link VimHiGroup      VimGroup
highlight! link VimHiGroup      VimGroup

" Test the actual colorscheme
syn match Comment      "\"__Comment.*"
syn match Constant     "\"__Constant.*"
syn match Cursor       "\"__Cursor.*"
syn match CursorLine   "\"__CursorLine.*"
syn match DiffAdd      "\"__DiffAdd.*"
syn match DiffChange   "\"__DiffChange.*"
syn match DiffText     "\"__DiffText.*"
syn match DiffDelete   "\"__DiffDelete.*"
syn match Folded       "\"__Folded.*"
syn match Function     "\"__Function.*"
syn match Identifier   "\"__Identifier.*"
syn match IncSearch    "\"__IncSearch.*"
syn match NonText      "\"__NonText.*"
syn match Normal       "\"__Normal.*"
syn match Pmenu        "\"__Pmenu.*"
syn match PreProc      "\"__PreProc.*"
syn match Search       "\"__Search.*"
syn match Special      "\"__Special.*"
syn match SpecialKey   "\"__SpecialKey.*"
syn match Statement    "\"__Statement.*"
syn match StatusLine   "\"__StatusLine.*"
syn match StatusLineNC "\"__StatusLineNC.*"
syn match String       "\"__String.*"
syn match Todo         "\"__Todo.*"
syn match Type         "\"__Type.*"
syn match Underlined   "\"__Underlined.*"
syn match VertSplit    "\"__VertSplit.*"
syn match Visual       "\"__Visual.*"

"__Statement            if else return for switch
"__Function             function sblah()
"__Type                 int float char void unsigned uint32_t
"__Special              true false NULL SIGTERM
"__Constant             var = SHBLAH
"__Normal               Typical text goes like this
"__Identifier           Never ran into that actually...
"__Comment              /* this is a comment */
"__PreProc              #define SHBLAH true

"__Cursor               char under the cursor?
"__CursorLine           Line where the cursor is
"__DiffAdd              +line added from file.orig
"__DiffChange           line changed from file.orig
"__DiffText             actual changes on this line
"__DiffDelete           -line removed from file.orig
"__Folded               +--- 1 line : Folded line ---
"__IncSearch            Next search term
"__NonText              This is not a text, move on
"__Pmenu                Currently selected menu item
"__Search               This is what you're searching for
"__SpecialKey           Never ran into that either
"__StatusLine           Statusline of current windows
"__StatusLineNC         Statusline of other windows
"__String               "Hello, World!"
"__Todo                 TODO: remove todos from source
"__Underlined           Anything underlined
"__VertSplit            :vsplit will only show ' | '
"__Visual               Selected text looks like this
