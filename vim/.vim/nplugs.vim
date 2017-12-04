" Completion engine
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
" Plug 'lvht/phpcd.vim', {'for': 'php', 'do': 'composer install'}

" REPL support
Plug 'hkupty/iron.nvim', {'do': ':UpdateRemotePlugins'}

" Asynchronous builds and linting
Plug 'neomake/neomake', {'do': ':UpdateRemotePlugins'}

" tag files
Plug 'fntlnz/atags.vim', {'do': ':UpdateRemotePlugins'}

" Global search
Plug 'Shougo/denite.nvim', {'do': ':UpdateRemotePlugins'}

" Neovim exclusive
Plug 'floobits/floobits-neovim'
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>
