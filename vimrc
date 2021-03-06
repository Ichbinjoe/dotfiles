
set nocompatible              " be iMproved, required
filetype off                  " required

if has("nvim")
    let vimdir = $HOME . "/.config/nvim"
else
    let vimdir = $HOME . "/.vim"
endif

" Plugins
let pluginsVim = vimdir . '/plugins.vim'
exec "source " . pluginsVim 


" Syntax highlights, colorscheme
syntax on

" Only use colorscheme if it exists!
if isdirectory(vimdir . '/bundle/jellybeans.vim')
    colorscheme jellybeans
    "colorscheme sol-term
else
    colorscheme default
endif

" Line numbering
set number

" Column highlighting
set colorcolumn=80
highlight ColorColumn ctermbg=235 guibg=Grey

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" airline
let g:airline_theme='jellybeans'
let g:airline_powerline_fonts=1

" Always show status bar
set laststatus=2

" Folding
set foldmethod=syntax
set foldlevelstart=20

" Enable filetype detection
filetype plugin indent on

" Always use spaces, 4 space tabstop
set tabstop=4
set shiftwidth=4
set expandtab

" Undo/backup
set undofile
set undodir=~/.undo/
set undoreload=100
set backup
set backupdir=~/.backup/

" Disable mouse
set mouse=

" Set language
autocmd BufRead,BufNewFile *.md,*.tex,*.txt setlocal spell
set spelllang=en_us

" Autowrap md, tex, and txt
autocmd BufRead,BufNewFile *.md,*.tex,*.txt setlocal textwidth=80 wrap

" Prev. buffer mapped to Ctrl-H
nnoremap <silent> <C-h> :tabprevious<CR>
" Next buffer mapped to Ctrl-L
nnoremap <silent> <C-l> :tabnext<CR>
" New buffer tab mapped to Ctrl-B
nnoremap <silent> <C-b> :tabnew<CR>

" NERDTree mapped to Ctrl-N
nnoremap <silent> <C-n> :NERDTree<CR>

" Toggle fold mapped to spacebar
nnoremap <Space> za

if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    set fileencodings=ucs-bom,utf-8,latin1
endif

" vim: set ft=vim:
