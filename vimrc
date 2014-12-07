""""""""""""""""""""""""""""""""""""""
" My Vimrc for awesomeness.
" Ben Davenport-Ray
""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'xuhdev/SingleCompile'
Plugin 'sjl/gundo.vim'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'reinh/vim-makegreen'
Plugin 'nanotech/jellybeans'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'rlipscombe/vim-scons'
Plugin 'shemerey/vim-project'
Plugin 'tpope/vim-projectionist'
Plugin 'vim-scripts/Scons-compiler-plugin'
Plugin 'laserdude11/vim-minunit'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jpalardy/vim-slime'
Plugin 'chriskempson/base16-vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ervandew/supertab'

call vundle#end()

"""" General settings.
syntax enable
filetype plugin indent on
set autoread
set backspace=indent,eol,start
set background=dark
set completeopt=menuone,menu,longest,preview
set encoding=utf-8
set expandtab
set ea
set foldlevel=99
set foldmethod=syntax
set guioptions=aegirLt
set hidden
set laststatus=2
set ofu=syntaxcomplete#Complete
set noacd
set nocp
set number
set shiftwidth=4
set softtabstop=4
set tabstop=4
set tags+=~/.vim/tags/cpp_tags
set vb

" Tags.

" Visual panels and looks
set background=dark
let base16colorspace=256
colors base16-default

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata-g\ for\ Powerline\ 11
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=inconsolata:h12
    cd ~
  endif
endif


"""" Mappings.
let mapleader = ","  " Perhaps the best map leader.
nnoremap ' `
nnoremap ` '

" Force to use mappings
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
inoremap <esc> <nop>

" Set the multibuffer mappings to something more sane.
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l
noremap <c-h> <c-w>h

inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>
inoremap jk <esc>

" Go by graphical lines instead of real ones
noremap j gj
noremap k gk

"" Normal mode leader mappings. 

" Highest level mappings.
" Class b: build
nnoremap <leader>b      :MakeGreen<cr>
nnoremap <leader>bf     :SCCompile<cr>
nnoremap <leader>br     :MakeGreen("rebuild")<cr>
nnoremap <leader>be     :MakeGreen("run")   
nnoremap <leader>d      :bd<cr>
nnoremap <leader>e      :! ./%<cr>
nnoremap <leader>ev     :e $MYVIMRC<cr>
" Class f: file
nnoremap <leader>f      :e.<cr>
nnoremap <leader>fs     :sp.<cr>
nnoremap <leader>fv     :vsp.<cr>
nnoremap <leader>gw     :Gwrite<cr>
nnoremap <leader>gc     :Gcommit<cr>
nnoremap <leader>gs     :Gstatus<cr>

" Playback the current macro, go to the first letter of the next line
nnoremap <leader>j      @qj^
nnoremap <leader>n      :bn<cr>   
nnoremap <leader>p      :bp<cr>
nnoremap <leader>r      :SCCompileRun<cr>

" Edit snippets files.
nnoremap <leader>s      :split<cr>   
nnoremap <leader>sn     :UltiSnipsEdit<cr>
nnoremap <leader>t      :TagbarToggle<cr>
nnoremap <leader>v      :vsplit<cr>
nnoremap <leader>m      :cwin<cr>
nnoremap <leader>w      :w<cr>

"" Visual mode leader mappings. 
vnoremap <leader>mnf  "md:enew"mp

"" Plugin settings.
"""""""""""""""""""

" Vim Slime!
let g:slime_target = "tmux"

let g:airline_powerline_fonts = 1

" Easytags.

" Snippets, autocompletion
let g:snips_author="Ben Davenport-Ray"
let g:SuperTabDefaultCompletionType = '<c-tab>'
let g:ycm_key_list_select_completion = ['<c-tab>', '<Down>']
let g:ycm_key_list_previous_completion = ['<c-s-tab>', '<Up>']

" Ctrl-P.

let g:ctrlp_map = '<c-p>' 

" OmniC++.
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" Taglist
let Tlist_Use_Right_Window = 1

"""" Auto commands.
au FileType python set omnifunc=pythoncomplete#Complete
au FileType python compiler nose
au! bufwritepost $MYVIMRC source $MYVIMRC | :AirlineRefresh
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif 
au bufread,bufenter * if winnr() != bufwinnr("__Tagbar__") && line('$') > 100 | call tagbar#OpenWindow() | endif

