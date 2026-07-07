# =========================================================
# .zshrc — orquestrador
# ZDOTDIR = ~/.config/zsh  (symlink -> mac-dotfiles/zsh)
# =========================================================

ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"

# ---- Homebrew (Apple Silicon) — cedo, para o resto ter o PATH ----
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ---- History (XDG) ----
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=500000
SAVEHIST=500000
mkdir -p "${HISTFILE:h}"
setopt EXTENDED_HISTORY        # guarda timestamp
setopt INC_APPEND_HISTORY      # escreve à medida, não só no exit
setopt SHARE_HISTORY           # partilha entre sessões
setopt HIST_IGNORE_ALL_DUPS    # remove duplicados antigos
setopt HIST_IGNORE_SPACE       # ignora comandos começados por espaço
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY             # expande !! antes de correr

# ---- Navegação de diretórios ----
setopt AUTO_CD                 # 'foo' == 'cd foo'
setopt AUTO_PUSHD              # cd empilha (usar 'dirs -v' / 'cd -N')
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# ---- Completion ----
autoload -Uz compinit
_compdump="$XDG_CACHE_HOME/zsh/zcompdump"
mkdir -p "${_compdump:h}"
compinit -d "$_compdump"
autoload -Uz +X bashcompinit && bashcompinit   # para completions estilo bash (gcloud)
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # case-insensitive
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*' use-cache on
unset _compdump

# ---- Módulos (a ordem importa) ----
#   exports    -> env, cores, proxy, gcloud, kube
#   plugins    -> gestor próprio (autosuggest, vi-mode, syntax-highlight, ...)
#   aliases    -> aliases gerais
#   git/kubectl-> aliases migrados do Oh My Zsh
#   functions  -> helpers (field, tempo, explain, ...)
#   bindings   -> keybindings (regista via hook do vi-mode)
#   cheatsheet -> vimfo/tmuxfo/macfo/zfo/keys
#   prompt     -> starship (por último)
for _mod in exports plugins aliases git kubectl functions bindings cheatsheet prompt; do
  source "$ZDOTDIR/${_mod}.zsh"
done
unset _mod

# ---- Overrides por máquina (não versionado; ver local.zsh.example) ----
# Proxy corporativo, gcloud, paths específicos, etc. vivem aqui.
[[ -r "$ZDOTDIR/local.zsh" ]] && source "$ZDOTDIR/local.zsh"

# ---- Splash ----
[[ -o interactive && -z $TMUX ]] && command -v fastfetch >/dev/null && fastfetch

# Created by `pipx` on 2026-07-07 16:02:26
export PATH="$PATH:/Users/goncalo.sousa/.local/bin"
