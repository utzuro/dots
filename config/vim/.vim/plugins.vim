 filetype plugin indent on

 set rtp+=~/.vim/bundle/Vundle.vim
 call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'

" SETTINGS
    Plugin 'tpope/vim-sensible'
    Plugin 'tpope/vim-characterize'
    Plugin 'tpope/vim-sleuth'
    Plugin 'tpope/vim-repeat'
    Plugin 'tpope/vim-obsession'
    Plugin 'tpope/vim-vinegar'
    Plugin 'tpope/vim-apathy'
    Plugin 'tpope/vim-haystack' " replaces completion algorithm
    Plugin 'hedrok/vim-plugin-ruscmd'
    Plugin 'michaeljsmith/vim-indent-object'

" TOOLS
    Plugin 'preservim/nerdtree' " :NERDTree
    Plugin 'tpope/vim-fugitive' " :G
    Plugin 'glts/vim-radical' " gA on number
    Plugin 'glts/vim-magnum' " ↑ req by vim-radical
    Plugin 'glts/vim-tbone' " :Tmux, :Tyank, :Tput
    Plugin 'tpope/vim-speeddating' " <C-a> <C-x> on dates
    Plugin 'nvim-telescope/telescope.nvim'
    Plugin 'nvim-telescope/telescope-media-files.nvim'


" EDITING
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-abolish'
    Plugin 'vim-scripts/ReplaceWithRegister'  " grr
    Plugin 'tommcdo/vim-exchange'

" WRITING
    Plugin 'dbakker/vim-paragraph-motion'
    Plugin 'https://gitlab.com/hedrok/langtool-adoc-vim.git'
    Plugin 'rhysd/vim-grammarous'
    Plugin 'ron89/thesaurus_query.vim'
    Plugin 'Konfekt/FastFold'
    Plugin 'junegunn/limelight.vim'
    Plugin 'junegunn/vim-peekaboo'
    Plugin 'junegunn/goyo.vim'
    " Plugin 'inkarkat/vim-ingo-library' | Plugin 'inkarkat/vim-SpellCheck'
  
" IDE
    Plugin 'github/copilot.vim'  
    Plugin 'dense-analysis/ale'
    Plugin 'sheerun/vim-polyglot'
    Plugin 'tpope/vim-endwise'
    Plugin 'tpope/vim-unimpaired'
    Plugin 'tpope/vim-commentary'
    Plugin 'tpope/vim-dadbod'
    Plugin 'tpope/vim-dotenv' " :Dotenv {file} to load .env
    Plugin 'tpope/vim-jdadddy' " json mappings: aj, gqaj, gwaj

    Plugin 'honza/vim-snippets'
    Plugin 'justinmk/vim-sneak'
    Plugin 'tobyS/vmustache'
    Plugin 'djoshea/vim-autoread'
    Plugin 'easymotion/vim-easymotion'
    Plugin 'will133/vim-dirdiff'
    Plugin 'machakann/vim-highlightedyank'
    Plugin 'haya14busa/is.vim'
    Plugin 'christoomey/vim-tmux-navigator'
    Plugin 'KabbAmine/lazyList.vim'
    "Plugin 'mhinz/vim-signify'
    "Plugin 'SirVer/ultisnips' | Plugin 'honza/vim-snippets'
    Plugin 'vim-scripts/AutoComplPop'

    " Server
    Plugin 'fatih/vim-go'
    Plugin 'vim-python/python-syntax'
    Plugin 'rust-lang/rust.vim'
    Plugin 'nvie/vim-flake8' " :PyFlake8

    " Frontend
    Plugin 'mattn/emmet-vim'
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
    Plugin 'godlygeek/tabular'
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
    

" required for nvim
    Plugin 'nvim-lua/popup.nvim'
    Plugin 'nvim-lua/plenary.nvim'

call vundle#end()            " required


" PLUGIN CONFIGS

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
