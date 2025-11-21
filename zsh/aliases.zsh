alias cat='bat --paging=never'
alias eza='LS_COLORS="" eza'

alias gst='git status'
alias gco='git checkout'
alias gbr='git branch'
alias gdf='git diff'
alias gdfs='git diff --staged'
alias glg='git log --oneline --graph --decorate'
alias gad='git add .'
alias gci='git commit'
alias gcam='git commit --amend'

alias ls='eza -F --icons=auto --hyperlink'
alias lg='[ -n "$TMUX" ] && tmux display-popup -E -w100% -h100% -d "#{pane_current_path}" "lazygit" || lazygit'
alias nv='nvim'
alias tls='tmux list-windows -a -F "#{session_name}:#{window_index}:#{window_name}" | fzf --reverse --header "Select Window (Test)" | cut -d: -f3 | xargs -I@ tmux select-window -t @'

