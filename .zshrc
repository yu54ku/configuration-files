### Path関連 ###
export PATH=/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:${PATH}
# TeX
# export PATH=/usr/texbin:${PATH}
# export PATH=/Library/TeX/texbin:${PATH}
export PATH=/usr/local/texlive/2018basic/bin/x86_64-darwin:${PATH}
# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

### 一般 ####
# 文字コードをUTF-8に設定
export LANG=en_US.UTF-8 
# キーバインドをemacsモードに設定
bindkey -e
# Homebrew ビール絵文字非表示
export HOMEBREW_NO_EMOJI=1
# プロンプトのフォーマット(Macでは無効推奨)
# PROMPT="%n@%m %1~ %% "
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
# 履歴を複数の端末で共有する
setopt share_history
# 複数のzshを同時に使用した際に履歴ファイルを上書きせず追加する
setopt append_history


### 補完関連 ###
# 補完機能を有効にする
autoload -Uz compinit
compinit -u
# 補完候補を一覧で表示する(d)
setopt auto_list
# 補完キー連打で補完候補を順に表示する(d)
setopt auto_menu
# 補完候補をできるだけ詰めて表示する
setopt list_packed
# 補完時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 
# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..
