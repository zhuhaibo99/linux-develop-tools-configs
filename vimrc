" begin of vundle

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

execute pathogen#infect()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'skywind3000/gutentags_plus'
Plugin 'pangloss/vim-javascript'
Bundle 'majutsushi/tagbar'
Bundle 'Lokaltog/vim-easymotion'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" end of vundle


set nocp

" Tab related
set ts=4
set expandtab
"set sw=4
"set smarttab
"set et
"set ambiwidth=double
"
autocmd FileType html setlocal ts=2 sts=2 sw=2
autocmd FileType javascript setlocal ts=2 sts=2 sw=2

" Format related
" set tw=78
set lbr
set fo+=mB

" Indent related
set cin
set ai
set cino=:0g0t0(susj1

" Editing related
set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]
"set mouse=a
set selectmode=
set mousemodel=popup
set keymodel=
set selection=inclusive
set nu

" Misc
set wildmenu

" Encoding related
set encoding=utf-8
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" File type related
filetype plugin indent on

" Display related
set ru
set sm
set hls
syntax on
if (has("gui_running"))
    set guioptions+=b
    colo torte
    set nowrap
else
    colo ron
    "set background=dark
    "colorscheme default
    "colorscheme peachpuff
    "colorscheme desert
    "set wrap
endif

"=============================================================================
" Platform dependent settings
"=============================================================================

if (has("win32"))

    "-------------------------------------------------------------------------
    " Win32
    "-------------------------------------------------------------------------

    if (has("gui_running"))
        "set guifont=Bitstream_Vera_Sans_Mono:h9:cANSI
        "set guifontwide=NSimSun:h9:cGB2312
    endif

else

    if (has("gui_running"))
        set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
    endif

endif

"set bomb
set autoindent
set smartindent
set nocompatible
"set smarttab
"set noexpandtab
set tabstop=4
set shiftwidth=4
"set textwidth=78
set colorcolumn=80

set hlsearch
set incsearch
"set iskeyword+=_,$,@,%,#
"set iskeyword+=_
set backspace=indent,eol,start
set autochdir
"set tags+=./tags,../tags,../../tags,../../../tags,../../../../tags,../../../../../tags,../../../../../../tags
set tags=./tags;,tags
:set pastetoggle=<F10>
set completeopt=longest,menu

set magic


"set cursorline
"hi CursorLine   cterm=NONE ctermbg=black ctermfg=NONE guibg=NONE guifg=NONE

"hi comment ctermfg=1

if has("cscope")  
    set csprg=/usr/bin/cscope  
    set csto=0  
    set cst  
    set csverb  
    set cspc=3  
    "add any database in current dir  
    if filereadable("cscope.out")  
        cs add cscope.out  
    "else search cscope.out elsewhere  
    else  
       let cscope_file=findfile("cscope.out", ".;")  
       let cscope_pre=matchstr(cscope_file, ".*/")  
       if !empty(cscope_file) && filereadable(cscope_file)  
           exe "cs add" cscope_file cscope_pre  
       endif        
     endif  
endif 

set showtabline=2


set tabline=%!MyTabLine()  " custom tab pages line  
function MyTabLine()  
  let s = '' " complete tabline goes here
  " loop through each tab page
  for t in range(tabpagenr('$'))
    " select the highlighting for the buffer names
    if t + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    " empty space
    let s .= ' '
    " set the tab page number (for mouse clicks)
    let s .= '%' . (t + 1) . 'T'
    " set page number string
    let s .= t + 1 . ' '
    " get buffer names and statuses
    let n = ''  "temp string for buffer names while we loop and check buftype
    let m = 0 " &modified counter
    let bc = len(tabpagebuflist(t + 1))  "counter to avoid last ' '
    " loop through each buffer in a tab
    for b in tabpagebuflist(t + 1)
      " buffer types: quickfix gets a [Q], help gets [H]{base fname}
      " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
      if getbufvar( b, "&buftype" ) == 'help'
        let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
      elseif getbufvar( b, "&buftype" ) == 'quickfix'
        let n .= '[Q]'
      else
        let file = bufname(b)
        let file = fnamemodify(file, ':p:t')
        if file == ''
          let file = '[No Name]'
        endif
        if file == '__Tag_List__'
          let file = ''
        endif
        if file =~ '__Tagbar__'
          let file = ''
        endif
        let n .= file
      endif
      " check and ++ tab's &modified count
      if getbufvar( b, "&modified" )
        let m += 1
      endif
      " no final ' ' added...formatting looks better done later
      if bc > 1
        let n .= ' '
      endif
      let bc -= 1
    endfor
    " add modified label [n+] where n pages in tab are modified
    if m > 0
      "let s .= '[' . m . '+]'
      let s.= '+ '
    endif
    " add buffer names
    if n == ''
      let s .= '[No Name]'
    else
      let s .= n
    endif
    " switch to no underlining and add final space to buffer list
    "let s .= '%#TabLineSel#' . ' '
    let s .= ' '
  endfor
  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'
  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999XX'
  endif
  return s
endfunction 

" taglist
let Tlist_Auto_Open = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_WinWidth = 50
let Tlist_Show_One_File = 1
let Tlist_GainFocus_On_ToggleOpen = 0
" noremap <F8> :TlistToggle<CR>

" tagbar
nmap <F8> :TagbarToggle<CR>
" 启动时自动focus
let g:tagbar_autofocus = 0
let g:tagbar_left = 1
let g:tagbar_sort = 0
let g:tagbar_width = 45


let g:loaded_logipat = 1


" ctrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_root_markers = ['.repo']
let g:ctrlp_user_command = {
    \ 'types': {
      \ 1: ['.repo', 'cd %s && repo_list_files.sh'],
      \ 2: ['.git', 'cd %s && git ls-files'],
      \ },
    \ 'fallback': 'find %s -type f'
    \ }
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_regexp = 0

let g:loaded_airline_themes = 1
let g:airline_theme='base16_colors'


" ycm
let g:ycm_server_python_interpreter='/usr/bin/python'
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0
let g:ycm_key_list_select_completion = ['<TAB>', '<C-j>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<C-k>']
let g:ycm_key_invoke_completion = '<C-q>'
let g:ycm_collect_identifiers_from_tags_files = 1
"nnoremap gc :YcmCompleter GoToDeclaration<CR>
"nnoremap gd :YcmCompleter GoToDefinition<CR>
"nnoremap gi :YcmCompleter GoToInclude<CR>
nnoremap gc :YcmCompleter GoToDefinition<CR>


function OwnGetProjectRoot (path)
    let root = system('/data/zhuhaibo/tools/own-tools/get_project_root.sh ' . a:path)
    return root
endfunction

" gutentags + vim8.0
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_generate_on_missing = 1
let g:gutentags_project_root = ['.repo', '.git']
let g:gutentags_project_root_finder = 'OwnGetProjectRoot'
" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'
"let g:gutentags_modules = ['ctags', 'gtags_cscope']
let g:gutentags_modules = ['ctags']
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif
" 配置 ctags 的参数 "
let g:gutentags_ctags_extra_args = ['--fields=+niazKS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_extra_args += ['--exclude=build']
set statusline+=%{gutentags#statusline()}
" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1
"let g:gutentags_file_list_command = {
"    \ 'markers': {
"     \ '.git': 'repo_list_files.sh || git ls-files',
"     \ '.hg': 'hg files',
"     \ },
"    \ }
let g:gutentags_file_list_command = 'repo_list_files.sh'



syntax on
filetype plugin indent on



"nnoremap * *``

nmap <F2> :!grep.sh <C-r><C-w><cr>
noremap <silent> <F1> :GscopeFind s <C-R><C-W><cr>

highlight WhitespaceEOL ctermbg=red guibg=red 
match WhitespaceEOL /\s\+$/


if has("gui_running")
    map  <silent>  <S-Insert>  "+p
    imap <silent>  <S-Insert>  <Esc>"+pa
endif



let mapleader = " "

let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
"nmap s <Plug>(easymotion-overwin-f2)
map <Leader>h <Plug>(easymotion-linebackward)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-bd-jk)
nmap <Leader>j <Plug>(easymotion-overwin-line)
map  <Leader><Leader>  <Plug>(easymotion-bd-w)
nmap <Leader><Leader>  <Plug>(easymotion-overwin-w)



