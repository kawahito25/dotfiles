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
            local job_id_token=$(echo "$suspended_jobs_list" | \
                fzf \
                --no-sort \
                --prompt="Select Job (fg): " \
                --accept-nth=1 \
		--bind 'ctrl-z:abort' 
                )
            
            if [[ -n $job_id_token ]]; then
		# job_id_token （e.g. [1]）から、1 を取り出す
                BUFFER="fg %${job_id_token//[^0-9]/}"
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

