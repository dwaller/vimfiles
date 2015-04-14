" Load all plugins
call pathogen#infect()
" And build help for them
call pathogen#helptags()

set nocompatible  " We don't want vi compatibility.
" Enable the backspace key in insert mode
" See http://vim.wikia.com/wiki/Backspace_and_delete_problems
set backspace=indent,eol,start

" Watch .vimrc for changes and automatically reload config.
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYVIMRC | endif
augroup END

" Syntax higlighting on; enable filetype detection and filetype specific
" plugins and indentation
syntax on
filetype plugin indent on

" Recognise Guardfiles as ruby
au BufNewFile,BufRead Guardfile.* set filetype=ruby

" Use the vividchalk colourscheme.  Looks much like TextMate on the Mac.
colorscheme solarized
" colorscheme vividchalk

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

" Test output from xunit tests
set wildignore=TEST-*.xml

" ag, not ack
let g:ackprg = "ag --nogroup --nocolor --column"

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

" F7 and F8 to move to next/previous buffer
nmap <F7> :bp<CR>
nmap <F8> :bn<CR>
" F2 to save whilst in insert mode (remain in insert mode)
imap <F2> <C-o>:w<CR>
" Ctrl+ up/down to scroll
nmap <C-Down> <C-e>
nmap <C-Up> <C-y>
" Ctrl+Shift+ up/down to move through grep matches
nmap <M-S-Down> :cn<CR>
nmap <M-S-Up> :cp<CR>

let g:ctrlp_cmd = 'CtrlPMixed'
" Search for a file using FuzzyFinder
nmap <silent> sf :FufFile<CR>
" Search for a buffer using FuzzyFinder
nmap <silent> sb :FufBuffer<CR>
nmap <leader>b :CtrlPBuffer<CR>

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

nmap <F9> :TagbarToggle<CR>

" Make the unnamed register the same as the clipboard register.  The unnamed
" register is where text is stored when you yank it.  By making it the same
" as the clipboard, yanking and pasting in Vim affects the Windows clipboard.
" http://vim.wikia.com/wiki/VimTip21
" set clipboard=unnamed

nmap <F1> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <F1> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <F2> :.w !pbcopy<CR><CR>
vmap <F2> :w !pbcopy<CR><CR>

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
"   " Put temporary files in the temp directory, rather than the current
"   " directory (so they don't turn up in svn/git status).
"   " http://stackoverflow.com/questions/4824188/git-ignore-vim-temporary-files
"   set backupdir=$TEMP//
"   set directory=$TEMP//
"
"   " Force vim to use Slick grep on Windows (rather than 'findstr'), and tell it
"   " how to interpret the results that it gets (filename + space + line number +
"   " space + column number + colon + the match string)
"   set grepprg=grep
"   set grepformat=%f\ %l\ %c:%m
" endif
