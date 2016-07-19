" Lightline
let g:lightline = { 
            \ 'colorscheme': 'chameleon',
            \ 'active' : {
            \    'left': [
            \        ['mode', 'paste'], 
            \        ['readonly', 'filename', 'modified'],
            \        ['buffers']
            \    ]
            \ },
            \ 'component' : {
            \ },
            \ 'component_function' : {
            \   'fugitive': 'LightlineFugitive',
            \   'buffers': "LightlineBufferline",
            \ }
            \ }

function! LightlineFugitive()
    return exists('*fugitive#head') ? fugitive#head()  : '' 
endfunction


function! LightlineBufferline()
    if !exists('*fugitive#head') 
        return ''
    endif
    call bufferline#refresh_status()
    return g:bufferline_status_info.before .'|'. g:bufferline_status_info.after 
endfunction
