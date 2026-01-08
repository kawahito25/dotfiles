# nvim がバックグラウンドプロセスにいるときに、vim-zellij-navigator が動かないので明示的にシェルのキーバインディングを追記
# GitHub Issue: https://github.com/hiasr/vim-zellij-navigator/issues/24

# Zellij 移動用関数を定義
function zellij-move-left()  { zellij action move-focus left  }
function zellij-move-right() { zellij action move-focus right }
function zellij-move-down()  { zellij action move-focus down  }
function zellij-move-up()    { zellij action move-focus up    }

# ZLE (Zsh Line Editor) ウィジェットとして登録
zle -N zellij-move-left
zle -N zellij-move-right
zle -N zellij-move-down
zle -N zellij-move-up

# キーバインドの設定 (Ctrl + h, l, j, k)
bindkey '^H' zellij-move-left
bindkey '^L' zellij-move-right
bindkey '^J' zellij-move-down
bindkey '^K' zellij-move-up
