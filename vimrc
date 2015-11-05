" Neovim config file. 
set nocompatible

" Neovim setup
if has('nvim')
    runtime! plugin/python_setup.vim
    set runtimepath+=/usr/share/vim/vimfiles
endif
" Plugins {{{1 
call plug#begin("~/.vim/bundle")
" Basic improvements"{{{
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-sensible'
"}}}
" Tagging plugins."{{{
Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'
"}}}
" Completion plugins. {{{2 
Plug 'ervandew/supertab'
"Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'scrooloose/nerdcommenter'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
" }}}2
" Themes and eye candy."{{{
Plug 'bling/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'nanotech/jellybeans.vim'
Plug 'noahfrederick/vim-noctu'
"}}}
" REPL plugins"{{{
Plug 'jpalardy/vim-slime'
"}}}
" File opening and management plugins"{{{
Plug 'rking/ag.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
"}}}
" Filetype plugins"{{{
Plug 'rlipscombe/vim-scons'
"}}}
" Movement plugins"{{{
Plug 'godlygeek/tabular'
Plug 'christoomey/vim-tmux-navigator'
"}}}
" Building and compiling plugins"{{{
Plug 'reinh/vim-makegreen'
"}}}
" Compiler settings."{{{
Plug 'JalaiAmitahl/maven-compiler.vim'
Plug 'vim-scripts/Scons-compiler-plugin'
"}}}
call plug#end()
" 1}}} "
"General settings and options. "{{{
syntax enable
filetype plugin indent on
set autoread
set backspace=indent,eol,start
set background=dark
set colorcolumn=80
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
set foldmethod=marker
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
"}}}
" Visual panels and looks"{{{
set background=dark
colors arccos

if has("gui_running")
  if has("gui_gtk2")
    set guifont="Source Code Pro for Powerline 8"
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=inconsolata:h12
    cd ~
  endif
endif
"}}}
" Mappings. {{{
let mapleader = ","  " Perhaps the best map leader.
let maplocalleader = "\\"
nnoremap ' `
nnoremap ` '

" Set the multibuffer mappings to something more sane.
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l
noremap <c-h> <c-w>h
noremap <Space> :nohlsearch<cr>

" Force using hjkl for movement
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

" Go by graphical lines instead of real ones
noremap j gj
noremap k gk

nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Default Build stuff
nnoremap <leader>b      :MakeGreen<cr>
nnoremap <leader>br     :MakeGreen("rebuild") <cr>
nnoremap <leader>be     :MakeGreen("run") <cr>

" Git "{{{
nnoremap <leader>gw     :Gwrite<cr>
nnoremap <leader>gc     :Gcommit<cr>
nnoremap <leader>gs     :Gstatus<cr>
nnoremap <leader>gd     :Gvdiff<cr>
"}}}

" Playback the current macro, go to the first letter of the next line
nnoremap <leader>j      @qj^
nnoremap <leader>J      @qk^ 

" Edit snippets files.
nnoremap <leader>sn     :UltiSnipsEdit<cr>

"" Visual mode leader mappings.
" Extract to another file
vnoremap <leader>x      "md:enew<cr>"mp

"" Unified Movement"{{{
nnoremap <right>        :bn<cr>
nnoremap <left>         :bp<cr>
nnoremap <leader>v      :Vex<cr>
nnoremap <leader>s      :Sex<cr>
nnoremap <leader>c      :new<cr>
nnoremap <leader>x      :bd<cr>
nnoremap <leader>W      <c-w>w
nnoremap <leader>M      :copen<cr>
nnoremap <leader>f      :e.<cr>
nnoremap <leader>F      :Se.<cr>
nnoremap <leader>t      :TagbarToggle<cr>
nnoremap <leader>w      :w<cr>
nnoremap <leader>o      :res <cr> :vertical res <cr>
nnoremap <leader>=      <c-w>=
"}}}

" Mathematical keymapping.
nnoremap <leader>km :set keymap=mathematic<cr>
nnoremap <leader>kn :set keymap=<cr>

"Capitalize the word at the cursor.
inoremap <c-u> <esc>viwUea
nnoremap <leader>u viwUe

" Force to use mappings
noremap <Up> <nop>
noremap <Down> <nop>
inoremap <esc> <nop>

" Make jk escape to normal mode
inoremap jk <esc>
vnoremap jk <esc>

"}}}
" Plugin settings."{{{

" Netrw settings
let g:netrw_banner=0

" Vim Slime"{{{
let g:slime_target = "tmux"
"}}}
" Snippets, autocompletion"{{{
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
"}}}
" Taglist {{{
let Tlist_Use_Right_Window = 1
"}}}
"}}}
" Auto commands."{{{
augroup all_group "{{{
    au! 
    " au vimenter,bufnewfile,bufreadpost * silent! call HardMode()
    au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
augroup end "}}}
augroup eclim_group "{{{
    au!
    au FileType python,java,c,c++ nnoremap <leader>F :ProjectTree<cr>
augroup end "}}}
augroup python_group "{{{
    " this one is which you're most likely to use?
    au!
    au FileType python set omnifunc=pythoncomplete#Complete
    au FileType python compiler nose
augroup end "}}}
augroup c_cpp_group "{{{
    au!
    au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
augroup end "}}}
augroup java_group "{{{
    au!
    au filetype java nnoremap <localleader>i :JavaImport<cr>
augroup end "}}}
augroup vim_group "{{{
    au!
    au filetype vim set fdm=marker
    au BufWrite $MYVIMRC source $MYVIMRC
augroup end "}}}
augroup markdown_group "{{{
    au!
augroup end "}}}
"}}}
