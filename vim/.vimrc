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
    Plug 'tpope/vim-sensible'
    Plug 'sjl/gundo.vim'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'Shougo/unite.vim'
    Plug 'jacquesbh/vim-showmarks'

    " Tagging plugins.
    Plug 'Shougo/unite.vim' | Plug 'Shougo/neoinclude.vim' | Plug 'tsukkee/unite-tag'
    Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags' | Plug 'majutsushi/tagbar'

    " Completion plugins.
    Plug 'ervandew/supertab'
    Plug 'mattn/emmet-vim'
    if NVIM()
        Plug 'Shougo/deoplete.nvim'
    else 
        Plug 'Shougo/neocomplete.vim'
    endif
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

    " Eye Candy
    Plug 'itchyny/lightline.vim'
    Plug 'bling/vim-bufferline'
    Plug 'kien/rainbow_parentheses.vim'

    " Themes
    Plug 'laserswald/chameleon.vim'
    Plug 'AlessandroYorba/Alduin'
    Plug 'nanotech/jellybeans.vim'
    Plug 'noahfrederick/vim-noctu'

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

    " Filetype specific plugins
        " Markdown
        Plug 'nelstrom/vim-markdown-folding'

        " Todo.txt
        Plug 'freitass/todo.txt-vim'

        " C
        Plug 'vim-scripts/cscope.vim'
        
        " PHP
        Plug 'StanAngeloff/php.vim', {'for' : 'php'}
        Plug 'wdalmut/vim-phpunit', {'for' : 'php'}
        Plug 'shawncplus/phpcomplete.vim', {'for' : 'php'}
        Plug 'rayburgemeestre/phpfolding.vim', {'for' : 'php'}

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
            colors jellybeans
            if has("gui_gtk2")
                set guifont="Source Code Pro for Powerline 8"
            elseif has("gui_macvim")
                set guifont=Menlo\ Regular:h14
            elseif has("gui_win32")
                set guifont=inconsolata:h12
                colors jellybeans
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

            " Sort the selected lines
            vnoremap <leader>s :!sort<cr>

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

            " Edit the current projection file
            nnoremap <leader>p :

            function! GetFiletypeFile()
                return g:vimdir . '/filetype/' . &filetype . '.vim'
            endfunction

            nnoremap <leader>eft :execute "e " . GetFiletypeFile()<cr>

        " Buffer, Split and Tab Movement

            " Buffers
            nnoremap <right>    :bn<cr>
            nnoremap <left>     :bp<cr>
            nnoremap <up>       :bfirst<cr>
            nnoremap <down>     :blast<cr>
            
            " Open Special Buffers
            
                " Netrw bindings
                nnoremap <leader>F  :Se.<cr>
                nnoremap <leader>s  :Sex<cr>
                nnoremap <leader>v  :Vex<cr>
                
                " Open error window
                nnoremap <leader>m  :cw<cr>
                
                " Open a tag in the current buffer
                nnoremap <leader>t  :Unite tag/include -start-insert<cr>
                nnoremap <leader>tb :Unite tag/include -vertical -directio<cr>
               
                " Fuzzy find a file.
                nnoremap <leader>f  :Unite file_rec/neovim -start-insert<cr>

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

    " C# files
    augroup cs_group
        " this one is which you're most likely to use?
        au FileType cs setlocal omnifunc=OmniSharp#Complete

        au cursorhold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
        au bufwritepost *.cs call OmniSharp#AddToProject()
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
    function! Markdown_makeHeader(number)
        if a:number ==# 1
            normal! yypVr=
        else if a:number ==# 2
            normal! yypVr-
        else 
            execute "normal!" . a:number . "I#"
        endif
    endfunction

    augroup markdown_group 
        au!
        " TODO: look for ways to make this into a function
        au filetype markdown vnoremap <localleader>l :normal! I- <cr>
        au filetype markdown vnoremap <localleader>n :normal! I1. <cr>
        au filetype markdown nnoremap <localleader>> :normal! I# <cr>
        au filetype markdown nmap <localleader>b :normal! yss* <cr>
    augroup end 

    augroup php_group
        " this one is which you're most likely to use?
        autocmd!
        autocmd filetype php setlocal noexpandtab 

    augroup end


