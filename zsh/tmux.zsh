
if [ -n "$TMUX" ]; then
    function preexec_hook() {
        local file_path=/tmp/tmux_last_command$(tty)
        mkdir -p $(dirname $file_path) && echo "$1" >| $file_path
        # tmux refresh-client -t $(tty)
    }
    # フックの登録
    autoload -Uz add-zsh-hook
    add-zsh-hook preexec preexec_hook
fi

