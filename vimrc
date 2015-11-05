" Neovim config file. 
set nocompatible

" Neovim setup
if has('nvim')
    runtime! plugin/python_setup.vim
endif
set runtimepath+=/usr/share/vim/vimfiles
" Plugins {{{1 
call plug#begin("~/.vim/bundle")
" Basic improvements"{{{
Plug 'benekastah/neomake'
Plug 'floobits/floobits-neovim'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-sensible'
Plug 'Rykka/mathematic.vim'
"}}}
" Tagging plugins."{{{
Plug 'majutsushi/tagbar'
Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'
"}}}
" Completion plugins. {{{2 
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'scrooloose/nerdcommenter'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
" }}}2
" Themes and eye candy."{{{
Plug 'bling/vim-airline'
Plug 'chriskempson/base16-vim'
Plug 'nanotech/jellybeans.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'noahfrederick/vim-noctu'
"}}}
" REPL plugins"{{{
Plug 'jpalardy/vim-slime'
"}}}
" File opening and management plugins"{{{
Plug 'kien/ctrlp.vim'
Plug 'rking/ag.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-vinegar'
"}}}
" Filetype plugins"{{{
Plug 'plasticboy/vim-markdown'
Plug 'laserswald/vim-minunit'
Plug 'rlipscombe/vim-scons'
"}}}
" Movement plugins"{{{
Plug 'terryma/vim-multiple-cursors'
Plug 'godlygeek/tabular'
Plug 'wikitopian/hardmode'
Plug 'christoomey/vim-tmux-navigator'
"}}}
" Building and compiling plugins"{{{
Plug 'reinh/vim-makegreen'
Plug 'xuhdev/SingleCompile'
"}}}
" Compiler settings."{{{
Plug 'JalaiAmitahl/maven-compiler.vim'
Plug 'vim-scripts/Scons-compiler-plugin'
"}}}
" Unite."{{{
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
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
let base16colorspace=256
colors noctu

let g:airline_powerline_fonts=1

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

"" Normal mode leader mappings.
call unite#custom#source('buffer,file,file_rec', 'matchers', 'matcher_fuzzy')
call unite#filters#sorter_default#use(['sorter_selecta'])

nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Default Build stuff
nnoremap <leader>b      :MakeGreen<cr>
nnoremap <leader>bf     :SCCompile<cr>
nnoremap <leader>br     :MakeGreen("rebuild") <cr>
nnoremap <leader>be     :MakeGreen("run") <cr>
nnoremap <leader>r      :SCCompileRun<cr>

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

" Window manipulation

" Unite commands.
nnoremap <leader>bl     :Unite -buffer-name=buffers -no-split buffer<cr>

"" Visual mode leader mappings.
" Extract to another file
vnoremap <leader>x      "md:enew<cr>"mp

"" Unified Movement"{{{
nnoremap <leader>n      :bn<cr>
nnoremap <leader>p      :bp<cr>
nnoremap <leader>v      :Vex<cr>
nnoremap <leader>s      :Sex<cr>
nnoremap <leader>c      :new<cr>
nnoremap <leader>x      :bd<cr>
nnoremap <leader>W      <c-w>w
nnoremap <leader>M      :copen<cr>
nnoremap <leader>f      :e.<cr>
nnoremap <leader>F      :Se.<cr>
nnoremap <leader>T      :Unite -buffer-name=tags -no-split outline<cr>
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
noremap <Left> <nop>
noremap <Right> <nop>
inoremap <esc> <nop>

" Make jk escape to normal mode
inoremap jk <esc>
vnoremap jk <esc>

"}}}
" Plugin settings."{{{
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
" Ctrl-P."{{{
let g:ctrlp_map = '<c-p>'
"}}}
" Taglist {{{
let Tlist_Use_Right_Window = 1
"}}}
" Simplenote."{{{
source ~/.simplenoterc
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
augroup vim_group "{{{

"}}}
