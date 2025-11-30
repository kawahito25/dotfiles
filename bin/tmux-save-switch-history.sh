
#!/usr/bin/env zsh

tmux_switch_history_path="$HOME/.dotfiles_tmux_history"
touch "$tmux_switch_history_path"

(echo $1; cat "$tmux_switch_history_path" 2>/dev/null) \
    | awk '!visited[$0]++ { print $0 }' \
    | head -n 20 > "${tmux_switch_history_path}.tmp"

mv "${tmux_switch_history_path}.tmp" "$tmux_switch_history_path"

