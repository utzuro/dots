" GENERAL
  set shellslash
  set completeopt=noinsert,menuone,noselect
  set mouse=a
  set ttyfast
  set t_Co=256
  set tabstop=4
  set shiftwidth=4
  set nocompatible
  set encoding=utf8
  set autoread
  set autowrite
  set lazyredraw
  set magic
  set hidden
  set wildmenu
  set wildignore+=**/node_modules/**
  set path+=**
  set ignorecase
  set smartcase
  set infercase
  set incsearch
  set undofile
  set undodir=~/.vim/undodir
  set regexpengine=1
  filetype on
  filetype plugin on
  filetype indent on

" IDE
  set number
  set relativenumber
  set laststatus=1
  set matchpairs& matchpairs+=<:>
  set showmatch
  set matchtime=3
  set shiftround
  set belloff=all
  set complete+=kspell
  set completeopt=menuone,longest
  set shortmess+=c
  set fileformat=unix

" VISUAL
  syntax enable
  syntax on
  set showcmd
  set ruler
  set scrolloff=4
  set smartindent
  set autoindent
  set smarttab
  set hlsearch
  set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P 

" FOLDING
  hi Folded ctermfg=5
  hi Folded ctermbg=black
  hi FoldColumn ctermfg=5
  hi FoldColumn ctermbg=black

" Enable 24-bit true colors if your terminal supports it.
  if (has("termguicolors"))
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
  endif
