" Ben's (Neo)Vimrc.
"vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={{{,}}} foldlevel=5 foldmethod=marker spell:
"
" Some of this should be split up into different files. 

" Environment
function! WINDOWS()
    return (has("win32") || has("win64")) 
endfunction
function! NVIM()
    return has('nvim')
endfunction

" Neovim setup
if NVIM()
    runtime! plugin/python_setup.vim
    set runtimepath+=/usr/share/vim/vimfiles
    let g:vimdir = "~/.config/nvim"
else
    set nocompatible
    let g:vimdir = "~/.vim"
endif

" Windows setup.
if WINDOWS()
    let g:vimdir = "~/vimfiles"
endif

" Plugins {{{
call plug#begin(g:vimdir . "/bundle")

" Basic improvements"{{{
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'jacquesbh/vim-showmarks'
Plug 'tpope/vim-eunuch' 
Plug 'takac/vim-hardtime'
"}}}

" Tagging plugins.{{{
Plug 'Shougo/vimproc.vim', {'do': 'make'} | Plug 'Shougo/unite.vim' | Plug 'Shougo/neoinclude.vim' | Plug 'tsukkee/unite-tag'
Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags' | Plug 'majutsushi/tagbar'
"}}}

" Completion plugins."{{{
Plug 'ervandew/supertab'
if NVIM()
    Plug 'Shougo/deoplete.nvim'
else 
    "Plug 'Shougo/neocomplete.vim'
endif
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"}}}

" Eye Candy {{{
Plug 'itchyny/lightline.vim'
Plug 'bling/vim-bufferline'
Plug 'kien/rainbow_parentheses.vim'
"}}}

" Themes"{{{
Plug 'laserswald/chameleon.vim'
Plug 'AlessandroYorba/Alduin'
Plug 'nanotech/jellybeans.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'noahfrederick/vim-noctu'
Plug 'chriskempson/base16-vim'
Plug 'fxn/vim-monochrome'
"}}}

" REPL plugins"{{{
Plug 'jpalardy/vim-slime'
"}}}

" Databases."{{{
Plug 'vim-scripts/dbext.vim'
"}}}

" File opening and management plugins
Plug 'tpope/vim-fugitive'
Plug 'justinmk/vim-dirvish' 
Plug 'tpope/vim-projectionist'

" Movement plugins
Plug 'godlygeek/tabular'
if ! NVIM()
    " Plug 'christoomey/vim-tmux-navigator'
endif

" Building and compiling plugins
" TODO: Switch to my fork
" Plug 'reinh/vim-makegreen'
Plug 'scrooloose/syntastic'
if NVIM()
    Plug 'benekastah/neomake'
else
    Plug 'tpope/vim-dispatch'
endif

" Compiler settings.
Plug 'JalaiAmitahl/maven-compiler.vim', {'for' : 'java'}

" Debugging
Plug 'joonty/vdebug'

" Filetype specific plugins"{{{

    " Markdown"{{{
    Plug 'nelstrom/vim-markdown-folding', {'for' : 'markdown'}
    Plug 'mattn/emmet-vim', {'for': 'html'}
    "}}}

    " Todo.txt {{{
    Plug 'freitass/todo.txt-vim'
    " }}}

    " C {{{
    Plug 'vim-scripts/cscope.vim', {'for' : 'c'}
    "}}}

    " C# {{{
    Plug 'OmniSharp/omnisharp-vim', {'for' : 'cs'}
    "}}}

    " PHP {{{
    Plug 'StanAngeloff/php.vim', {'for' : 'php'}
    Plug 'shawncplus/phpcomplete.vim', {'for' : 'php'}
    Plug 'rayburgemeestre/phpfolding.vim', {'for' : 'php'}
    "}}}

"}}}
"
call plug#end()
" 1}}}

" Options

" Essentials. This should be moved to some 'core.vim' thing
syntax enable
filetype plugin indent on

" Splits and buffers
set equalalways
set hidden

" General mapping settings.
let mapleader = ','  " Perhaps the best map leader.
let maplocalleader = '\'

" Make jk escape to normal mode
inoremap jk <esc>
vnoremap jk <esc>

" Reload configuration
nnoremap <leader>rc :source $MYVIMRC<cr>:runtime! plugin/**/*.vim<cr>
nnoremap <leader>pi :PlugInstall<cr>

" My own custom functions."{{{
function! SwitchColors()
    if &background == "dark"
        exec "set background=light"
    else
        exec "set background=dark"
    endif
    exec "colorscheme ".g:colors_name
endfunction
command! SwitchColors call SwitchColors()

function! TitleCase()
    let l:words = split(getline('.'), '\W')
    let l:chg = ""
    for word in l:words
        " Get the first letter
        let l:head = toupper(strpart(word, 0, 1))
        let l:tail = strpart(word, 1)
        let l:chg .= l:head . l:tail . " "
    endfor
    call setline('.', l:chg)
endfunction
command! TitleCase call TitleCase()
"}}}
