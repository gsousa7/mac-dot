# =========================================================
# ~/.zshenv — carregado primeiro, sempre. Manter minimal.
# Symlink: ~/.zshenv -> mac-dotfiles/zshenv
# =========================================================

# XDG base directories
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Apontar o zsh para a config em ~/.config/zsh (que é symlink para o repo)
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Starship lê o toml daqui
export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"
. "$HOME/.cargo/env"
