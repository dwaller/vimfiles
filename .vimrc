" Of course
set nocompatible

" Make 'Y' yank from the cursor to the end of the line.  As the help file says
" 'which is more logical,  but not Vi-compatible'
:map Y y$

" Required Vundle setup
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'
Plugin 'jparise/vim-graphql'
Plugin 'mileszs/ack.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'majutsushi/tagbar'
Plugin 'rodjek/vim-puppet'
Plugin 'rust-lang/rust.vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'fatih/vim-go'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'
Plugin 'Align'
Plugin 'AndrewRadev/sideways.vim'
Plugin 'l9' " required by something!
" colourschemes
Plugin 'twerth/ir_black'

" All of your Plugins must be added before the following line
call vundle#end()            " required
" Enable filetype detection and filetype specific plugins and indentation
filetype plugin indent on    " required

" Add fzf binary to runtime path
set rtp+=/usr/local/opt/fzf

" Enable the backspace key in insert mode
" See http://vim.wikia.com/wiki/Backspace_and_delete_problems
set backspace=indent,eol,start

" Watch .vimrc for changes and automatically reload config.
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYVIMRC | endif
augroup END

" Syntax higlighting on
syntax on

" Recognise Guardfiles as ruby
au BufNewFile,BufRead Guardfile.* set filetype=ruby
au BufNewFile,BufRead *.md setlocal spell

" Use the vividchalk colourscheme.  Looks much like TextMate on the Mac.
" colorscheme solarized
" colorscheme vividchalk
colorscheme grb256
set background=dark

" Tabs are 2 characters, replace tabs with spaces.
set shiftwidth=2
set expandtab

" Strip trailing whitespace on save - for all file types.
" See http://vim.wikia.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre * :%s/\s\+$//e

" Automatic wrapping of comments at 80 characters
set formatoptions+=c
set textwidth=80

" Allow switching between buffers even if the current buffer has unsaved
" changes
set hidden

" Automatically load changed files.
set autoread

" Autosave.
" autowriteall (see vim help) saves on various motions around buffers.
" Also save whenever leaving vim.
set autowriteall
:au FocusLost * :wa

" Test output from xunit tests
set wildignore=TEST-*.xml

" ag, not ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Remap leader from \ to , which is easier to hit, and a common remapping.
let mapleader = ","

" *** Searching ***
" Ignore case unless there is some uppercase in the string
set ignorecase
set smartcase
" Always match all occurrences on a line.  When do you ever want something else?
set gdefault
" Make searching (using /) incremental (turn this off with "set incsearch!")
set incsearch
" Highlight search results
set showmatch
set hlsearch
" Clear search highlighting
nnoremap <leader><space> :noh<cr>

" Automatically open, but do not go to (if there are errors) the quickfix
" window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow

" Leave insert mode.  Two semicolons are easy to type.
imap ;; <Esc>

" Jump to matching bracket on tab.
nnoremap <tab> %
vnoremap <tab> %

" Training mode
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Shortcuts for Sideways.vim
nnoremap <c-h> :SidewaysLeft<cr>
nnoremap <c-l> :SidewaysRight<cr>
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

" F7 and F8 to move to next/previous buffer
nmap <F7> :bp<CR>
nmap <F8> :bn<CR>
" F2 to save whilst in insert mode (remain in insert mode)
imap <F2> <C-o>:w<CR>
" Ctrl+ up/down to scroll
nmap <C-Down> <C-e>
nmap <C-Up> <C-y>
" Alt+Shift+ up/down to move through grep matches
nmap <M-S-Down> :cn<CR>
nmap <M-S-Up> :cp<CR>
" Alt+Shift+ j/k to move through grep matches when in a strict mood
nmap <M-S-j> :cn<CR>
nmap <M-S-k> :cp<CR>

nmap <leader>b :Buffers<CR>
nmap <C-P> :Files<CR>
" Give FZF a history directory, so that Ctrl+P will repeat the last file search
" (And Ctrl+N the next file search if you go too far back.)
let g:fzf_history_dir = '~/.fzf_history'

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Grep for the word under the cursor.
nmap <leader>g :grep '\b<cword>\b' .<CR>
nnoremap <leader>a :Ack '\b<cword>\b' .<CR>

" Useful defaults for grepping a Rails app.
set grepprg=grep\ -InR\ --include=*.erb\ --include=*.rb\ --include=*.rake\ $*

" vim-gitgutter - set background colour to the same as the line number column.
highlight clear SignColumn

if has('statusline')
  " Set a statusline - but don't attempt to run this when launching vim in vi
  " mode on Linux (by typing 'vi <file>').
  hi User1 guifg=#eea040 guibg=#222222
  hi User2 guifg=#dd3333 guibg=#222222
  hi User3 guifg=#ff66ff guibg=#222222
  hi User4 guifg=#a0ee40 guibg=#222222
  hi User5 guifg=#eeee40 guibg=#222222

  set statusline=
  set statusline +=%1*\ %n\ %*            "buffer number
  set statusline +=%5*%{&ff}%*            "file format
  set statusline +=%3*%y%*                "file type
  set statusline +=%4*\ %<%F%*            "full path
  set statusline +=%2*%m%*                "modified flag
  set statusline +=%1*%=%5l%*             "current line
  set statusline +=%2*/%L%*               "total lines
  set statusline +=%1*%4v\ %*             "virtual column number
  set statusline +=%2*0x%04B\ %*          "character under cursor

  set laststatus=2
endif

" NERDTree configuration
" Config lines cribbed from https://github.com/scrooloose/nerdtree
"
" Open NERDTree automatically when Vim starts up
" autocmd vimenter * NERDTree
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Show tags in current file in left sidebar
" :h tagbar
let g:tagbar_left = 1
nnoremap <silent> <Leader>tb :TagbarToggle<CR>

" Make the unnamed register the same as the clipboard register.  The unnamed
" register is where text is stored when you yank it.  By making it the same
" as the clipboard, yanking and pasting in Vim affects the Windows clipboard.
" http://vim.wikia.com/wiki/VimTip21
" set clipboard=unnamed

nmap <F1> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <F1> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <F2> :.w !pbcopy<CR><CR>
vmap <F2> :w !pbcopy<CR><CR>

" Shift+CR adds an 'end' to a Ruby block and puts the cursor back on the
" previous line.
imap <S-CR> <CR><CR>end<Esc>-cc

" Reselect the text just pasted so I can perform commands (like indentation) on
" it.  http://stevelosh.com/blog/2010/09/coming-home-to-vim
nnoremap <leader>v V`]

" Tag ruby
nnoremap <leader>t :!ctags -R --languages=ruby<CR>

" Golang settings
" Format with goimports instead of gofmt
let g:go_fmt_command = 'goimports'

" if has('gui_running')
"   " Settings for GUI mode - i.e. running under Windows
"
"   " Change the font and font size.
"   set guifont=Consolas:h10:cANSI
"
"   " Maximise the window (on Windows)
"   " http://vim.wikia.com/wiki/Maximize_or_set_initial_window_size
"   au GUIEnter * simalt ~x
"
"   " Remove the toolbar.  Vim experts don't use toolbar buttons!
"   set guioptions-=T
"
"   " Highlight text that goes over the 80 column limit.  This is Windows only
"   " because Vim on Linux is often used for log files, where this setting is a
"   " nuisance!
"   " See http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns
"   set colorcolumn=81
"
" Put temporary files in the temp directory, rather than the current
" directory (so they don't turn up in svn/git status).
" http://stackoverflow.com/questions/4824188/git-ignore-vim-temporary-files
set backupdir=$TEMP//,/tmp//
set directory=$TEMP//,/tmp//
"
"   " Force vim to use Slick grep on Windows (rather than 'findstr'), and tell it
"   " how to interpret the results that it gets (filename + space + line number +
"   " space + column number + colon + the match string)
"   set grepprg=grep
"   set grepformat=%f\ %l\ %c:%m
" endif
