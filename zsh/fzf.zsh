# brew install fzf
source <(fzf --zsh)

# use catppuccin color theme (FZF_DEFAULT_OPTS is set)
source $DOTFILES_DIR/catppuccin/fzf/themes/catppuccin-fzf-mocha.sh

# append option set by catppuccin
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --reverse --height 100% --tmux 100%,100% --style full"

# Customizing fzf options for completion
export FZF_COMPLETION_DIR_OPTS="--preview 'eza -T -L2 --color=always --icons=always {}'"
export FZF_COMPLETION_PATH_OPTS="--walker file,follow,hidden --preview 'bat --color=always {}'"

# コマンド履歴件数
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

# share .zshhistory
setopt inc_append_history
setopt share_history


# 過去に実行したコマンドを選択。ctrl-rにバインド
function select-history() {
  BUFFER=`history -n 1 | tac  | awk '{gsub(/[[:space:]]+$/, ""); if (!a[$0]++) print $0}' | fzf --query "$LBUFFER"`
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N select-history
bindkey '^r' select-history

# cdr
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

# search a destination from cdr list
function fzf-get-destination-from-cdr() {
  cdr -l | \
  sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
  fzf --query "$LBUFFER"
}

# fzf + cdr
function fzf-cdr() {
  local destination="$(fzf-get-destination-from-cdr)"
  if [ -n "$destination" ]; then
    BUFFER="cd $destination"
    zle accept-line
  else
    zle reset-prompt
  fi
}
zle -N fzf-cdr
bindkey '^u' fzf-cdr

# peco + ghq
function fzf-src () {
  local selected_dir=$(ghq list -p | fzf --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-src
bindkey '^G' fzf-src

