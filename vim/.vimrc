" Ben's (Neo)Vimrc.
"vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
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

" Plugins {{{1 
call plug#begin(g:vimdir . "/bundle")

    " Basic improvements
    Plug 'sjl/gundo.vim'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'jacquesbh/vim-showmarks'
    Plug 'tpope/vim-eunuch' 

    " Tagging plugins.
    Plug 'Shougo/vimproc.vim', {'do': 'mingw32-make.exe'} | Plug 'Shougo/unite.vim' | Plug 'Shougo/neoinclude.vim' | Plug 'tsukkee/unite-tag'
    Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags' | Plug 'majutsushi/tagbar'

    " Completion plugins.
    Plug 'ervandew/supertab'
    if NVIM()
        Plug 'Shougo/deoplete.nvim'
    else 
        Plug 'Shougo/neocomplete.vim'
    endif
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

    " Eye Candy
    Plug 'itchyny/lightline.vim'
    " Plug 'bling/vim-bufferline'
    Plug 'kien/rainbow_parentheses.vim'

    " Themes
    Plug 'laserswald/chameleon.vim'
    Plug 'AlessandroYorba/Alduin'
    Plug 'nanotech/jellybeans.vim'
    Plug 'altercation/vim-colors-solarized'
    Plug 'noahfrederick/vim-noctu'
    Plug 'chriskempson/base16-vim'

    " REPL plugins
    Plug 'jpalardy/vim-slime'

    " Databases.
    Plug 'vim-scripts/dbext.vim'

    " File opening and management plugins
    Plug 'rking/ag.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-projectionist'

    " Movement plugins
    Plug 'godlygeek/tabular'
    if ! NVIM()
        Plug 'christoomey/vim-tmux-navigator'
    endif

    " Building and compiling plugins
    Plug 'reinh/vim-makegreen'
    Plug 'scrooloose/syntastic'
    if NVIM()
        Plug 'benekastah/neomake'
    else
        Plug 'tpope/vim-dispatch'
    endif

    " Compiler settings.
    Plug 'JalaiAmitahl/maven-compiler.vim'
    Plug 'vim-scripts/Scons-compiler-plugin'

    " Debugging
    Plug 'joonty/vdebug'

    " Filetype specific plugins
        " Markdown
        Plug 'nelstrom/vim-markdown-folding', {'for' : 'markdown'}

        " Todo.txt
        Plug 'freitass/todo.txt-vim'

        " C
        Plug 'vim-scripts/cscope.vim', {'for' : 'c'}

        " C#
        Plug 'OmniSharp/omnisharp-vim', {'for' : 'cs'}
        
        " PHP
        Plug 'StanAngeloff/php.vim', {'for' : 'php'}
        Plug 'wdalmut/vim-phpunit', {'for' : 'php'}
        Plug 'shawncplus/phpcomplete.vim', {'for' : 'php'}
        Plug 'rayburgemeestre/phpfolding.vim', {'for' : 'php'}
    
        Plug 'mattn/emmet-vim', {'for': 'html'}

call plug#end()
" 1}}}

" Options
 
    " Essentials. This should be moved to some 'core.vim' thing
        syntax enable
        filetype plugin indent on
    
    " Appearance (ch 2)
        set laststatus=2
        set linebreak
        set matchtime=5    " Length of time in 10ths of a second to show matching parens
        set number         " Line numbers.
        set numberwidth=3  " Width of line number section
        set relativenumber " Relative numbers to the current line
        set wrap           " Line wrapping
        set visualbell     " Blink the screen instead of dinging
        colors chameleon   " My own personal colorscheme
        set background=light

    " Editing
        set completeopt=menuone,menu,longest,preview
        set backspace=indent,eol,start
        set expandtab
        set shiftwidth=4
        set softtabstop=4
        set tabstop=4
    
    " Searching
        set ignorecase
        set smartcase
        set incsearch
        set hlsearch
        set tags=./tags,~/.vim/tags/cpp_tags
        set omnifunc=syntaxcomplete#Complete

    " Folds
        set foldlevel=99
        set foldmethod=marker

    " GUI and Mouse
        if has("gui_running")
            set guioptions=aegirLt
            set mouse=n
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

    " Files
        set encoding=utf-8
        set autoread
        set autowrite
        set noautochdir

    " Splits and buffers
        set equalalways
        set hidden

" Abbreviations.
    
    iabbrev ssig ---<cr>Ben Davenport-Ray<cr>ben.davenportray@gmail.com 

" Mappings. 

    " General mapping settings.
    let mapleader = ','  " Perhaps the best map leader.
    let maplocalleader = '\'

    " Make jk escape to normal mode
    inoremap jk <esc>
    vnoremap jk <esc>

    " Editing
        
        " Read and write files.
        nnoremap <leader>c  :new<cr>
        nnoremap <leader>w  :w<cr>

        " Searching    
            
            " Remove highlights when searching
            noremap <Space> :nohlsearch<cr>
       
        " Macros
            
            " Playback the current macro, go to the first letter of the next line
            nnoremap <leader>j      @qj^
            nnoremap <leader>J      @qk^ 
            
        " Shortcut functionality
            " Execute normal command over visual selection
            nnoremap <leader>r  :'<,'>g/^/norm 
            
            " Extract to another file
            vnoremap <leader>x  "md:enew<cr>"mp
        
            "Capitalize the word at the cursor.
            inoremap <c-u> <esc>viwUea
            nnoremap <leader>u viwUe

    " Movement

        " Go by graphical lines instead of real ones
        noremap j gj
        noremap k gk

        " Open Special Files
            
            " Special remap trick to allow consistent 'sub-mappings'
            nnoremap [edit] <nop>
            nmap <leader>e [edit]
            
            " Edit my Vimrc, and then load it.
            nnoremap [edit]v :e $MYVIMRC<cr>

            " Edit snippets files.
            nnoremap [edit]sn     :UltiSnipsEdit<cr>

            " Edit the current projection file
            nnoremap [edit]p <nop>

            function! GetFiletypeFile()
                return g:vimdir . '/ftplugin/' . &filetype . '.vim'
            endfunction

            nnoremap [edit]ft :execute "e " . GetFiletypeFile()<cr>

        " Buffer, Split and Tab Movement

            " Buffers
            nnoremap <right>    :bn<cr>
            nnoremap <left>     :bp<cr>
            nnoremap <up>       :bfirst<cr>
            nnoremap <down>     :blast<cr>
            
            " Open Special Buffers
            
                " Netrw bindings
                nnoremap <leader>F  :Explore<cr>
                nnoremap <leader>s  :Sex<cr>
                nnoremap <leader>v  :Vex<cr>
                
                " Open message and location windows
                nnoremap <leader>m  :copen<cr>
                nnoremap <leader>M  :cwindow<cr>
                nnoremap <leader>L  :lwindow<cr>
                nnoremap <leader>?  :lvimgrep TODO ./* <cr>
                nnoremap <leader>lw :lvimgrep <cword> ./* <cr>
                " TODO
                
                " Open a tag in the current buffer
                nnoremap <leader>t  :Unite tag/include -start-insert<cr>
                nnoremap <leader>tb :Unite tag/include -vertical<cr>
                " Open a Tagbar window
                nnoremap <leader>T  :TagbarToggle<cr>
               
                " Fuzzy find a file.
                if NVIM()
                    nnoremap <leader>f  :<c-u>Unite file_rec/neovim -start-insert<cr>
                else
                    nnoremap <leader>f  :Unite -start-insert file/async<cr>
                endif

            " Window management
            "
            nnoremap [window] <nop>
            nmap <leader>w [window]

            noremap <c-j> <c-w>j
            noremap <c-k> <c-w>k
            noremap <c-l> <c-w>l
            noremap <c-h> <c-w>h
            nnoremap [window]   :w<cr>
            nnoremap [window]W  <c-w>w
            nnoremap [window]=  <c-w>=
            nnoremap [window]o  :res <cr> :vertical res <cr>
            nnoremap <leader>S  :split<cr>
            nnoremap <leader>V  :vsplit<cr>
            
            " Tabs
            nnoremap <home> :tabnext<cr>
            nnoremap <end>  :tabprev<cr>

            " Other stuff

                " Re align the whole file
                nnoremap <leader>= ggVG=

    " External Tools

        " Build
        nnoremap [build] <nop>
        nmap <leader>b [build]
        nnoremap [build]   :MakeGreen<cr>
        nnoremap <leader>B   :Dispatch<cr>
        nnoremap [build]r  :MakeGreen("rebuild") <cr>
        nnoremap [build]e  :MakeGreen("run") <cr>

        " Git bindings
        nnoremap [git] <nop>
        nmap <leader>g [git]
        nnoremap [git]w  :Gwrite<cr>
        nnoremap [git]c  :Gcommit<cr>
        nnoremap [git]s  :Gstatus<cr>
        nnoremap [git]d  :Gvdiff<cr>

        " Sort the selected lines
        vnoremap <leader>s :!sort<cr>
        nnoremap <leader>pi :PlugInstall<cr>

    " Plugin settings.
        " Bufferline
        let g:bufferline_echo = 0
        " Dispatch

        " EasyTags
        if WINDOWS() 
            let g:easytags_cmd = 'C:\Users\Ben\bin\ctags58\ctags.exe'
        endif
        let g:easytags_dynamic_files = 1
        let g:easytags_async = 1

        " Eclim
        let g:EclimCompletionMethod = 'omnifunc'

        " Fugitive

        " Gundo
        " Lightline
        let g:lightline = { 'colorscheme': 'chameleon' }
        " MakeGreen
        let g:makegreen_command = "Dispatch"
        " Markdown folding
        let g:markdown_fold_style = "nested"
        " Neocomplete 
        let g:neocomplete#enable_at_startup = 1

        " Netrw
        let g:netrw_banner=0

        " Projectionist
        " Rainbow Parentheses
        au VimEnter * RainbowParenthesesToggle
        " Silver Searcher
        "
        " Slime
        let g:slime_target = "tmux"

        " Snippets
        " SuperTab
        " Surround
        " Tabular
        " Tagbar
        " Ultisnips
        let g:UltiSnipsExpandTrigger       = "<tab>"
        let g:UltiSnipsJumpForwardTrigger  = "<tab>"
        let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
    
        " Unite
        call unite#filters#matcher_default#use(['matcher_fuzzy'])

        " Vim-Tmux Navigator


" Auto commands.

" Every file
augroup allgroup
    au! 
    au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
augroup end 

" Oh my god, a templating thing. 
augroup templates
	autocmd!
	autocmd BufNewFile *.* silent! exe '0r ' . g:vimdir. 'templates/' . expand("<afile>:e")
augroup END
