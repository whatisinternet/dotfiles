" Some areas of these dotfiles are clones from the thoughtbot dotifles https://github.com/thoughtbot/dotfiles used under MIT. See https://github.com/thoughtbot/dotfiles/blob/master/LICENSE
syntax on
set ttyfast         " Smooth
if &t_Co < 256
    " colorscheme for the 8 color linux term
    colorscheme vim
else
  set background=dark
  if has('nvim')
    set termguicolors
    colorscheme solarized-osaka
  else
    set colorscheme=solarized
    set termguicolors=true
  endif
endif
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
set number " Always keep zero on your cursor
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
set laststatus=1 "always show the statusline
set regexpengine=1
set re=1
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

" Copy filepath to clipboard
nmap <leader>cfn :call system("pbcopy", expand("%:p"))<CR>
nmap <leader>cfwn :call system("pbcopy", expand("%:p") . ':' . line('.'))<CR>


autocmd! FileWritePre * :call TrimWhiteSpace()
autocmd! FileAppendPre * :call TrimWhiteSpace()
autocmd! FilterWritePre * :call TrimWhiteSpace()
autocmd! BufWritePre * :call TrimWhiteSpace()
" nnoremap K :Ag "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap K :Ag <C-R>=expand("<cword>")<CR><CR>

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>
" inoremap <Tab> <c-p>
" inoremap <S-Tab> <c-n>

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"


" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>
" Highlight searches, but clear highlight on //.
nmap // :noh<CR>

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
" nnoremap <Leader>s :TestNearest<CR>
" nnoremap <Leader>t :TestFile<CR>
" nnoremap <Leader>l :TestLast<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>

" Create new tab
nnoremap <Leader>tc :tabnew<CR>
nnoremap <Leader>1 1gt<CR>
nnoremap <Leader>2 2gt<CR>
nnoremap <Leader>3 3gt<CR>
nnoremap <Leader>4 4gt<CR>

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

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" ALE
let g:ale_set_balloons = 1
" let g:ale_ruby_rubocop_options = '-f --display-cop-names --rails'
" let g:ale_completion_enabled = 1
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_virtualenv_dir_names = []
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'typescript': ['tslint', 'eslint'],
\   'ruby': ['rubocop'],
\   'markdown': ['prettier'],
\   'graphql': ['prettier'],
\   'yaml': ['prettier'],
\   'yml': ['prettier'],
\}


" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Trigger a highlight only when pressing f and F.
let g:qs_highlight_on_keys =  ['f', 'F']
let g:qs_first_occurrence_highlight_color = '#afff5f' " gui vim
let g:qs_first_occurrence_highlight_color = 155       " terminal vim

let g:qs_second_occurrence_highlight_color = '#5fffff'  " gui vim
let g:qs_second_occurrence_highlight_color = 81         " terminal vim
let g:pymode_folding = 0

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ }
      \}
filetype plugin indent on


" ==================================================================

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
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


autocmd BufNewFile,BufRead *.es6 set filetype=javascript

command! -bang -nargs=* FILES
  \ call fzf#vim#files(<q-args>)

command! -bang -nargs=* RGFILES
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --no-ignore --hidden'.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Use FZF for ctrlp ctrl-p ag
" nnoremap <c-p> :FILES<cr>
nmap <C-L> :RGFILES<CR>
let g:fzf_layout = { 'down': '~15%' }
" nnoremap <c-p> :Files<cr>
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg="rg --column --line-number --no-heading --color=always --smart-case --no-ignore --hidden"

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

let g:EditorConfig_exclude_patterns = ['fugitive://.*']

noremap <c-p> :Files<cr>
let g:fzf_layout = { 'down': '~15%' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
let g:fzf_history_dir = '~/.local/share/fzf-history'

inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
set grepprg=rg\ --vimgrep

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --no-ignore --hidden'.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-p>"
    endif
endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>

set hidden


nnoremap <silent> ho :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>


set laststatus=2 "always show the statusline
" Stop messing with shift K... Or you know whatever!
let g:go_doc_keywordprg_enabled = 0

let g:javascript_plugin_flow = 1
let g:flow#enable = 0

autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
