#!/usr/bin/env zsh

local history_num=20
local history_file="$HOME/.dotfiles_tmux_history"

touch "$history_file"

function save_history() {
    (echo $1; cat "$history_file" 2>/dev/null) \
            | awk '!visited[$0]++ { print $0 }' \
            | head -n $history_num > "${history_file}.tmp"

    mv "${history_file}.tmp" "$history_file"
}

# history_file のパスを変数に格納 (AWKに渡すため)
local history_path="$history_file"

# tmuxのウィンドウリストを取得
windows=$(tmux list-windows -a -F "#{session_name}:#{window_index}:#{window_name}")

if [ -z "$windows" ]; then
    echo 'No Sessions'
    return
fi

# 1. AWKを使って、各行にソートキーを付与する
#    キーの形式: {順序インデックス}:{元の文字列}
#    history_fileにない場合は、非常に大きなインデックス(99999999)を付与する
selected_options=$(echo "$windows" | awk -v history_path="$history_path" '
    # AWK実行前に一度だけ実行
    BEGIN {
        # 履歴ファイルから順序マップを読み込む
        idx = 0;

        # 1行目は現在いる場所なので、スキップする
        if ((getline < history_path) > 0) {}

        while ((getline line < history_path) > 0) {
            order[line] = idx;
            idx++;
        }
        close(history_path);
    }

    # 標準入力の各行($0)に対して実行
    {
        if ($0 in order) {
            # 履歴にある場合: 順序インデックスを出力
            key = order[$0];
        } else {
            # 履歴にない場合: 非常に大きなインデックスを付与
            key = 99999999;
        }

        # 順序キーをタブ区切りで先頭に付与して出力
        print key "\t" $0;
    }
' | sort -k1,1n -k2,2d | cut -f2-)

# ソートされた結果を fzf に渡す
selected=$(echo "$selected_options" | fzf --tmux)

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

