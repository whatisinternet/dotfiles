syntax on
set ttyfast         " Smooth
set background=dark "Default to dark -- don't worry it'll switch with auto-solarize-vim
let mapleader = "," "<space> is equally valid
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup      " Remove the useless ~backup file
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=5000  " Make history huge
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set so=25
set hlsearch      " Highlight searches
set virtualedit=all " Move the cursor all over the screen
set relativenumber  " Always keep zero on your cursor
set lazyredraw
set magic           " Searching and matching make use of /\
set showmatch       " Make a quick jump back and highlight on brackets
set mat=2
set cursorline      " Keep a background lighter on the current cursor
set smartcase       " Searching fixes see :h smartcase
set smarttab        " Tab in correctly.
setlocal spell
setlocal spell spelllang=en_ca
set ttimeoutlen=50 " Make typing faster
set pastetoggle=<F11> " Use <F11> to toggle between 'paste' and 'nopaste'
set laststatus=1 "always show the statusline
"
" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
"
" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1
"
" Numbers
" set number
set numberwidth=5
"
" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·
"
" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
"
" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add
"
" Autocomplete with dictionary words when spell check is on
set complete+=kspell
"
" Always use vertical diffs
set diffopt+=vertical

autocmd! FileWritePre * :call TrimWhiteSpace()
autocmd! FileAppendPre * :call TrimWhiteSpace()
autocmd! FilterWritePre * :call TrimWhiteSpace()
autocmd! BufWritePre * :call TrimWhiteSpace()
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

imap jj <Esc> " You dont need to use esc to esc. just jj

nnoremap <silent><leader>n :set relativenumber!<cr>
" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" vim-rspec mappings
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"NerdTree
nnoremap <silent> <Leader>d :let NERDTreeQuitOnOpen = 1<bar>NERDTreeToggle<CR>
nnoremap <silent> <Leader>D :let NERDTreeQuitOnOpen = 0<bar>NERDTreeToggle<CR>

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

set rtp+=/usr/lib/python2.7/site-packages/powerline/bindings/vim/
let g:Powerline_symbols = 'fancy'
let g:Powerline_theme='wombat'
let g:Powerline_colorscheme='wombat'

filetype plugin indent on


" ==================================================================

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif


" Remove trailing whitespace when a file is saved
" Source: <http://vim.wikia.com/wiki/Remove_unwanted_spaces>
function! TrimWhiteSpace()
  " Do not record the whitespace removal in the undo history
  " Source: <http://vim.1045645.n5.nabble.com/there-s-undojoin-how-about-dotjoin-td1203135.html>
  try
    undojoin
  catch
    " Probably an undo was just issued, and so there's no way to join the undo.
    " Which sucks.
  endtry
  %s/\s*$//
  ''
endfunction

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
  autocmd FileType litcoffee runtime ftplugin/coffee.vim
augroup END



" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

set laststatus=2 "always show the statusline

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
