alias cat='bat --paging=never'
alias eza='LS_COLORS="" eza'

alias dlf='docker logs -f --tail=100'

alias gf='git fetch'
alias gst='git status -bs'
alias gco='git co'
alias gbr='git br'
alias gdi='git diff'
alias gdi-u='git -c delta.side-by-side=false diff'
alias gdis='git diff --staged'
alias gdis-u='git -c delta.side-by-side=false diff --staged'
alias glg='git log --oneline --graph --decorate'
alias gad='git add'
alias gcm='git commit'
alias gcma='git commit --amend'
alias gpu='git push origin HEAD'

alias ls='eza -F --icons=auto'
alias tree='ls -T'
alias nv='nvim'


