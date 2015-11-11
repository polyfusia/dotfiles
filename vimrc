""" {{{
"
"  .vimrc version 2013/11/10
"  ubuntuで使っている設定をいくつかインポート
" 
""" }}}

" vi互換を無効
set nocompatible
" プラグインのために、vim自身のファイル認識をオフ
filetype off

""" {{{
"
" NeoBundleの設定
"
""" }}}

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle/'))

" NeoBundle自体をNeoBundleで管理する
NeoBundleFetch 'Shougo/neobundle.vim'

" vimprocのインストール
" コンパイルもNeoBundleでやってしまう
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

" プラグイン管理
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
" NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'nvie/vim-flake8'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/Align'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'itchyny/lightline.vim'

call neobundle#end()

" プラグインごとのファイル認識をオン
" 本設定はNeoBundleの設定の後に記述する必要がある
filetype plugin indent on

""" {{{
"
" unite.vim
"
""" {{{

" prefixキー
nnoremap [unite] <Nop>
nmap <Leader>f [unite]

" unite.vimのキーマップ
" file
nnoremap <silent> [unite]f :<C-u>Unite<Space>file<CR>
" buffer
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
" file mru
nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>

"" }}}
"
"  VimFiler
"
""" }}}
" VimFilerを起動するキーマップをセット
nnoremap <silent> [unite]a :<C-u>VimFiler<CR>

" セーフモードをデフォルトでオフにする
let g:vimfiler_safe_mode_by_default = 0
"" }}}

""" {{{
"
"  syntastic
"
""" {{{

" syntasticレコメンセッティング
" https://github.com/scrooloose/syntastic#3-recommended-settings

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" rubyはrubocopでチェック
" http://qiita.com/yuku_t/items/0ac33cea18e10f14e185

let g:syntastic_ruby_checkers = ['rubocop']

" pythonはflake8でチェック
" http://dackdive.hateblo.jp/entry/2015/01/07/225059
let g:syntastic_python_checkers = ['flake8']

""" {{{
"
"  lightline
"  https://github.com/itchyny/lightline.vim
"
""" }}}

let g:lightline = {
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \ },
      \ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction


""" }}}
"
"  全般設定
"
""" }}}

" 利用するカラースキーマ
colorscheme desert
" 文法表示をカラー化
syntax on
" 自動改行をしない
set tw=0
" スワップファイルとかバックアップファイルは作らない
set noswapfile
set nobackup
set nowritebackup
" スクリーンベルは無効化
set t_vb=
set novisualbell
" 保存していなくても別のバッファを開けるようにする
set hidden
" 行番号を表示
set number
" 閉じカッコ入力時に対応するカッコを表示
set showmatch
" 対応するカッコの表示時間を指定
set matchtime=3
" インデント機能 autoindent/smartindent/cindent/indentexpr からチョイス
set smartindent  " 改行時に入力された行の末尾に合わせてインデント
set autoindent   " 改行時に前の行のインデントを継続する
" ウィンドウの幅より長い行は次の行に折り返す
set wrap
" 座標を表示
set ruler
" バックスペースで色々消せるようにする
set backspace=indent,eol,start
" タブに対応する空白文字の数
set tabstop=4
" タブやバックスペース押下時のタブ文字に対応する空白文字の数
set softtabstop=4
" インデントの各段階に使われる空白の数
set shiftwidth=4
" タブは空白文字
set expandtab
" スクロールする時に余白を確保する
set scrolloff=5
" コマンド補完をリッチに
set wildmenu wildmode=list:full
" 不可視文字を指定。デフォルトは見せず、後ろの設定のトグルで表示/非表示を切り替える
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

" ### 検索関連 ###
" インクリメンタルサーチを有効にする
set incsearch
" 検索文字列が小文字なら、大文字小文字の区別なく検索
set ignorecase
" 大文字が含まれるなら区別する
set smartcase
" 検索結果をハイライト
set hlsearch
" 最後まで検索したら、ループ
set wrapscan

" ### ショートカット ###
" tab /shift-tabでタブを切り替える
nmap <Tab> gt
nmap <S-Tab> gT

" Escを2回押しで検索のハイライトを消す
nmap <silent> <ESC><ESC> :noh<CR><ESC>

" Ctrl + hjkl でウィンドウ間を移動する
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Shift + カーソルキーでウィンドウサイズを変える
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" T + ? をトグルとする
nnoremap [toggle] <Nop>
nmap T [toggle]
" list
nnoremap <silent> [toggle]l :setl list!<CR>: setl list?<CR>
" wrap
nnoremap <silent> [toggle]w :setl wrap!<CR>: setl wrap?<CR>

" ### 開く拡張子によってインデント数を変更する ###
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.php setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.js setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.html setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END


" ### ステータス行の設定 ###
" ステータス行を、0:表示しない/1:ウィンドウ2つ以上で表示/2:常に表示
set laststatus=2

" ### その他の設定 ###
"カレントウィンドウに罫線を引く
augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    autocmd WinLeave * set nocursorcolumn
    autocmd WinEnter,BufRead * set cursorline
    autocmd WinEnter,BufRead * set cursorcolumn
augroup END
