# Load local (machine specific) config if exists
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# @see https://github.com/romkatv/powerlevel10k/issues/702#issuecomment-626222730
emulate zsh -c "$(direnv export zsh)"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

emulate zsh -c "$(direnv hook zsh)"

# set options
setopt auto_resume # リダイレクトを伴わない単一単語の単純コマンドを、既存ジョブの再開候補として扱う
# setopt extended_history # history にタイムスタンプを記録。fzf で表示できないのでやめた @see https://github.com/junegunn/fzf/issues/1308
setopt hist_ignore_all_dups # 過去に同じ履歴が存在するなら、古い履歴を削除し、重複させない
setopt hist_ignore_space # 先頭に半角スペースを入れたコマンドは履歴に入らない（履歴に残したくない一時的なコマンドに便利）
# setopt hist_reduce_blanks 改行も消えるので微妙だった
setopt inc_append_history # コマンドの実行と同時に履歴に追加 
setopt interactivecomments # コマンド実行時にコメントを使える（履歴からの検索キーワードとしても利用可能）
setopt share_history # 複数のシェルでコマンド履歴をリアルタイムで共有する

export EDITOR=nvim
bindkey -e

# source .zsh files
ZSH_DIR=$DOTFILES_DIR/zsh
if [ -d $ZSH_DIR ] && [ -r $ZSH_DIR ] && [ -x $ZSH_DIR ]; then
    # zshディレクトリより下にある、.zshファイルの分、繰り返す
    for file in ${ZSH_DIR}/**/*.zsh; do
        [ -r $file ] && source $file
    done
fi

