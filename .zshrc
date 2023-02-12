### Path関連 ###
export PATH=/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:${PATH}
# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

case "${OSTYPE}" in
    darwin*)
        # JDK
        #
        # for Homebrew
        if [ "$(uname -m)" = "arm64" ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
            export PATH="/opt/hoembrew/bin:$PATH"
        else
            eval "$(/usr/local/bin/brew shellenv)"
        fi
        ;;
esac
alias vim='nvim'
alias vimdiff='nvim -d'
alias rm='trash'
alias pip-upgrade-all="pip list -o | tail -n +3 | awk '{ print \$1 } | xargs pip install -U"

case "${OSTYPE}" in
    darwin*)
        alias x86='arch -x86_64 zsh'
        alias arm64='arch -arm64 zsh'
        ;;
esac


### 一般 ####
# 文字コードをUTF-8に設定
export LANG=en_US.UTF-8 
# キーバインドをemacsモードに設定
bindkey -e

function updatePrompt {
    if [[ "$(pyenv version-name 2>/dev/null)" != "" ]]; then
        PYENV_VER_NAME=`pyenv version-name`
    else
        PYENV_VER_NAME='system'
    fi
    case "${OSTYPE}" in
        darwin*)
            # Homebrew ビール絵文字非表示
            export HOMEBREW_NO_EMOJI=1
            # プロンプトのフォーマット
            PROMPT="%n@%m(${PYENV_VER_NAME}-$(uname -m | sed 's/_64//g')):%1~ %% "
            ;;
        linux*)
            # プロンプトのフォーマット
            PROMPT="Yusaku@%m(${PYENV_VER_NAME}-$(uname -m)):%1~ %% "
            ;;
    esac
}

export PROMPT_COMMAND='updatePrompt'
precmd() { eval '$PROMPT_COMMAND' }


# git ブランチ名を色付きで表示させるメソッド
function rprompt-git-current-branch {
  if [ ! -e  ".git" ]; then
    # git 管理されていないディレクトリは何も返さない
    return
  fi
  # ブランチ名を表示
  echo "[`git rev-parse --abbrev-ref HEAD 2> /dev/null`]"
}
 
# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst
 
# プロンプトの右側にメソッドの結果を表示させる
RPROMPT='`rprompt-git-current-branch`'

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

case "${OSTYPE}" in
    darwin*)
        if [ "$(uname -m)" = "arm64" ]; then
            export PYENV_ROOT="$HOME/.pyenv"
        else
            export PYENV_ROOT="$HOME/.pyenv_x86"
        fi
        export PATH="$PYENV_ROOT/shims:$PATH"
        ;;
    linux*)
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        ;;
esac

export PIPENV_PYTHON="$PYENV_ROOT/python"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
