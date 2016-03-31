""" {{{
"
" .gvimrc
"
" フォントなどgvim用の設定を投入
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
    set guifontwide=Ricty\ Discord:h14
    set guifont=Ricty\ Discord:h14
end
