alias cat='bat --paging=never'
alias eza='LS_COLORS="" eza'
alias ls='eza -F --icons=auto --hyperlink'
alias lg='[ -n "$TMUX" ] && tmux display-popup -E -w100% -h100% -d "#{pane_current_path}" "lazygit" || lazygit'
alias nv='nvim'
alias tls='tmux list-windows -a -F "#{session_name}:#{window_index}:#{window_name}" | fzf --reverse --header "Select Window (Test)" | cut -d: -f3 | xargs -I@ tmux select-window -t @'

