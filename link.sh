ln -sf $HOME/code/github.com/kawahito25/dotfiles/.zshrc ~/.zshrc
ln -sf $HOME/code/github.com/kawahito25/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf $HOME/code/github.com/kawahito25/dotfiles/.p10k.zsh ~/.p10k.zsh 
ln -sf $HOME/code/github.com/kawahito25/dotfiles/alacritty/ ~/.config/

# nvim
for file in $HOME/code/github.com/kawahito25/dotfiles/nvim/lua/plugins/*; do
  ln -sf "$file" ~/.config/nvim/lua/plugins/$(basename "$file")
done

