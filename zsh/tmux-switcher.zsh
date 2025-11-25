#!/usr/bin/env zsh

local history_num=20
local history_file="$HOME/.dotfiles_tmux_history"

echo "$history_file"
touch "$history_file"

function save_history() {
    (echo $1; cat "$history_file" 2>/dev/null) \
            | awk '!visited[$0]++ { print $0 }' \
            | head -n $history_num > "${history_file}.tmp"

    mv "${history_file}.tmp" "$history_file"
}

function tls() {
    # target_session=$(tmux list-sessions -F '#{session_name}' | fzf)
    windows=$(tmux list-windows -a -F "#{session_name}:#{window_index}:#{window_name}")
    if [ -z "$windows" ]; then
        echo 'No Sessions'
        exit 0
    fi

    selected=$(echo "$windows" | fzf)
    if [ -z "$selected" ]; then
        exit 0
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
}

zle -N tls
bindkey '^l' tls

