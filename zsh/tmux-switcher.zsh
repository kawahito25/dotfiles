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
    else
        tmux switch-client -t "$target_session:$target_window_idx"
    fi
}

zle -N tls
bindkey '^l' tls

