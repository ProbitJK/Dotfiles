syntax on
set mouse=a
set laststatus=2
hi clear SignColumn
set termguicolors
set guioptions-=T
set guioptions-=r
set guioptions-=L
set number
set tabstop=4
set softtabstop=4
set clipboard=unnamedplus
set ttyfast
set cursorline
set shiftwidth=4
set expandtab
set smartindent
set nohlsearch
set noerrorbells
set incsearch
set scrolloff=12


call plug#begin('~/.vim/plugged')
"vimtex
Plug 'lervag/vimtex'
"Vim-vsnip
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
"snippet repository
Plug 'rafamadriz/friendly-snippets'
"nerdtree
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
"lightline
Plug 'itchyny/lightline.vim'
"Syntax checker
Plug 'vim-syntastic/syntastic'
"ayu-theme
Plug 'ayu-theme/ayu-vim'
"Catppuccin theme
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
"Git integration using vim-fugitive
Plug 'tpope/vim-fugitive'
"code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


"vimtex settings
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:vimtex_enabled=1
set conceallevel=1
let g:tex_conceal='abdmg'
set encoding=utf8
let g:vimtex_fold_enabled =1
let g:vimtex_mappings_enabled=1

"lightline settings
let g:lightline = {'colorscheme': 'deus',} 
let g:lightline.separator = { 'left': "\ue0b0", 'right': "\ue0b2" }
let g:lightline.subseparator = { 'left': "\ue0b1", 'right': "\ue0b3" }

"vim-vsnip settings
" NOTE: You can use other key to expand snippet.
" Expand
imap <expr> <Tab>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<Tab>'
smap <expr> <Tab>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<Tab>'

" Expand or jump
imap <expr> <S-Tab>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<S-Tab>'
smap <expr> <S-Tab>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<S-Tab>'

" Jump forward or backward
imap <expr> <C-j>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<C-j>'
smap <expr> <C-j>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<C-j>'
imap <expr> <C-l> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-l>'
smap <expr> <C-l> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-l>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)
" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']
let g:vsnip_snippet_dir = '/home/probit/.vsnip/'

" ----- scrooloose/syntastic settings -----
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "active"
  au FileType python let b:syntastic_mode = "passive"
augroup END

"syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_tex_checkers = ['chktex', 'lacheck', 'proselint']

"ayu theme
"let ayucolor="dark"
"colorscheme ayu
"Catppuccin theme
colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

" Open/close NERDTree Tabs with \t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
" To have NERDTree always open on startup
let g:nerdtree_tabs_open_on_console_startup = 1

"coc.nvim settings
let g:coc_global_extensions = ['coc-cmake', 'coc-calc', 'coc-clangd', 'coc-markdownlint', 'coc-pyright', 'coc-texlab']
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
