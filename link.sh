source ./.zshenv # for $DOTFILES_DIR

ln -sf $DOTFILES_DIR/.zshenv ~/.zshenv
ln -sf $DOTFILES_DIR/.zshrc ~/.zshrc
ln -sf $DOTFILES_DIR/.tmux.conf ~/.tmux.conf
ln -sf $DOTFILES_DIR/.p10k.zsh ~/.p10k.zsh 
ln -sf $DOTFILES_DIR/alacritty/ ~/.config/

# nvim
for file in "$DOTFILES_DIR/nvim/lua/plugins/*"; do
  ln -sf "$file" ~/.config/nvim/lua/plugins/$(basename "$file")
done

