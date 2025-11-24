source ./.zshenv # for $DOTFILES_DIR

ln -sf $DOTFILES_DIR/.zshenv ~/.zshenv
ln -sf $DOTFILES_DIR/.zshrc ~/.zshrc
ln -sf $DOTFILES_DIR/.hushlogin ~/.hushlogin
ln -sf $DOTFILES_DIR/.tmux.conf ~/.tmux.conf
ln -sf $DOTFILES_DIR/.p10k.zsh ~/.p10k.zsh 
ln -sf $DOTFILES_DIR/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -sf $DOTFILES_DIR/submodules/catppuccin/alacritty/catppuccin-mocha.toml ~/.config/alacritty/catppuccin-mocha.toml
ln -sf $DOTFILES_DIR/ghostty/config ~/.config/ghostty/config
ln -sf $DOTFILES_DIR/nvim/ ~/.config/
ln -sf $DOTFILES_DIR/.myclirc ~/.myclirc

# bat theme of catppuccin
mkdir -p "$(bat --config-dir)/themes"
ln -sf $DOTFILES_DIR/submodules/catppuccin/bat/themes "$(bat --config-dir)/themes"

# eza theme of catppuccin
if [ -n "$EZA_CONFIG_DIR" ]; then
  mkdir -p $EZA_CONFIG_DIR
  ln -sf $DOTFILES_DIR/submodules/catppuccin/eza/themes/mocha/catppuccin-mocha-mauve.yml "$EZA_CONFIG_DIR/theme.yml"
else
  echo "WARN: EZA_CONFIG_DIR not set. Skipping symbolic link creation."
fi

