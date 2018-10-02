set nocompatible
filetype off
execute pathogen#infect()

filetype indent plugin on
syntax on

" show line numbers
" set nu
" https://jeffkreeftmeijer.com/vim-number/
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" do not wrap long lines
set nowrap

if has("gui_running")
  if has("gui_gtk2")
    "set guifont=Inconsolata\ 12
    set guifont=Inconsolata\-g\ For\ Powerline:h12
  elseif has("gui_macvim")
    set guifont=Inconsolata\-g\ For\ Powerline:h12
  elseif has("gui_win32")
    "set guifont=Consolas:h11:cANSI
    set guifont=Source_Code_Pro:h11:cANSI
  endif
endif

set expandtab
set autoindent
set cursorcolumn
set cursorline

set tabstop=4
set shiftwidth=4
set softtabstop=4

" textwidth = 79
set tw=79

" Solarized Theme
set bg=dark

colorscheme solarized

autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType html,xml,xsl runtime scripts\closetag.vim

" Nerdtree Stuff
let NERDTreeIgnore = ['\.pyc$','\.zip', '\.egg-info.*']

" Make .dust files be treated as .html
"au BufReadPost *.dust set syntax=html
"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsUsePythonVersion=2
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']


" vim-closetag options
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml,*.tpl""

au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
au FileType html setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" set backupdir=$HOME/.vimbackup,$HOME/.vimtmp
" set directory=$HOME/.vimbackup,$HOME/.vimtmp

vmap <C-c> :w !pbcopy<CR><CR>

" Moving lines
" In your ~/.vimrc
"
" Normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

" Insert mode
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi

" Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" End - Moving Lines

" Status line stuff
set encoding=utf-8
scriptencoding utf-8
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'component': {
      \   'readonly': '%{&readonly?"⭤":""}',
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

if has("python3")
    command! -nargs=1 Py py3 <args>
else
    command! -nargs=1 Py py <args>
endif
" python with virtualenv support

Py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF


autocmd BufWritePost *.py call Flake8()

" vim-markdown-preview stuff
" https://github.com/JamshedVesuna/vim-markdown-preview
"
" delete temporary files
let vim_markdown_preview_temp_file=1
" Use chrome for rendering - Safari doesn't seem to work
let vim_markdown_preview_browser='Google Chrome'


" fzf stuff
" If installed using Homebrew
set rtp+=/usr/local/bin/fzf


" value(s) needed by UltiSnips
let g:snips_author = "Kevin Hansen"
if has('python')
    let g:UltiSnipsUsePythonVersion = 2
else
    let g:UltiSnipsUsePythonVersion = 3
endif
