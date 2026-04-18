source ./.zshenv # for $DOTFILES_DIR

ln -sf $DOTFILES_DIR/.zshenv ~/.zshenv
ln -sf $DOTFILES_DIR/.zshrc ~/.zshrc
ln -sf $DOTFILES_DIR/.hushlogin ~/.hushlogin
ln -sf $DOTFILES_DIR/.p10k.zsh ~/.p10k.zsh
ln -sf $DOTFILES_DIR/ghostty/config ~/.config/ghostty/config
ln -sf $DOTFILES_DIR/nvim/ ~/.config/
ln -sf $DOTFILES_DIR/.myclirc ~/.myclirc
ln -sf $DOTFILES_DIR/zellij ~/.config/

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

