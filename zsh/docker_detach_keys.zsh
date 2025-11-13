# docker コンテナ内で、ctrl + p がうまく機能しない。detachKeys を普段使わないようなキーに上書きすることで対応する

DOCKER_CONFIG_PATH="$HOME/.docker/config.json"
DOTFILES_FRAGMENT_PATH="$HOME/code/github.com/kawahito25/dotfiles/docker/detach_keys.json"

# .dockerディレクトリが存在しない場合は作成
mkdir -p "$(dirname "$DOCKER_CONFIG_PATH")"

# config.jsonが存在しない場合は空のJSONを作成
if [ ! -f "$DOCKER_CONFIG_PATH" ]; then
    echo "{}" > "$DOCKER_CONFIG_PATH"
fi

if $(jq 'has("detachKeys")' $DOCKER_CONFIG_PATH); then
  return 0
else
    jq '. + {"detachKeys": "ctrl-\\"}' "$DOCKER_CONFIG_PATH" > /tmp/config.json.tmp \
      && mv /tmp/config.json.tmp "$DOCKER_CONFIG_PATH" \
      && echo "✅ DockerのdetachKeysをdotfilesから設定しました。" 
fi



