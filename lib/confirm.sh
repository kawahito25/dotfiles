# --------------------------------------------------------------------------------------
# 💡 利用例 (Usage Examples)
# --------------------------------------------------------------------------------------
# confirm 関数は、ユーザーに y/n の入力を求め、その結果を終了コード (0: 成功/y, 1: 失敗/n) で返す。
#
# 📌 デフォルト設定:
#    引数なしで呼び出すと、デフォルトメッセージ「続行しますか？」と、
#    デフォルトアクション「--default y」で動作します。
#
# 1. 最小限の呼び出し (Enter = Y):
#    if confirm; then ...
#
# 2. カスタムメッセージを使用 (Enter = Y):
#    if confirm "本当に全てのファイルを削除しますか？"; then ...
#
# 3. デフォルトアクションを明示的に変更 (Enter = N):
#    if confirm "処理を続行しますか？" --default n; then ...
#
#
# 利用例:
#
# source $DOTFILES_DIR/lib/confirm.sh
#
# if confirm "本当に実行しても大丈夫ですか？" --default n; then
#    echo "ユーザーの承認を得ました。処理を続行します。"
# else
#    echo "ユーザーにより処理がキャンセルされました。"
# fi
# 
# --------------------------------------------------------------------------------------
confirm() {
    # デフォルト値の設定
    local DEFAULT_PROMPT="続行しますか？"
    local DEFAULT_FLAG_ACTION="y" # 📌 デフォルトのアクションを 'y' に設定

    # 引数から値を取得
    local PROMPT_MESSAGE="${1:-$DEFAULT_PROMPT}" # 引数$1がなければ、デフォルトメッセージを使用
    local DEFAULT_FLAG="${2}"
    local DEFAULT_ACTION="${3}"
    
    local PROMPT_SUFFIX
    local REPLY

    # 📌 引数チェックとデフォルト値の適用
    # --default フラグと y/n の指定がある場合は、そちらを優先する
    if [[ "$DEFAULT_FLAG" == "--default" && ("$DEFAULT_ACTION" == "y" || "$DEFAULT_ACTION" == "n") ]]; then
        # 明示的な指定がある場合は何もしない (そのまま使用)
        :
    else
        # 引数 (--default y/n) が提供されていない、または不正な場合
        # デフォルトのアクション 'y' を適用する
        DEFAULT_FLAG="--default"
        DEFAULT_ACTION="$DEFAULT_FLAG_ACTION"
    fi

    # プロンプトの末尾を設定
    if [[ "$DEFAULT_ACTION" == "y" ]]; then
        # デフォルトが 'y' の場合
        PROMPT_SUFFIX=" (Y/n, Enter=Y): "
    else
        # デフォルトが 'n' の場合
        PROMPT_SUFFIX=" (y/N, Enter=N): "
    fi

    # 入力を受け付ける
    read -p "${PROMPT_MESSAGE}${PROMPT_SUFFIX}" -r REPLY < /dev/tty

    # Enter後の改行を追加
    echo > /dev/tty

    # REPLY が空（Enterのみ）の場合、デフォルト動作を適用
    if [[ -z "$REPLY" ]]; then
        REPLY="$DEFAULT_ACTION"
    fi

    # ユーザーの入力（またはデフォルト値）をチェック
    if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
        return 1 # 'n' または 'N' の場合（失敗）
    fi

    return 0 # 'y' または 'Y' の場合（成功）
}
