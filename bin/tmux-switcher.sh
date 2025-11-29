#!/usr/bin/env zsh

local tmux_switch_history_path="$HOME/.dotfiles_tmux_history"
touch "$tmux_switch_history_path"

function save_history() {
    (echo $1; cat "$tmux_switch_history_path" 2>/dev/null) \
            | awk '!visited[$0]++ { print $0 }' \
            | head -n 20 > "${tmux_switch_history_path}.tmp"

    mv "${tmux_switch_history_path}.tmp" "$tmux_switch_history_path"
}

selected=$(tmux-list-fzf-options.sh | fzf --tmux)

if [ -z "$selected" ]; then
    return
fi

target_session=$(echo $selected | cut -d ':' -f 1)
target_window_idx=$(echo $selected | cut -d ':' -f 2)

if [ -z "$TMUX" ]; then
    tmux attach-session -t "$target_session:$target_window_idx"
    save_history $selected
else
    tmux switch-client -t "$target_session:$target_window_idx"
    save_history $selected
fi

