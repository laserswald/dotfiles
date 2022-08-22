" Completion engine
" Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
" Plug 'lvht/phpcd.vim', {'for': 'php', 'do': 'composer install'}

" REPL support
Plug 'Olical/conjure', {'do': ':UpdateRemotePlugins'}

" Asynchronous builds and linting
Plug 'neomake/neomake', {'do': ':UpdateRemotePlugins'}

" tag files
Plug 'fntlnz/atags.vim', {'do': ':UpdateRemotePlugins'}

" Global search
Plug 'Shougo/denite.nvim', {'do': ':UpdateRemotePlugins'}

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

nnoremap <silent> <BS> :TmuxNavigateLeft<cr>
