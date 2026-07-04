# =========================================================
# Keybindings
# (zsh-vi-mode faz reset de todas as bindings no init, por isso
#  as custom vão dentro do hook zvm_after_init para sobreviverem)
# =========================================================

# Forma do cursor por modo vi
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK

# Sem highlight da linha em command mode
ZVM_VI_HIGHLIGHT_BACKGROUND=none
ZVM_VI_HIGHLIGHT_FOREGROUND=none
ZVM_VI_HIGHLIGHT_EXTRASTYLE=none

zvm_after_init() {
  # Ctrl+Right / Ctrl+Left -> palavra a palavra
  bindkey '^[[1;5C' forward-word
  bindkey '^[[1;5D' backward-word

  # Ctrl+\ -> toggle autosuggestions
  bindkey '^\' autosuggest-toggle

  # Up/Down -> pesquisa no histórico por substring
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
}
