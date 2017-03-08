" airline
let g:airline_theme = 'molokai'
let g:airline#extensions#branch = 1
let g:airline_symbols = get(g:, 'airline_symbols', {})

" syntastic
let g:syntastic_enable_signs = 1

" indent guides
" set ts=2 sw=2 et
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 0.5

" syntastic
let g:syntastic_javascript_checkers = ['JSHint']

" NERDTree
"autocmd vimenter * NERDTree
