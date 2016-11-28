filetype off
if has('vim_starting')
      if &compatible
              set nocompatible               " Be iMproved
                endif

                  set runtimepath+=~/.vim/bundle/neobundle.vim
              endif

              call neobundle#begin(expand('~/.vim/bundle/'))

              " originalrepos on github
              NeoBundle 'Shougo/neobundle.vim'
              NeoBundle 'VimClojure'
              NeoBundle 'Shougo/vimshell'
              NeoBundle 'Shougo/unite.vim'
              NeoBundle 'Shougo/neocomplcache'
              NeoBundle 'Shougo/neosnippet'
              NeoBundle 'Shougo/neosnippet-snippets'
              NeoBundle 'jpalardy/vim-slime'
              NeoBundle 'scrooloose/syntastic'
              NeoBundle 'Shougo/vimfiler.vim'
              NeoBundle 'itchyny/lightline.vim'
              NeoBundle 't9md/vim-textmanip'
              NeoBundle 'ujihisa/unite-colorscheme'
              NeoBundle 'tomasr/molokai'
              NeoBundle 'nathanaelkane/vim-indent-guides'
              NeoBundle 'plasticboy/vim-markdown'
              NeoBundle 'kannokanno/previm'
              NeoBundle 'tyru/open-browser.vim'
              NeoBundle 'davidhalter/jedi-vim'
              ""NeoBundle 'https://bitbucket.org/kovisoft/slimv'

              call neobundle#end()

              filetype plugin indent on     " required!
              filetype indent on
              syntax on

              NeoBundleCheck





" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"ここからが足したやつ



"タブの代わりに空白文字を挿入する
set expandtab
"行番号を表示する
set number
"シフト移動幅
set shiftwidth=4
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
""検索時に大文字を含んでいたら大/小を区別
set smartcase
"新しい行を作ったときに高度な自動インデントを行う
set smartindent
""行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
"ファイル内の <Tab> が対応する空白の数
set tabstop=4
"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]

set laststatus=2
highlight LineNr ctermfg=darkyellow
"全角スペースの可視化
"""""""""
function! ZenkakuSpace()
        highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif

"ステータスラインを常時
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'
if has('syntax')
    augroup InsertHook
        autocmd!
        autocmd InsertEnter * call s:StatusLine('Enter')
        autocmd InsertLeave * call s:StatusLine('Leave')
    augroup END
endif
let s:slhlcmd = ''
function! s:StatusLine(mode)
    if a:mode == 'Enter'
            silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
                silent exec g:hi_insert
            else
                    highlight clear StatusLine
                        silent exec s:slhlcmd
                    endif
                endfunction
                function! s:GetHighlight(hi)
                      redir => hl
                      exec 'highlight '.a:hi
                        redir END
                        let hl = substitute(hl, '[\r\n]', '', 'g')
                        let hl = substitute(hl, 'xxx', '', '')
                        return hl
                    endfunction


filetype on

if exists("b:current_syntax")
      finish
endif

runtime! syntax/cpp.vim
unlet b:current_syntax


syn keyword FFstorage real func border mesh fespace varf matrix problem complex
syn keyword FFstatement Cmatrix R3 break continue element else end include load solve string varf vertex 

syn keyword FFfunctionoff BFGS EigenValue LinearCG LinearGMRES NLCG Newtow abs acos acosh adaptmesh arg asin asinh assert atan atan2 atanh average buildmesh buildmeshborder checkmovemesh clock conj convect cos cosh dumptable dx dxx dxy dy dyx dyy emptymesh exec exit exp imag int1d int2d intalledges interplotematrix interpolate jump log log10 max mean min movemesh norm on otherside plot polar pow readmesh savemesh set sin sinh splitsqrt square tan tanh triangulate trunc macro cout cin endl j0 j1 jn y0 y1 yn erf erfc tgamma lgamma processor broadcast

syn keyword FFconstantff CG CPUTime Cholesky Crout GMRES HaveUMFPACK LU N NoUseOfWait P P0 P0edge P1 P1b P1dc P1nc P2 P2b P2dc P2h P2b RT0 RT0Ortho RTmodif UMFPACK area false hTriangle inside label lenEdge nTonEdge nuEdge nuTriangle pi qf1pE qf1pElump qf1pT qf1pTlump qf2pE qf2pT qf2pT4P1 qf3pE qf5pT qf7pT qf9pT region true verbosity version x y z mpisize mpirank

hi def link FFstorage Type 
hi def link FFstatement Statement
hi def link FFfunctionoff Statement
hi def link FFconstantff Constant

let b:current_syntax="edp"

"markdown記法に関するやつ
au BufRead,BufNewFile *.md set filetype=markdown

