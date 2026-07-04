# =========================================================
# plugins.zsh — gestor de plugins próprio (sem OMZ/zinit)
# Os plugins são clonados para $ZDOTDIR/plugins/ no primeiro arranque.
# Atualizar todos: zplugin-update
# =========================================================

ZPLUGINDIR="${ZDOTDIR:-$HOME/.config/zsh}/plugins"

_zplugin_load() {
  # $1 = owner, $2 = repo (== nome do .plugin.zsh)
  local plugin_path="${ZPLUGINDIR}/${2}"
  if [[ ! -d "$plugin_path" ]]; then
    mkdir -p "$ZPLUGINDIR"
    echo "Installing ${2}..."
    git clone --depth=1 "https://github.com/${1}/${2}" "$plugin_path" \
      || { echo "ERROR: failed to install ${2}" >&2; return 1; }
  fi
  source "${plugin_path}/${2}.plugin.zsh"
}

zplugin-update() {
  local dir
  for dir in "${ZPLUGINDIR}"/*/; do
    echo "Updating ${dir:t}..."
    git -C "$dir" pull --ff-only
  done
}

# Ordem: syntax-highlighting DEVE ser o último (embrulha o ZLE).
_zplugin_load zsh-users        zsh-autosuggestions
_zplugin_load zsh-users        zsh-history-substring-search
_zplugin_load jeffreytse       zsh-vi-mode
_zplugin_load zdharma-continuum fast-syntax-highlighting

# Tuning do autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
