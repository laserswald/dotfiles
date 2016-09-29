
Plug 'tpope/vim-repeat'

" Extra motions and actions {{{
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch' 
Plug 'justinmk/vim-sneak'
Plug 'dbakker/vim-projectroot'
Plug 'moll/vim-bbye'
"}}}

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Fuzzy Find tools {{{
Plug 'Shougo/vimproc.vim', {'do': 'make'} 
Plug 'Shougo/unite.vim' 
Plug 'Shougo/neoinclude.vim' 
Plug 'tsukkee/unite-tag'
" }}}

" Eye Candy {{{
Plug 'itchyny/lightline.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'laserswald/chameleon.vim'
Plug 'chriskempson/base16-vim'
"}}}

" Databases."{{{
Plug 'vim-scripts/dbext.vim', {'for': 'sql'}
"}}}

" File opening and management plugins {{{
Plug 'tpope/vim-fugitive'
Plug 'justinmk/vim-dirvish' 
Plug 'tpope/vim-projectionist'
"}}}
" Movement plugins {{{
Plug 'godlygeek/tabular'
Plug 'christoomey/vim-tmux-navigator'

" Completion plugins."{{{
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
" Compiler settings.
Plug 'JalaiAmitahl/maven-compiler.vim', {'for' : 'java'}

" Debugging
Plug 'joonty/vdebug', {'for': 'php'}

" Filetype specific plugins"{{{

" Organization {{{
Plug 'nelstrom/vim-markdown-folding', {'for' : 'markdown'}
Plug 'mattn/emmet-vim', {'for': 'html'}
Plug 'jceb/vim-orgmode'
" }}}

" C# {{{
Plug 'OmniSharp/omnisharp-vim', {'for' : 'cs'}
"}}}

" PHP {{{
Plug 'StanAngeloff/php.vim', {'for' : 'php'}
Plug 'shawncplus/phpcomplete.vim', {'for' : 'php'}
Plug 'rayburgemeestre/phpfolding.vim', {'for' : 'php'}
"}}}

" Golang
Plug 'fatih/vim-go', {'for': 'go'}
"}}}

