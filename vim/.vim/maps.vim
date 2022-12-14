" Prevent x from overriding what's in the clipboard.
noremap x "_x
noremap X "_x

" Prevent selecting and pasting from overwriting what you originally copied.
xnoremap p pgvy

" Keep cursor at the bottom of the visual selection after you yank it.
vmap y ygv<Esc>

" Navigate around splits with a single key combo. <-- REPLACED WITH PLUGIN
" nnoremap <C-l> <C-w><C-l>
" nnoremap <C-h> <C-w><C-h>
" nnoremap <C-k> <C-w><C-k>
" nnoremap <C-j> <C-w><C-j>

" NERDTREE
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" LEADER
let mapleader = ','
map <Leader> <Plug>(easymotion-prefix)
map <leader>f <Plug>(easymotion-s)
map <leader>e <Plug>(easymotion-f)
map Q gq

" WRITING
set display=lastline
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u
inoremap : :<C-g>u

