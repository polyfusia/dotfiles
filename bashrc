### .bashrc for MacOS X ###
# 本設定ファイルは.bash_profileから呼び出されることを前提とする

## プロンプト、及びエイリアスの設定
# ubuntuのデフォルトの.bashrcからいくらかインポート

# 対話モードで起動しなかった場合は
[ -z "$PS1" ] && return

# プロンプトの表示を変更
## \t: 時間, \u: ログインユーザ, \w: マシン名, __git_ps1: ブランチ名, \n: 改行
## ブランチ名は後続のgit補完を有効化する必要がある

# for local
export PS1='\[\033[32m\][\t] \[\033[33m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[1;31m\]$(__git_ps1)\[\033[00m\]\n\$ '

# for serverside
# export PS1='\[\033[32m\][\t] \[\033[35m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[1;31m\]$(__git_ps1)\[\033[00m\]\n\$ '

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

# socks proxy のコマンドの省力
# 主に参考にしたのは https://qiita.com/mu373/items/8236c3931e72194b4678

# entrance3にトンネルを貼る。ポート番号は10080。.ssh/config も参照すること
# バックグラウンドで動くので、とめるときは ps aux | grep ssh で探して kill する必要がある
alias tunnel='ssh -N -f entrance3'

# wifiのsock proxyの有効 / 無効 を切り替えるスクリプトのエイリアス
alias toggle_socks_proxy='sh ~/dotfiles/tools/toggle_socks_proxy.sh'

# サーバのショートカットなど、公開しちゃいけないものは別ファイルに書いて読み込む
if [ -f ~/dotfiles/secret_rc ]; then
    source ~/dotfiles/secret_rc
fi

export EDITOR=vim

## direnvを有効化
eval "$(direnv hook bash)"

## gitの補完を有効化
# homebrewでgitをインストールするとついてくるものを利用する
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash

## rbenvを有効化
# このrbenvはhomebrewで入れたので実行ファイルは /usr/local/bin にある
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# チュートリアルを実施しているときだけ。deprecatedとかの警告が出まくってイミフになるので抑制（本番ではだめ）
# export RUBYOPT='-W:no-deprecated -W:no-experimental'

## nodebrewを有効化
export PATH=$HOME/.nodebrew/current/bin:$PATH

## heroku autocomplete setup
HEROKU_AC_BASH_SETUP_PATH=/Users/suguru.hasegawa/Library/Caches/heroku/autocomplete/bash_setup && test -f $HEROKU_AC_BASH_SETUP_PATH && source $HEROKU_AC_BASH_SETUP_PATH;
