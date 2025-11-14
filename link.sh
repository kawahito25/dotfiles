source ./.zshenv # for $DOTFILES_DIR

ln -sf $DOTFILES_DIR/.zshenv ~/.zshenv
ln -sf $DOTFILES_DIR/.zshrc ~/.zshrc
ln -sf $DOTFILES_DIR/.tmux.conf ~/.tmux.conf
ln -sf $DOTFILES_DIR/.p10k.zsh ~/.p10k.zsh 
ln -sf $DOTFILES_DIR/alacritty/ ~/.config/
ln -sf $DOTFILES_DIR/nvim/ ~/.config/

# bat
mkdir -p "$(bat --config-dir)/themes"
ln -sf $DOTFILES_DIR/catppuccin/bat/themes "$(bat --config-dir)/themes"
bat cache --build


