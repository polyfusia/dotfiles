""" {{{
"
" .gvimrc version 2013/11/10
" MacVim用の設定を少々
" 
""" }}}

if has('gui_macvim')
    " ウィンドウの透明度を指定
    set transparency=5
    " ツールバーを表示
    set guioptions+=T
    " カラースキーマ
    colorscheme desert

    " フォント設定
    set antialias
    set guifontwide=Ricty\ Discord:h12
    set guifont=Ricty\ Discord:h14
