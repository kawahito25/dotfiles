fancy-ctrl-z() {
    local suspended_jobs_list=$(jobs -s)
    local job_count=$(echo "$suspended_jobs_list" | grep -c '^\[')
    
    if [[ $job_count -gt 0 ]]; then
        
        if [[ $job_count -eq 1 ]]; then
            # 1. ジョブが1つしかない場合: 即座に fg
            BUFFER="fg"
            zle accept-line
            
        else
            # 2. ジョブが複数ある場合: FZFでジョブIDを直接取得
            
            # jobs -s の出力 (例: [1]+  Stopped  vim) をFZFに入力
	    # ctrl + z で閉じる（うっかり入力するとハングするため）
            local job_token=$(echo "$suspended_jobs_list" | \
                fzf \
                --no-sort \
                --prompt="Select Job (fg): " \
                --select-1 \
                --exit-0 \
                --delimiter='[ ]+' \
                --with-nth=3.. \
                --accept-nth=1 \
		--bind 'ctrl-z:abort' 
                )
            
            if [[ -n $job_token ]]; then
                # FZFは [1]+ のようなトークン全体を返してくれるはずです。
                # 例: job_token が "[1]+" のような形式
                
                # トークンから数字だけを取り出す (最も安全な方法)
                # ${job_token//[!0-9]/} は Zsh の機能で非数字を削除します。
                local job_id_number="${job_token//[^0-9]/}"
                
                # fg %N を実行
                BUFFER="fg %${job_id_number}"
                zle accept-line
            fi
        fi
        
    else
        # 3. ジョブが存在しない場合 (Suspend動作)
        if [[ $#BUFFER -ne 0 ]]; then
            zle push-input
            zle clear-screen
        fi
        zle send-break
    fi
}

zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

