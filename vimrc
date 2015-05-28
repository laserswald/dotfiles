" My Vimrc for awesomeness.
" Ben Davenport-Ray
""""""""""""""""""""""""""""""""""""""
echo ">^.^<"

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" Plugins. plugin plug 

Plugin 'gmarik/Vundle.vim'

" Tagging plugins.
Plugin 'majutsushi/tagbar'
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'

" Completion plugins. 
Plugin 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdcommenter'
Plugin 'honza/vim-snippets'
Plugin 'SirVer/ultisnips'
Plugin 'tpope/vim-surround'

" Themes and eye candy.
Plugin 'bling/vim-airline'
Plugin 'chriskempson/base16-vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'altercation/vim-colors-solarized'

" REPL plugins
Plugin 'jpalardy/vim-slime'

" File opening and management plugins
Plugin 'shemerey/vim-project'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-projectionist'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-fugitive'

" Filetype plugins
Plugin 'plasticboy/vim-markdown'
Plugin 'laserdude11/vim-minunit'
Plugin 'rlipscombe/vim-scons'

" Movement plugins
Plugin 'terryma/vim-multiple-cursors'
Plugin 'godlygeek/tabular'

" Building and compiling plugins
Plugin 'reinh/vim-makegreen'
Plugin 'xuhdev/SingleCompile'

" Compiler settings.
Plugin 'JalaiAmitahl/maven-compiler.vim'
Plugin 'vim-scripts/Scons-compiler-plugin'

" Unite.
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/unite-outline'

" Tools and improvements
Plugin 'sjl/gundo.vim'
Plugin 'vimoutliner/vimoutliner'

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
set ignorecase
set smartcase
set incsearch
set hlsearch
set autowrite
set mouse=n
set equalalways
set foldlevel=99
set foldmethod=syntax
set guioptions=aegirLt
set hidden
set laststatus=2
set linebreak
set ofu=syntaxcomplete#Complete
set noacd
set nocp
set number
set relativenumber
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
let maplocalleader = ","
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
nmap <Space> :nohlsearch<cr>

" Force using hjkl for movement
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

" Make jk escape to normal mode
inoremap jk <esc>

" Go by graphical lines instead of real ones
noremap j gj
noremap k gk

"" Normal mode leader mappings. 
call unite#custom#source('buffer,file,file_rec', 'matchers', 'matcher_fuzzy')
call unite#filters#sorter_default#use(['sorter_selecta'])

nnoremap <leader>ev     :e $MYVIMRC<cr>

" Default Build stuff
nnoremap <leader>b      :MakeGreen<cr>
nnoremap <leader>bf     :SCCompile<cr>
nnoremap <leader>br     :MakeGreen("rebuild") <cr>
nnoremap <leader>be     :MakeGreen("run") <cr>  
nnoremap <leader>r      :SCCompileRun<cr>

" Buffer manipulation

nnoremap <leader>e      :ProjectTree<cr>

" Git 
nnoremap <leader>gw     :Gwrite<cr>
nnoremap <leader>gc     :Gcommit<cr>
nnoremap <leader>gs     :Gstatus<cr>
nnoremap <leader>gd     :Gvdiff<cr>   

" Playback the current macro, go to the first letter of the next line
nnoremap <leader>j      @qj^

" Edit snippets files.
nnoremap <leader>sn     :UltiSnipsEdit<cr>

" Window manipulation

" Unite commands.
nnoremap <leader>bl     :Unite -buffer-name=buffers -no-split buffer<cr>

"" Visual mode leader mappings. 
" Extract to another file
vnoremap <leader>x      "md:enew"mp

"" Unified Movement
nnoremap <leader>n      :bn<cr>   
nnoremap <leader>p      :bp<cr>
nnoremap <leader>v      :vsplit<cr>
nnoremap <leader>s      :split<cr>   
nnoremap <leader>c      :new<cr>
nnoremap <leader>x      :bd<cr>
nnoremap <leader>W      <c-w>w
nnoremap <leader>M      :copen<cr>
nnoremap <leader>f      :e.<cr>
nnoremap <leader>F      :Se.<cr>
nnoremap <leader>t      :Unite -buffer-name=tags -no-split outline<cr>
nnoremap <leader>T      :TagbarToggle<cr>
nnoremap <leader>w      :w<cr>
nnoremap <leader>o      :res <cr> :vertical res <cr>
nnoremap <leader>=      <c-w>=

"" Import fixer
au filetype java nnoremap <localleader>i :JavaImport<cr> 

"" Plugin settings.
"""""""""""""""""""
" Vim Slime!
let g:slime_target = "tmux"

let g:airline_powerline_fonts = 1

" Easytags.

" Snippets, autocompletion
let g:snips_author="Ben Davenport-Ray"
let g:EclimCompletionMethod = 'omnifunc'

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

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

" Simplenote. 
source ~/.simplenoterc

"""" Auto commands.
au FileType python set omnifunc=pythoncomplete#Complete
au FileType python compiler nose
au! bufwritepost $MYVIMRC source $MYVIMRC | :AirlineRefresh
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif 

" vim: fdm=marker
