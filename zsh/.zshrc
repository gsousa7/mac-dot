# =========================================================
# .zshrc — orquestrador
# ZDOTDIR = ~/.config/zsh  (symlink -> mac-dotfiles/zsh)
# =========================================================

ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"

# ---- Recuperar fpath padrão se herdado incorretamente do VS Code / subshells ----
# Quando o FPATH é exportado (e.g. pelo Homebrew), o Zsh pode ignorar a inicialização
# dos caminhos de funções padrão do sistema (como compinit, is-at-least, etc.).
local -a _compinit_test; _compinit_test=( ${^fpath}/compinit(N) )
if (( ${#_compinit_test} == 0 )); then
  local -a _default_fpath
  _default_fpath=( ${(f)"$(echo "print -l \$fpath" | env -u FPATH zsh -f 2>/dev/null)"} )
  if (( ${#_default_fpath} > 0 )); then
    fpath=( $fpath $_default_fpath )
  fi
  unset _default_fpath
fi
unset _compinit_test

# ---- Homebrew (Apple Silicon) — cedo, para o resto ter o PATH ----
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  typeset +x FPATH # Evita que o FPATH seja exportado e quebre subshells / VS Code
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
_compdump="$XDG_CACHE_HOME/zsh/zcompdump"
mkdir -p "${_compdump:h}"

# Instala e adiciona zsh-completions ao fpath se não estiver instalado
ZPLUGINDIR="${ZDOTDIR:-$HOME/.config/zsh}/plugins"
if [[ ! -d "$ZPLUGINDIR/zsh-completions" ]]; then
  echo "Installing zsh-completions..."
  git clone --depth=1 "https://github.com/zsh-users/zsh-completions" "$ZPLUGINDIR/zsh-completions"
fi
fpath=("$ZPLUGINDIR/zsh-completions/src" $fpath)

# Garantir fpaths do Homebrew antes de inicializar o compinit
[[ -d /opt/homebrew/share/zsh/site-functions ]] && fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
[[ -d /usr/local/share/zsh/site-functions ]] && fpath=(/usr/local/share/zsh/site-functions $fpath)

autoload -Uz compinit

# Carrega compinit otimizado (usa cache se tiver menos de 24 horas)
if [[ -s "$_compdump" ]]; then
  local _mtime
  if [[ "$OSTYPE" == "darwin"* ]]; then
    _mtime=$(stat -f '%m' "$_compdump" 2>/dev/null)
  else
    _mtime=$(stat -c '%Y' "$_compdump" 2>/dev/null)
  fi
  
  if [[ -n "$_mtime" ]] && (( $(date +%s) - _mtime < 86400 )); then
    compinit -C -d "$_compdump"
  else
    compinit -d "$_compdump"
  fi
else
  compinit -d "$_compdump"
fi

autoload -Uz +X bashcompinit && bashcompinit   # para completions estilo bash (gcloud)

# ---- Configuração do Menu de Autocomplete (zstyle) ----
zstyle ':completion:*' menu select
# Case-insensitive e correspondência parcial (e.g. f.b -> foo.bar)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*' use-cache on

# Cores e Visual Moderno
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"     # Se LS_COLORS estiver definido, usa-o
zstyle ':completion:*' group-name ''                         # Agrupa por categoria
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple}%d%f'
zstyle ':completion:*:warnings' format '%F{red}Sem correspondências para:%f %d'

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
