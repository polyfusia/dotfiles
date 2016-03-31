### .bashrc for MacOS X ###
# 本設定ファイルは.bash_profileから呼び出されることを前提とする

## プロンプト、及びエイリアスの設定 {{{
# ubuntuのデフォルトの.bashrcからいくらかインポート

# 対話モードで起動しなかった場合は
[ -z "$PS1" ] && return

# プロンプトの表示を変更
## \t: 時間, \u: ログインユーザ, \w: マシン名, __git_ps1: ブランチ名, \n: 改行
## ブランチ名は後続のgit補完を有効化する必要がある
export PS1='\[\033[35m\][\t] \u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[1;31m\]$(__git_ps1)\[\033[00m\]\n\$ '

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

export EDITOR=vim

## gitの補完を有効化
# homebrewでgitをインストールするとついてくるものを利用する
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash

## pyenv有効化
# homebrewでインストールしたので /sr/local/bin にある
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

## rbenvを有効化
# このrbenvはhomebrewで入れたので実行ファイルは /usr/local/bin にある
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

## phpenvを有効化
# phpenvの内部では自前のrbenvを使うため、phpenvへのパスは後ろにする
# composerのプラグインも一緒に入れてるので覚えとく https://github.com/ngyuki/phpenv-composer
export PATH=$PATH:~/.phpenv/bin
eval "$(phpenv init -)"

## nodebrewを有効化
# python2.7系じゃないとnodeのコンパイルが落ちるのでpyenvでの切り替えに注意
export PATH=$HOME/.nodebrew/current/bin:$PATH
