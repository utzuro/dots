 filetype plugin indent on

 set rtp+=~/.vim/bundle/Vundle.vim
 call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'

" SETTINGS
    Plugin 'tpope/vim-sensible'
    Plugin 'tpope/vim-characterize'
    Plugin 'tpope/vim-repeat'
    Plugin 'tpope/vim-obsession'
    Plugin 'tpope/vim-vinegar'
    Plugin 'tpope/vim-apathy'
    Plugin 'tpope/vim-haystack' " replaces completion algorithm
    Plugin 'hedrok/vim-plugin-ruscmd'
    Plugin 'michaeljsmith/vim-indent-object'
    Plugin 'djoshea/vim-autoread'
    Plugin 'machakann/vim-highlightedyank'
    Plugin 'haya14busa/is.vim'
    Plugin 'christoomey/vim-tmux-navigator'
    Plugin 'vim-scripts/AutoComplPop'

" TOOLS
    Plugin 'KabbAmine/lazyList.vim'
    Plugin 'preservim/nerdtree' " :NERDTree
    Plugin 'will133/vim-dirdiff'
    Plugin 'tpope/vim-fugitive' " :G
    Plugin 'glts/vim-radical' " gA on number
    Plugin 'glts/vim-magnum' " ↑ req by vim-radical
    Plugin 'tpope/vim-tbone' " :Tmux, :Tyank, :Tput
    Plugin 'tpope/vim-speeddating' " <C-a> <C-x> on dates
    Plugin 'nvim-telescope/telescope.nvim'
    Plugin 'nvim-telescope/telescope-media-files.nvim'
    Plugin 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }


" EDITING
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-abolish'
    Plugin 'vim-scripts/ReplaceWithRegister'  " grr
    Plugin 'tommcdo/vim-exchange'

" WRITING
    Plugin 'dbakker/vim-paragraph-motion'
    Plugin 'https://gitlab.com/hedrok/langtool-adoc-vim.git'
    Plugin 'junegunn/vim-peekaboo'
  
" IDE
    Plugin 'dense-analysis/ale'
    Plugin 'sheerun/vim-polyglot'
    Plugin 'tpope/vim-unimpaired'
    Plugin 'tpope/vim-commentary'
    Plugin 'tpope/vim-dadbod'
    Plugin 'tpope/vim-dotenv' " :Dotenv {file} to load .env
    Plugin 'tpope/vim-jdaddy' " json mappings: aj, gqaj, gwaj

" complition
    Plugin 'github/copilot.vim'  
    Plugin 'honza/vim-snippets'
    Plugin 'SirVer/ultisnips'
    Plugin 'tpope/vim-endwise'

" folding
    Plugin 'Konfekt/FastFold'

" navigation
    Plugin 'justinmk/vim-sneak'
    Plugin 'easymotion/vim-easymotion'

    Plugin 'mhinz/vim-signify'

    " Server
    Plugin 'fatih/vim-go'
    Plugin 'rust-lang/rust.vim'
    Plugin 'vim-python/python-syntax'
    Plugin 'nvie/vim-flake8' " :PyFlake8

    " Frontend
    Plugin 'mattn/emmet-vim'
    Plugin 'pangloss/vim-javascript'
    Plugin 'othree/html5.vim'
    Plugin 'chrisbra/csv.vim'
    Plugin 'cakebaker/scss-syntax.vim'

    " Config scripts support
    Plugin 'elkowar/yuck.vim'
    Plugin 'mboughaba/i3config.vim'
    Plugin 'chr4/nginx.vim'
    Plugin 'lifepillar/pgsql.vim'
    Plugin 'ekalinin/dockerfile.vim'
    Plugin 'jvirtanen/vim-hcl'
    Plugin 'stephpy/vim-yaml'
    Plugin 'tmux-plugins/vim-tmux'
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

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

if has('macunix')
    let g:python3_host_prog = '/opt/homebrew/bin/python3'
endif


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
