" Lightline
let g:lightline = { 
            \ 'colorscheme': 'chameleon',
            \ 'active' : {
            \    'left': [
            \        ['mode', 'paste'], 
            \        ['fugitive', 'readonly', 'filename', 'modified'],
            \        ['buffers']
            \    ]
            \ },
            \ 'component_function' : {
            \   'fugitive': "LightlineFugitive",
            \   'buffers': "LightlineBufferlineUnfocused"
            \ }
            \ }

function! LightlineFugitive()
    return exists('*fugitive#head') ? fugitive#head()  : '' 
endfunction

function! LightlineBufferlineUnfocused()
    if exists('*bufferline#get_status_string')
        let st=g:bufferline#refresh_status()
        return g:bufferline_status_info.before . g:bufferline_status_info.after
    else
        return ''
    endif
endfunction
