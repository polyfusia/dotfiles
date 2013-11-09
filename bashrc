### .bashrc for MacOS X ###
# 本設定ファイルは.bash_profileから呼び出されることを前提とする

## プロンプト、及びエイリアスの設定 {{{
# ubuntuのデフォルトの.bashrcからいくらかインポート

# 対話モードで起動しなかった場合は
[ -z "$PS1" ] && return

# プロンプトの表示を変更
# export PS1="[\u@\h:\w]$ "
export PS1='\[\e[33m\][\t] \u@\h\[\e[0m\] \[\e[32m\]\w$\[\e[0m\] '

# lsをカラー化 オプションはgnuのlsと違うので注意
alias ls='ls -G'
# 他の省略形も定義
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# grepの結果をカラー化
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# サーバのショートカットなど、公開しちゃいけないものは別ファイルに書いて読み込む
if [ -f ~/dotfiles/secret_rc ]; then
    source ~/dotfiles/secret_rc
fi
## }}}
