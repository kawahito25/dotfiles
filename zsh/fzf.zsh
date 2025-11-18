# brew install fzf
source <(fzf --zsh)

# use catppuccin color theme (FZF_DEFAULT_OPTS is set)
source $DOTFILES_DIR/submodules/catppuccin/fzf/themes/catppuccin-fzf-mocha.sh

# fzf-tab
autoload -U compinit; compinit
source $DOTFILES_DIR/submodules/fzf-tab/fzf-tab.plugin.zsh
zstyle ':fzf-tab:*' fzf-flags ${(z)FZF_DEFAULT_OPTS} # @see https://github.com/Aloxaf/fzf-tab/issues/475#issuecomment-2402904112
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup # for tmux

# append full screen options
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --reverse --height 100% --tmux 100%,100% --style full"

# Customizing fzf options for completion
export FZF_COMPLETION_DIR_OPTS="--preview 'eza -T -L2 --color=always --icons=always {}'"
export FZF_COMPLETION_PATH_OPTS="--walker file,follow,hidden --preview 'bat --color=always {}'"

# コマンド履歴件数
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

# share .zshhistory
# setopt inc_append_history
# setopt share_history

# 過去に実行したコマンドを選択。ctrl-rにバインド
# function select-history() {
  # BUFFER=`history -n 1 | tac  | awk '{gsub(/[[:space:]]+$/, ""); if (!a[$0]++) print $0}' | fzf --query "$LBUFFER"`
  # CURSOR=$#BUFFER
  # zle reset-prompt
# }
# zle -N select-history
# bindkey '^r' select-history

# CTRL-R
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:#CDD6F4
  --header 'Press CTRL-Y to copy command into clipboard'"

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
  fzf --no-sort --query "$LBUFFER"
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

