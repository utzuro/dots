 filetype plugin indent on

 set rtp+=~/.vim/bundle/Vundle.vim
 call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'

" lua
    Plugin 'nvim-lua/popup.nvim'
    Plugin 'nvim-lua/plenary.nvim'
    Plugin 'nvim-telescope/telescope.nvim'
    Plugin 'nvim-telescope/telescope-media-files.nvim'
" WRITING
    Plugin 'hedrok/vim-plugin-ruscmd'
    Plugin 'https://gitlab.com/hedrok/langtool-adoc-vim.git'
    Plugin 'rhysd/vim-grammarous'
    Plugin 'ron89/thesaurus_query.vim'
    Plugin 'Konfekt/FastFold'
    Plugin 'junegunn/limelight.vim'
    Plugin 'junegunn/vim-peekaboo'
    Plugin 'junegunn/goyo.vim'
    " Plugin 'inkarkat/vim-ingo-library' | Plugin 'inkarkat/vim-SpellCheck'
" IDE
   " Plugin 'github/copilot.vim'  
    Plugin 'vim-scripts/ReplaceWithRegister'  
    Plugin 'sheerun/vim-polyglot'
    Plugin 'tommcdo/vim-exchange'
    Plugin 'tpope/vim-surround'
    Plugin 'preservim/nerdtree'
    Plugin 'tpope/vim-endwise'
    Plugin 'tpope/vim-commentary'
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-obsession'
    Plugin 'tpope/vim-repeat'
    Plugin 'tpope/vim-speeddating'
    Plugin 'tpope/vim-vinegar'
    Plugin 'vim-scripts/argtextobj.vim'
    Plugin 'mattn/emmet-vim'
    Plugin 'vim-syntastic/syntastic'
    Plugin 'dbakker/vim-paragraph-motion'
    Plugin 'michaeljsmith/vim-indent-object'
    Plugin 'nvie/vim-flake8'
    Plugin 'honza/vim-snippets'
    Plugin 'tobyS/vmustache'
    Plugin 'djoshea/vim-autoread'
    Plugin 'easymotion/vim-easymotion'
    Plugin 'will133/vim-dirdiff'
    Plugin 'machakann/vim-highlightedyank'
    Plugin 'haya14busa/is.vim'
    Plugin 'tpope/vim-sleuth'
    Plugin 'tpope/vim-unimpaired'
    Plugin 'christoomey/vim-tmux-navigator'
    Plugin 'KabbAmine/lazyList.vim'
    "Plugin 'mhinz/vim-signify'
    "Plugin 'SirVer/ultisnips' | Plugin 'honza/vim-snippets'
    Plugin 'vim-scripts/AutoComplPop'

    " Tools
    Plugin 'tpope/vim-git'

    " Programming languages support
    " Server
    Plugin 'fatih/vim-go'
    Plugin 'vim-python/python-syntax'
    Plugin 'rust-lang/rust.vim'
    " Frontend
    Plugin 'pangloss/vim-javascript'
    Plugin 'othree/html5.vim'
    Plugin 'chrisbra/csv.vim'
    Plugin 'cakebaker/scss-syntax.vim'

    " Config scripts support
    Plugin 'elkowar/yuck.vim'
    Plugin 'PotatoesMaster/i3-vim-syntax'
    Plugin 'chr4/nginx.vim'
    Plugin 'lifepillar/pgsql.vim'
    Plugin 'ekalinin/dockerfile.vim'
    Plugin 'elixir-editors/vim-elixir'
    Plugin 'Glench/Vim-Jinja2-Syntax'
    Plugin 'godlygeek/tabular' | Plugin 'tpope/vim-markdown'
    Plugin 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
    Plugin 'jvirtanen/vim-hcl'
    Plugin 'stephpy/vim-yaml'
    Plugin 'tmux-plugins/vim-tmux'
    Plugin 'tpope/vim-liquid'
    Plugin 'wgwoods/vim-systemd-syntax'
    Plugin 'towolf/vim-helm'

"Visual
    Plugin 'dracula/vim'
    Plugin 'ryanoasis/vim-devicons'
    
call vundle#end()            " required

" Lazy List configs
nnoremap gli :LazyList
vnoremap gli :LazyList
let g:lazylist_omap = 'il'
let g:lazylist_maps = [
            \ 'gl',
            \ {
                \ 'l' : '',
                \ '*' : '* ',
                \ '-' : '- ',
                \ 't' : '- [ ] ',
            \ }
    \ ]

" Latex
let g:livepreview_previewer = 'zathura'
