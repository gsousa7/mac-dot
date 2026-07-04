# =========================================================
# exports.zsh — variáveis de ambiente
# =========================================================

# ---- Geral ----
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export GREP_COLORS='mt=1;36'

# ---- less com cor ----
export LESS="R --use-color"
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# ---- Cores usadas pelas funções de cheatsheet (cheatsheet.zsh) ----
MAGENTA="\e[35m"
YELLOW="\e[33m"
BLUE="\e[34m"
GREEN="\e[32m"
RESET="\e[0m"
ORANGE="\e[38;5;214m"
RED="\e[31m"
CYAN="\e[36m"


# ---- Kubernetes ----
export KUBECONFIG="$HOME/.kube/config"
