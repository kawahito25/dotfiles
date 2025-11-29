alias cat='bat --paging=never'
alias eza='LS_COLORS="" eza'

alias dlf='docker logs -f --tail=100'

alias gf='git fetch'
alias gst='git status -bs'
alias gco='git checkout'
alias gbr='git branch'
alias gdi='git diff'
alias gdis='git diff --staged'
alias glg='git log --oneline --graph --decorate'
alias gad='git add'
alias gcm='git commit'
alias gcma='git commit --amend'
alias gpu='git push origin HEAD'

alias ls='eza -F --icons=auto'
alias tree='ls -T'
alias lg='[ -n "$TMUX" ] && tmux display-popup -E -w100% -h100% -d "#{pane_current_path}" "lazygit" || lazygit'
alias nv='nvim'


