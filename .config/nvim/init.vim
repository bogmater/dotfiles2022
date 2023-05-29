syntax on
filetype plugin indent on
set noswapfile
set nu
set hidden
set relativenumber
set undofile
set spell
set title
set ignorecase
set smartcase
set wildmode=longest:full,full
set nowrap
set scrolloff=8
set sidescrolloff=8
set nojoinspaces
set splitright
set clipboard=unnamedplus
set confirm
set exrc
set backup
set backupdir=~/.local/share/nvim/backup//
set updatetime=300
set redrawtime=10000
set nohlsearch

" tab stuff
set expandtab ts=4 sw=4 ai

" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Maintain the cursor position when yanking a visual selection
" http://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap y myy`y
vnoremap Y myY`y

" When text is wrapped, move by terminal rows, not lines, unless a count is provided
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Paste replace visual selection without copying it
vnoremap <leader>p "_dP

" Keep it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Quickly escape to normal mode
imap jj <esc>

" Easy insertion of a trailing ; or , from insert mode
imap ;; <Esc>A;<Esc>
imap ,, <Esc>A,<Esc>

" easier copy/paste
noremap <leader>y "+y
noremap <leader>Y "+Y
noremap <leader>p "+p

" add a $ character to end of a change
set cpoptions+=$

" correct php comments
au Bufenter *.php set comments=sl:/*,mb:*,elx:*/

" easier split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" sexy invisible chars
set list listchars=tab:▸\ ,trail:.,eol:¬

" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugins')

source ~/.config/nvim/plugins/seoul256.vim
source ~/.config/nvim/plugins/zenburn.vim
source ~/.config/nvim/plugins/airline.vim
source ~/.config/nvim/plugins/coc.vim
source ~/.config/nvim/plugins/vim-commentary.vim
source ~/.config/nvim/plugins/nerdtree.vim
source ~/.config/nvim/plugins/delimitmate.vim
source ~/.config/nvim/plugins/vim-fugitive.vim
source ~/.config/nvim/plugins/vim-snippets.vim
source ~/.config/nvim/plugins/vim-signify.vim
source ~/.config/nvim/plugins/vim-surround.vim
source ~/.config/nvim/plugins/vim-abolish.vim
source ~/.config/nvim/plugins/fzf.vim
source ~/.config/nvim/plugins/vim-javascript.vim
source ~/.config/nvim/plugins/typescript-vim.vim
source ~/.config/nvim/plugins/vim-jsx-pretty.vim
source ~/.config/nvim/plugins/vim-graphql.vim
source ~/.config/nvim/plugins/vim-closetag.vim
source ~/.config/nvim/plugins/vim-easy-align.vim
source ~/.config/nvim/plugins/gruvbox.vim
source ~/.config/nvim/plugins/nvim-treesitter.vim
source ~/.config/nvim/plugins/rust-vim.vim
source ~/.config/nvim/plugins/phpcsfixer.vim
source ~/.config/nvim/plugins/svelte.vim

call plug#end()

doautocmd User PlugLoaded

" colorscheme
colorscheme zenburn
set background=light

