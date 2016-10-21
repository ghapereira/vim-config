set nocompatible        " be iMproved, required
filetype on             " required
filetype off            " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" vim-less
Plugin 'groenewege/vim-less'
" emmet (autocomplete)
Plugin 'mattn/emmet-vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'Valloric/MatchTagAlways'
" vim start screen with last used files
Plugin 'mhinz/vim-startify'
" status bar
Plugin 'Lokaltog/vim-powerline'
"PEP-8
Plugin 'nvie/vim-flake8'
" git status
Plugin 'airblade/vim-gitgutter'
" file browser
Plugin 'scrooloose/NERDTree'
" the silver searcher
Plugin 'rking/ag.vim'
" Flex / Bison syntax
Plugin 'justinmk/vim-syntax-extra'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on               " syntax coloring; enable uses from theme, on overrides for defaults
nnoremap <Leader>m :w <BAR> !lessc % > %:t:r.css<CR><space>
" remap Ctrl+(JKLH) to move through panels
nnoremap  <C-J> <C-W><C-J>
nnoremap  <C-K> <C-W><C-K>
nnoremap  <C-L> <C-W><C-L>
nnoremap  <C-H> <C-W><C-H>
" remap <,>+<Space> to remove search color
nnoremap ,<Space> :nohlsearch
" remap z, e c, to paste/nopaste
nnoremap z, :set paste
nnoremap c, :set nopaste
set number              " show line number
set relativenumber
set autoindent          " autoindent based on last indent
set ignorecase          " ignore case on search

" colorscheme badwolf     " color scheme
" set background=light
" colorscheme solarized
colorscheme atom-dark-256

" tabs config
set tabstop=2           " number of visual spaces per TAB
set softtabstop=2       " number of spaces in tab when editing
set expandtab           " tabs into spaces
set shiftwidth=2
" specific tabs config for filetype
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType c setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType cpp setlocal shiftwidth=4 tabstop=4 softtabstop=4

set showcmd             " show last command in bottom bar
set cursorline          " hihlight current line
set lazyredraw          " redraw only when needed
set showmatch           " match brackets and parenthesis
set incsearch           " search as characters are inserted
set hlsearch            " highlight search matches
set nowrap              " display long lines as just one

" highlight last inserted text
nnoremap gV `[v`]
" the silver searcher, on vim
set runtimepath^=~/.vim/bundle/ag
" color after line 80
" let &colorcolumn=join(range(81,999), ",")

" startify on new tabs
" Not satisfactory; each new file will be opened as Startify
" autocmd BufEnter * if !exists('t:startified') | Startify | let t:startified = 1 | endif

" show trailing spaces
set list
set listchars=tab:>.,trail:.,extends:\#,nbsp:.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

set ruler               " display the cursor position in the lower right corner
set colorcolumn=80      " enforce 80 cols
set smartindent
set encoding=utf-8
" let g:solarized_termcolors=256
set t_Co=256
set scrolloff=8              " keep the cursor N lines under the top margin and above the bottom one

" Sessions
set ssop-=options       " do not store global and local variables in a session
set ssop-=folds         " do not store folds

" Emmet configs
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
imap hh <C-y>,

" TABS
" Show tab number
if exists("+showtabline")
     function MyTabLine()
         let s = ''
         let t = tabpagenr()
         let i = 1
         while i <= tabpagenr('$')
             let buflist = tabpagebuflist(i)
             let winnr = tabpagewinnr(i)
             let s .= '%' . i . 'T'
             let s .= (i == t ? '%1*' : '%2*')
             let s .= ' '
             let s .= '[' . i . ']'
             let s .= ' %*'
             let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
             let file = bufname(buflist[winnr - 1])
             let file = fnamemodify(file, ':p:t')
             if file == ''
                 let file = '[No Name]'
             endif
             let s .= file
             let i = i + 1
         endwhile
         let s .= '%T%#TabLineFill#%='
         let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
         return s
     endfunction
     set stal=1
     set tabline=%!MyTabLine()
endif

" Toggle highlighting for the current word on and off (Enter).
let g:highlighting = 0
function! Highlighting()
 if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
   let g:highlighting = 0
   return ":silent nohlsearch\<CR>"
 endif
 let @/ = '\<'.expand('<cword>').'\>'
 let g:highlighting = 1
 return ":silent set hlsearch\<CR>"
endfunction

set laststatus=2

" Cool files syntax
au BufNewFile,BufRead *.cl setf cool

