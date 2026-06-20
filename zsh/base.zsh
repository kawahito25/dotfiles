# brew install powerlevel10k
source $HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# brew install zsh-syntax-highlighting
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters

# brew install zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# brew install ripgrep
export RIPGREP_CONFIG_PATH=$DOTFILES_DIR/.ripgreprc

# brew install asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# brew install eza
export EZA_CONFIG_DIR="$HOME/.config/eza"

# add path for dotfiles scripts
export PATH="$DOTFILES_DIR/bin:$PATH"

# Go のパスを通す
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# llvm
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# C言語開発に必要なツールたち
export VCPKG_ROOT="$HOME/vcpkg"

# `pipx` for oj
export PATH="$PATH:$HOME/.local/bin"

