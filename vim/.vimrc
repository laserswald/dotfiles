" Ben's Vimrc.
"vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
" Some of this should be split up into different files. 
set nocompatible

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
endif

" Windows setup.
if WINDOWS()
    
endif

" Plugins {{{1 
call plug#begin("~/.vim/bundle")

    " Basic improvements
    Plug 'tpope/vim-sensible'
    Plug 'sjl/gundo.vim'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'

    " Tagging plugins.
    Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags' | Plug 'majutsushi/tagbar'

    " Completion plugins.
    Plug 'ervandew/supertab'
    Plug 'mattn/emmet-vim'
    Plug 'Shougo/neocomplete.vim'
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

    " Themes and eye candy.
    Plug 'bling/vim-airline'
    Plug 'bling/vim-bufferline'
    Plug 'AlessandroYorba/Alduin'
    Plug 'nanotech/jellybeans.vim'
    Plug 'noahfrederick/vim-noctu'

    " REPL plugins
    Plug 'jpalardy/vim-slime'
    " Databases, motherfucker.
    Plug 'vim-scripts/dbext.vim'

    " File opening and management plugins
    Plug 'rking/ag.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-projectionist'

    " Movement plugins
    Plug 'godlygeek/tabular'
    Plug 'christoomey/vim-tmux-navigator'

    " Building and compiling plugins
    Plug 'reinh/vim-makegreen'
    Plug 'tpope/vim-dispatch'

    " Compiler settings.
    Plug 'JalaiAmitahl/maven-compiler.vim'
    Plug 'vim-scripts/Scons-compiler-plugin'

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
        colors arccos      " My own personal colorscheme

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
            colors alduin
            if has("gui_gtk2")
                set guifont="Source Code Pro for Powerline 8"
            elseif has("gui_macvim")
                set guifont=Menlo\ Regular:h14
            elseif has("gui_win32")
                set guifont=inconsolata:h12
                colors alduin
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
            
            " Extract to another file
            vnoremap <leader>x  "md:enew<cr>"mp
        
            "Capitalize the word at the cursor.
            inoremap <c-u> <ESC>viwU
            nnoremap <leader>u viwUe

            " Sort the selected lines
            vnoremap <leader>s :!sort

    " Movement

        " Go by graphical lines instead of real ones
        noremap j gj
        noremap k gk

        " Open Special Files

            " Edit my Vimrc, and then load it.
            nnoremap <leader>ev :e $MYVIMRC<cr>
            nnoremap <leader>sv :source $MYVIMRC<cr>

            " Edit snippets files.
            nnoremap <leader>sn     :UltiSnipsEdit<cr>

        " Buffer, Split and Tab Movement

            " Buffers
            nnoremap <right>    :bn<cr>
            nnoremap <left>     :bp<cr>
            nnoremap <up>       :bfirst<cr>
            nnoremap <down>     :blast<cr>
            
            " Splits
            noremap <c-j> <c-w>j
            noremap <c-k> <c-w>k
            noremap <c-l> <c-w>l
            noremap <c-h> <c-w>h
            nnoremap <leader>W  <c-w>w
            nnoremap <leader>=  <c-w>=
            nnoremap <leader>o  :res <cr> :vertical res <cr>
            
            " Tabs
            nnoremap <home> :tabnext<cr>
            nnoremap <end>  :tabprev<cr>

            " Open Special Buffers
                
                " Netrw bindings
                nnoremap <leader>f  :Explore<cr>
                nnoremap <leader>F  :Se.<cr>
                nnoremap <leader>s  :Sex<cr>
                nnoremap <leader>v  :Vex<cr>
                
                " Open message window
                nnoremap <leader>M  :copen<cr>
                
                " Open a Tagbar window
                nnoremap <leader>t  :TagbarToggle<cr>

    " External Tools

        " Run Make
        nnoremap <leader>b   :MakeGreen<cr>
        nnoremap <leader>B   :Dispatch<cr>
        nnoremap <leader>br  :MakeGreen("rebuild") <cr>
        nnoremap <leader>be  :MakeGreen("run") <cr>

        " Git bindings
        nnoremap <leader>gw  :Gwrite<cr>
        nnoremap <leader>gc  :Gcommit<cr>
        nnoremap <leader>gs  :Gstatus<cr>
        nnoremap <leader>gd  :Gvdiff<cr>

    " Plugin settings.
        " Airline
        let g:airline_theme='dark'

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

        " MakeGreen
        let g:makegreen_command = "Dispatch"
        
        " Neocomplete 
        let g:neocomplete#enable_at_startup = 1

        " Netrw
        let g:netrw_banner=0

        " Projectionist
        "
        " Silver Searcher
        "
        " Slime
        let g:slime_target = "tmux"

        " Snippets
        " SuperTab
        " Surround
        " Tabular
        :AddTabularPipeline multiple_spaces / \{2,}/
            \ map(a:lines, "substitute(v:val, ' \{2,}', '  ', 'g')")
            \   | tabular#TabularizeStrings(a:lines, '  ', 'l0')
        " Tagbar
        " Ultisnips
        let g:UltiSnipsExpandTrigger       = "<tab>"
        let g:UltiSnipsJumpForwardTrigger  = "<tab>"
        let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
        " Vim-Tmux Navigator

" Auto commands.

    " Every file
    augroup all_group 
        au! 
        " au vimenter,bufnewfile,bufreadpost * silent! call HardMode()
        au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
    augroup end 
     
    "Eclipse compatible files 
    augroup eclim_group 
        au!
        au FileType python,java,c,c++ nnoremap <localleader>F :ProjectTree<cr>
    augroup end 
    
    " Python files
    augroup python_group 
        " this one is which you're most likely to use?
        au!
        au FileType python set omnifunc=pythoncomplete#Complete
        au FileType python compiler nose
    augroup end 

    augroup c_group
        " this one is which you're most likely to use?
    augroup end

    " C++ files
    augroup cpp_group 
        au!
        au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
    augroup end 

    " Java files
    augroup java_group 
        au!
        au filetype java nnoremap <localleader>i :JavaImport<cr>
    augroup end 
    
    " VimL Files
    augroup vim_group 
        au!
       "au filetype vim set fdm=marker
       "au BufWrite $MYVIMRC source $MYVIMRC
        au filetype vim nnoremap <localleader>b :source %<cr>
    augroup end 

    " Markdown formatted files
    augroup markdown_group 
        au!
        au filetype markdown set keymap=mathematic
    augroup end 

    " PHP files
    augroup php_group 
        au!
    augroup end 



