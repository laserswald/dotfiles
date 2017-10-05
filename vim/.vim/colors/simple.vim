set background=dark
if version > 580
    highlight clear
    if exists("g:syntax_on")
        syntax reset
    endif
endif
let g:colors_name="simple"

" Transform the similar and contrast colors
" Similar is the shade closely matching the background
" Contrast is the opposite
" bright of either is the easier shade to see

" Light backgrounds
let s:similar = 15
let s:bsimilar = 7
let s:contrast = 0
let s:bcontrast = 8

if &background ==# "dark"
    let s:similar = 0
    let s:bsimilar = 8
    let s:contrast = 7
    let s:bcontrast = 15

endif

function! s:ApplyStyle(type, ...)
    let str = "highlight ".a:type
    for o in a:000
        let str = str." ".o
    endfor
    exec str
endfunc

" highlight Normal term=none cterm=none ctermbg=0

call s:ApplyStyle("Type", "ctermfg=white", "cterm=bold")
call s:ApplyStyle("Function", "ctermfg=white", "cterm=bold")

call s:ApplyStyle("Statement", "ctermfg=".s:contrast, "cterm=bold")
call s:ApplyStyle("Constant", "ctermfg=".s:bcontrast, "cterm=none")
call s:ApplyStyle("SpecialChar", "ctermfg=".s:bcontrast, "cterm=none")

call s:ApplyStyle("Identifier", "ctermfg=".s:contrast, "cterm=none")
call s:ApplyStyle("Operator", "ctermfg=".s:contrast, "cterm=none")
call s:ApplyStyle("PreProc", "ctermfg=".s:bsimilar, "cterm=bold")
call s:ApplyStyle("Special", "ctermfg=".s:contrast, "cterm=none")

call s:ApplyStyle("Comment", "ctermfg=".s:similar, "cterm=none")

" grey

" black
call s:ApplyStyle("FoldColumn", "ctermfg=1")
call s:ApplyStyle("Folded", "ctermfg=".s:bcontrast, "ctermbg=".s:bsimilar, "cterm=none")

" Display
call s:ApplyStyle("ColorColumn", "ctermbg=3")
call s:ApplyStyle("CursorLine", "ctermbg=".s:similar)
call s:ApplyStyle("Directory", "ctermfg=".s:contrast, "cterm=bold")
call s:ApplyStyle("Error", "ctermfg=".s:similar, "ctermbg=1")
call s:ApplyStyle("ErrorMsg", "ctermfg=1", "ctermbg=".s:similar)

" Searching
call s:ApplyStyle("Search", "ctermfg=".s:similar, "ctermbg=".s:bsimilar, "cterm=none")
call s:ApplyStyle("IncSearch", "ctermfg=3", "ctermbg=".s:bsimilar, "cterm=none")
call s:ApplyStyle("NonText", "ctermfg=".s:similar, "cterm=none")
call s:ApplyStyle("Visual", "ctermbg=".s:bsimilar, "cterm=none")

" Popup menu
call s:ApplyStyle("Pmenu", "ctermfg=".s:contrast, "ctermbg=".s:bsimilar)
call s:ApplyStyle("PmenuSel", "ctermfg=".s:bsimilar, "ctermbg=".s:contrast, "cterm=none")
call s:ApplyStyle("PmenuSbar", "ctermfg=".s:similar, "cterm=none")
call s:ApplyStyle("PmenuThumb", "ctermfg=".s:similar, "cterm=none")

" Borders around the splits
call s:ApplyStyle("StatusLine", "ctermfg=".s:similar, "ctermbg=".s:contrast, "cterm=none")
call s:ApplyStyle("StatusLineNC", "ctermfg=".s:contrast, "ctermbg=".s:bsimilar, "cterm=none")
call s:ApplyStyle("VertSplit", "ctermfg=".s:contrast, "ctermbg=".s:bsimilar, "cterm=none")

" Other symbols.

" General highlighting group links.
highlight! link diffAdded       DiffAdd
highlight! link diffRemoved     DiffDelete
highlight! link diffChanged     DiffChange
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
