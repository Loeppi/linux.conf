"========================================================================
" ~/.vim
" vim config file
"
" 2017-09-14 Frank Loepthien
"========================================================================

set nocompatible                  " don't force vi-compatibility. Must be first setting!
set runtimepath=~/.loeppi/vim/

"
" Python - Einstellungen
"
set textwidth=79                  " line-wrap after 79 chars
set shiftwidth=4                  " >> steps 4 columns right, << steps 4 columns left
set tabstop=4                     " Tabs sind 4 Spalten lang
set expandtab                     " Use spaces instead of tabs
set softtabstop=4                 " use 4 spaces if using tab/backspace
set shiftround                    " set indent to n times shiftwidth
set autoindent                    " do automatic indention (like line before) 
autocmd BufWritePost *.py call Flake8()

set autoread                      " reread file if changed outside of vim
set backup                        " create backup-files
set encoding=utf8                 " use UTF8
set foldmethod=indent
set hlsearch                      " highlight search results
set history=250
set ignorecase                    " search without case-sensitivity
set incsearch                     " do incremental searches
set list                          " show listchars
set listchars=tab:»·,trail:·      " 
set magic
set modeline 
set mouse=v                       " activate mouse
set noerrorbells
set nofoldenable
set novisualbell
set number                        " show line-numbers
set ruler
set showcmd
set showmatch                     " show matching brackets
set mat=2                         " for 2/10 sek
set smartcase                     " 
set smartindent                   " smart indent
set smarttab
set so=7                          " 7 lines bef/aft cursor when moving vert
set t_Co=256
set viminfo^=%
set wrap                          " line wrapping
colorscheme desert256             " color scheme (default/desert)
syntax on                         " syntax highlighting

"
" Starte Plugin-Manager pathogen
"
"
execute pathogen#infect()

"
" Konfiguration von Syntastic
"
let g:syntastic_always_populate_loc_list =1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:synctastic_check_on_wq = 0

"
"
"
filetype plugin on
filetype indent on                " Load language-dependent indenting

let mapleader = ","
let g:mapleader = ","
map <leader>hex :%!xxd<CR>        " Hexeditor mit ,hex starten
map <leader>nhex :%!xxd -r<CR>    " Hexeditor mit ,nhex beenden

map <F2> i#========================================================================<CR><ESC>
map <F3> :r!date +\%Y-\%m-\%d<CR>
map <F4> :r!date +\%H:\%M:\%S<CR>
map <F5> :w! <CR>:! pdflatex % <CR>
map <F6> :w! <CR>:! env python % <CR>
map <F12> :w!<CR>:!aspell --lang=de check %<CR>:e! %<CR>

map <tab> <c-x><c-f>
cmap w!! w !sudo tee % >/dev/null

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
  \ | wincmd p | diffthis
endif

"return to last edit position
if has ("autocmd")
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \    exe "normal! g'\"" |
    \ endif
endif

"helper-functions
"Returns true if paste mode is enabled
function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  en
  return ''
endfunction


"
" Statusline
"

set laststatus=2
set cmdheight=2
set statusline=
set statusline+=%{ChangeStatuslineColor()}
set statusline+=\ %{g:currentmode[mode()]} 
set statusline+=%1*\ %{GitInfo()}                        " Git Branch name
set statusline+=%2*\ %<%F\ %{ReadOnly()}\ %m\ %w\        " File+path
set statusline+=%2*\ [%-3(%{FileSize()}%)]\              " File size
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}             " Syntastic errors
set statusline+=%*
set statusline+=%2*\ %=                                  " Space
set statusline+=%3*\ %{&ff}                              " Fileformat
set statusline+=%3*\ %{(&fenc!=''?&fenc:&enc)}           " Encoding
set statusline+=%3*\ %y\                                 " FileType
set statusline+=%4*\ %3p%%\                              " Prozent 
set statusline+=%5*\ \ \ %l:%c\                         " Position

hi User1 ctermfg=244 ctermbg=238  "Git Branch
hi User2 ctermfg=255 ctermbg=238  "File, Path, Size
hi User3 ctermfg=244 ctermbg=234  "Space, Format, Encoding, Filetype
hi User4 ctermfg=214 ctermbg=238  "Prozente
hi User5 ctermfg=234 ctermbg=255  "Position

let g:currentmode={
    \ 'n'  : 'NORMAL ',
    \ 'no' : 'N·Operator Pending ',
    \ 'v'  : 'VISUAL ',
    \ 'V'  : 'V·Line ',
    \ '^V' : 'V·Block ',
    \ 's'  : 'Select ',
    \ 'S'  : 'S·Line ',
    \ '^S' : 'S·Block ',
    \ 'i'  : 'INSERT ',
    \ 'R'  : 'REPLACE ',
    \ 'Rv' : 'V·Replace ',
    \ 'c'  : 'Command ',
    \ 'cv' : 'Vim Ex ',
    \ 'ce' : 'Ex ',
    \ 'r'  : 'Prompt ',
    \ 'rm' : 'More ',
    \ 'r?' : 'Confirm ',
    \ '!'  : 'Shell ',
    \ 't'  : 'Terminal ' }

function! ChangeStatuslineColor()
    if (mode() ==# 'n')
        exe 'hi! StatusLine ctermbg=24 ctermfg=41'
    elseif (mode() ==# 'v' || g:currentmode[mode()] ==# 'V·Block' || get(g:currentmode, mode(), '') ==# 't')
        exe 'hi! StatusLine ctermbg=24 ctermfg=202'
    elseif (mode() ==# 'i')
        exe 'hi! StatusLine ctermbg=24 ctermfg=255'
    elseif (mode() ==# 'R')
        exe 'hi! StatusLine ctermbg=255 ctermfg=160'
    else
        exe 'hi! StatusLine ctermbg=238 ctermfg=244'
    endif
    return ''
endfunction

function! FileSize()
    let bytes = getfsize(expand('%:p'))
    if (bytes >= 1024)
        let kbytes = bytes / 1024
    endif
    
    if (exists('kbytes') && kbytes >= 1000)
        let mbytes = kbytes / 1000
    endif

    if bytes <= 0
        return '0'
    endif

    if (exists('mbytes'))
        return mbytes . 'MB '
    elseif (exists('kbytes'))
        return kbytes . 'KB '
    else
        return bytes . 'B '
    endif
endfunction

function! ReadOnly()
    if &readonly || !&modifiable
        return ''
    else
        return ''
endfunction

function! GitInfo()
    let git = fugitive#head()
    if git != ''
        return ' '.fugitive#head()
    else
        return ''
    endif
endfunction


