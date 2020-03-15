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
    set guifontwide=Ricty\ Diminished:h14
    set guifont=Ricty\ Diminished:h14
end
