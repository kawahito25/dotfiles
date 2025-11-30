#!/usr/bin/env zsh

local tmux_switch_history_path="$HOME/.dotfiles_tmux_history"
touch "$tmux_switch_history_path"

# tmuxのウィンドウリストを取得
windows=$(tmux list-windows -a -F "#{session_name}:#{window_id}:#{window_name}")

if [ -z "$windows" ]; then
    echo 'No Sessions'
    return
fi

# 1. AWKを使って、各行にソートキーを付与する
#    キーの形式: {順序インデックス}:{元の文字列}
#    tmux_switch_history_pathにない場合は、非常に大きなインデックス(99999999)を付与する
selected_options=$(echo "$windows" | awk -v history_path="$tmux_switch_history_path" '
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

echo $selected_options
