" Lightline
let g:lightline = { 
            \ 'colorscheme': 'chameleon',
            \ 'active' : {
            \    'left': [
            \        ['mode', 'paste'], 
            \        ['fugitive', 'readonly', 'buffers'],
            \        ['filename', 'modified']
            \    ]
            \ },
            \ 'component' : {
            \   'buffers': "%{bufferline#get_status_string()}",
            \ },
            \ 'component_function' : {
            \   'fugitive': 'LightlineFugitive'
            \ }
            \ }

function! LightlineFugitive()
    return exists('*fugitive#head') ? fugitive#head()  : '' 
endfunction

