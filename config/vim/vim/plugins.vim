 filetype plugin indent on

" Instal vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

 call plug#begin()

" SETTINGS
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-haystack' " replaces completion algorithm
Plug 'hedrok/vim-plugin-ruscmd'
Plug 'michaeljsmith/vim-indent-object'
Plug 'djoshea/vim-autoread'
Plug 'machakann/vim-highlightedyank'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-scripts/AutoComplPop'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'dbakker/vim-paragraph-motion'
Plug 'junegunn/vim-peekaboo'
Plug 'mhinz/vim-signify'

" TOOLS
Plug 'justinmk/vim-sneak'
Plug 'glts/vim-radical' " gA on number or crb/d/x/o
Plug 'glts/vim-magnum' " ↑ req by vim-radical
Plug 'tpope/vim-speeddating' " <C-a> <C-x> on dates
Plug 'tpope/vim-surround'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive' " :G
Plug 'sindrets/diffview.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'will133/vim-dirdiff'
Plug 'alx741/vinfo'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
Plug 'https://gitlab.com/hedrok/langtool-adoc-vim.git'

" AI
" Plug 'github/copilot.vim'  

" IDE
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'Konfekt/FastFold'
Plug 'tmhedberg/SimpylFold'
Plug 'tpope/vim-endwise'
Plug 'gauteh/vim-cppman'
Plug 'mattn/emmet-vim'
Plug 'habamax/vim-godot'
Plug 'mfussenegger/nvim-dap'
Plug 'leoluz/nvim-dap-go'

Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'npm ci'}
Plug 'sheerun/vim-polyglot'

" syntax
Plug 'fatih/vim-go'
Plug 'thosakwe/vim-flutter'
Plug 'LnL7/vim-nix'
Plug 'othree/html5.vim'
Plug 'elkowar/yuck.vim'
Plug 'mboughaba/i3config.vim'

"Visual
Plug 'dracula/vim'

" required for nvim
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

call plug#end()


let mapleader = ','

so ~/.vim/godot.vim
so ~/.vim/coc.vim
so ~/.vim/telescope.vim
so ~/.vim/dap.vim

" disabel copilot by default
let g:copilot_enabled = v:false

let g:signify_disable_by_default = 1

" Signify
:nnoremap <leader>se :SignifyEnable<cr>
:nnoremap <leader>sd :SignifyDisable<cr>
:nnoremap <leader>ss :SignifyHunkDiff<cr>
:nnoremap <leader>su :SignifyHunkUndo<cr>
:nmap <leader>sn <plug>(signify-next-hunk)
:nmap <leader>sp <plug>(signify-prev-hunk)
