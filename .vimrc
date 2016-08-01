" Started my v1 with https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/
" Customized afterwards

set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'tmhedberg/SimpylFold' " Python folding
Plugin 'vim-scripts/indentpython.vim' " Python indentation
Plugin 'scrooloose/syntastic' " Syntax Highlighting for Python
Plugin 'nvie/vim-flake8' " PEP8 checking
Plugin 'jnurmine/Zenburn' " Color scheme - terminal
Plugin 'altercation/vim-colors-solarized' " Color scheme - with UI 
Plugin 'scrooloose/nerdtree' " If you want a proper file tree... 
Plugin 'jistr/vim-nerdtree-tabs' " ...together with the use of tabs 

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Various common options
set encoding=utf-8

" Windows layout
set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za
" Want to see the docstrings for folded code?
let g:SimpylFold_docstring_preview=1

" Indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2
" Warn me if there's extra blanks
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" Color scheme
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif
call togglebg#map("<F5>") " To swap between dark and light theme quickly

" Syntax highlighting
let python_highlight_all=1
set nocompatible
syntax on

" Tree configuration
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore these files in NERDTree

autocmd vimenter * NERDTree " How can I open a NERDTree automatically when vim starts up?
autocmd StdinReadPre * let s:std_in=1 " How can I open a NERDTree automatically when vim starts up if no files were specified?, p1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif " How can I open a NERDTree automatically when vim starts up if no files were specified?, p2
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " How can I close vim if the only window left open is a NERDTree?
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸' " prettier arrows
let g:NERDTreeDirArrowCollapsible = '▾' 
