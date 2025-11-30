#!/usr/bin/env zsh

local tmux_switch_history_path="$HOME/.dotfiles_tmux_history"
touch "$tmux_switch_history_path"

selected=$(
    tmux-list-fzf-options.sh |
    awk -F: '{print " "$1"¥ "$3"\t"$0}' |
    column -s¥ -t |
    fzf --delimiter='\t' --with-nth=1 |
    cut -d $'\t' -f2
)

if [ -z "$selected" ]; then
    return
fi

target_session=$(echo $selected | cut -d ':' -f 1)
target_window_idx=$(echo $selected | cut -d ':' -f 2)

if [ -z "$TMUX" ]; then
    tmux attach-session -t "$target_session:$target_window_idx"
    tmux-save-switch-history.sh $selected
else
    tmux switch-client -t "$target_session:$target_window_idx"
    tmux refresh-client -S
    tmux-save-switch-history.sh $selected
fi

