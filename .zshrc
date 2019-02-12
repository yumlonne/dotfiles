# zplug
source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
# theme (https://github.com/sindresorhus/pure#zplug)
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure"
# 構文のハイライト(https://github.com/zsh-users/zsh-syntax-highlighting)
zplug "zsh-users/zsh-syntax-highlighting"
# history関係
zplug "zsh-users/zsh-history-substring-search"
# タイプ補完
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi
# Then, source plugins and add commands to $PATH
zplug load

zstyle ':completion:*:default' menu select=2

# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history

# メモリに保存される履歴の件数
export HISTSIZE=1000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000

# 重複を記録しない
setopt hist_ignore_dups

# 開始と終了を記録
setopt EXTENDED_HISTORY

# 履歴の共有
setopt share_history

# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify

# 余分な空白は詰めて記録
setopt hist_reduce_blanks

# 古いコマンドと同じものは無視
setopt hist_save_no_dups

# historyコマンドは履歴に登録しない
setopt hist_no_store

# 補完時にヒストリを自動的に展開
setopt hist_expand

# 履歴をインクリメンタルに追加
setopt inc_append_history

# インクリメンタルからの検索
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

# peco(global history)
function peco-select-history() {
  BUFFER=$(\history -n 1 | revl | peco)
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# peco(dir history)
function peco-select-dir-history() {
  BUFFER=$(dh | revl | peco)
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-dir-history
bindkey '^t' peco-select-dir-history

zshaddhistory() {
    local line=${1%%$'\n'}
    if [ $line != '\n' ]; then
        echo $line >> .dir_history
    fi
}

export PATH="$HOME/bin:$PATH"

# .zshrc.localがあればそっちも読み込む
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
