#!/usr/bin/env bash
#
# install.sh — provisionador de máquina (Ubuntu/apt + macOS/brew)
#   ./install.sh -i -n <user> -m <email> -b <main|master>   instalar
#   ./install.sh -u                                          atualizar
#   ./install.sh -i --dry-run                                simular (não altera nada)
#
# Shell alvo: zsh (config frameworkless em ZDOTDIR).
# =========================================================

set -uo pipefail   # sem -e: um instalador tolera falhas parciais e continua

# ---- localização do repo (auto-deteta; sem git obrigatório) ----
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ---- XDG ----
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# ---- backup + log ----
TIMESTAMP="$(date +%Y%m%d_%H%M)"
BACKUP_DIR="$HOME/.dotfiles-backup/$TIMESTAMP"
LOG_FILE="$BACKUP_DIR/install.log"

# =========================================================
# TOGGLES — liga/desliga o que instalar (1 = sim, 0 = não)
# =========================================================
WANT_KUBECTL=1
WANT_KUBECTX=1
WANT_AWSCLI=1
WANT_AZURECLI=1
WANT_TERRAFORM=0
WANT_RUST=1
WANT_ANSIBLE=1
WANT_BREW_ON_LINUX=1
WANT_TLDR=1
WANT_FONTS=1
SET_DEFAULT_SHELL_ZSH=1

# Fonts Nerd a instalar (nome base do nerd-fonts / cask do brew)
NERD_FONTS=(JetBrainsMono Meslo)

DRY_RUN=0

# =========================================================
# Cores + logging
# =========================================================
if [ -t 1 ]; then
  C_G=$'\e[32m'; C_Y=$'\e[33m'; C_R=$'\e[31m'; C_B=$'\e[34m'; C_D=$'\e[2m'; C_0=$'\e[0m'
else
  C_G=; C_Y=; C_R=; C_B=; C_D=; C_0=
fi

log()  { echo "${C_G}[$(date '+%H:%M:%S')] $*${C_0}"; [ -d "$BACKUP_DIR" ] && echo "[$(date '+%F %T')] $*" >>"$LOG_FILE"; }
warn() { echo "${C_Y}[$(date '+%H:%M:%S')] $*${C_0}"; [ -d "$BACKUP_DIR" ] && echo "[$(date '+%F %T')] WARN $*" >>"$LOG_FILE"; }
err()  { echo "${C_R}[$(date '+%H:%M:%S')] $*${C_0}" >&2; [ -d "$BACKUP_DIR" ] && echo "[$(date '+%F %T')] ERR $*" >>"$LOG_FILE"; }
have() { command -v "$1" >/dev/null 2>&1; }

# executa (ou, em dry-run, só mostra)
run() { if [ "$DRY_RUN" -eq 1 ]; then echo "    ${C_D}[dry] $*${C_0}"; else "$@"; fi; }
# executa uma linha de shell (para pipes / curl | sh)
run_sh() { if [ "$DRY_RUN" -eq 1 ]; then echo "    ${C_D}[dry] $1${C_0}"; else bash -c "$1"; fi; }

# =========================================================
# Deteção de SO / gestor de pacotes
# =========================================================
detect_os() {
  case "$(uname -s)" in
    Darwin) OS="macos"; PM="brew" ;;
    Linux)
      OS="linux"
      if   have apt-get; then PM="apt"
      elif have dnf;     then PM="dnf"
      elif have yum;     then PM="yum"
      else err "Sem gestor de pacotes suportado (apt/dnf/yum)."; exit 1; fi
      ;;
    *) err "SO não suportado: $(uname -s)"; exit 1 ;;
  esac
  log "SO: $OS · gestor: $PM"
}

# =========================================================
# Listas de pacotes (curadas)
# =========================================================
# Núcleo comum a apt e brew (mesmo nome nos dois)
PKGS_COMMON=(rsync tcpdump whois nmap mtr lsof htop btop ncdu tree fdupes rename
             file bc jq ripgrep bat git vim tmux zip unzip ffmpeg cowsay lolcat
             zsh shellcheck shfmt make coreutils)

# Só apt (nomes/pacotes específicos de Debian/Ubuntu)
PKGS_APT_ONLY=(telnet traceroute netcat-openbsd atop procps gpg xclip apg
               bash-completion build-essential zlib1g-dev software-properties-common
               python3 python3-pip pipx man-db manpages manpages-dev bash-doc info
               fontconfig fonts-powerline)

# Só brew (o resto vem por brew; pbcopy/nc/traceroute já são nativos no mac)
PKGS_BREW_ONLY=(gnupg python pipx telnet glow eza fastfetch)

# =========================================================
# Pré-requisitos
# =========================================================
install_prereqs() {
  log "Pré-requisitos (curl/wget/git)..."
  case "$PM" in
    apt) run sudo apt-get update -qq; run sudo apt-get install -y curl wget git ;;
    dnf|yum) run sudo "$PM" install -y curl wget git ;;
    brew) : ;;  # tratado em install_homebrew
  esac
}

# =========================================================
# Homebrew (macOS: obrigatório e primeiro; Linux: opcional)
# =========================================================
install_homebrew() {
  if have brew; then log "Homebrew já instalado."; return 0; fi
  if [ "$OS" = "macos" ] || [ "$WANT_BREW_ON_LINUX" -eq 1 ]; then
    log "A instalar Homebrew..."
    run_sh '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    # carregar brew nesta sessão
    if [ "$OS" = "macos" ]; then
      [ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
      [ -x /usr/local/bin/brew ]    && eval "$(/usr/local/bin/brew shellenv)"
    else
      [ -x /home/linuxbrew/.linuxbrew/bin/brew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
  fi
}

# =========================================================
# Pacotes principais
# =========================================================
install_packages() {
  log "A instalar pacotes principais..."

  if [ "$PM" = "apt" ]; then
    run sudo mkdir -p /etc/apt/keyrings

    # repo charm -> glow
    if ! have glow; then
      log "Configurar repositório charm (glow)..."
      run_sh 'curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg'
      run_sh 'echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list >/dev/null'
    fi
    # repo gierens -> eza
    if ! have eza; then
      log "Configurar repositório gierens (eza)..."
      run_sh 'wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg'
      run_sh 'echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list >/dev/null'
      run_sh 'sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list'
    fi

    run sudo apt-get update
    run sudo apt-get install -y "${PKGS_COMMON[@]}" "${PKGS_APT_ONLY[@]}" glow eza
    install_fastfetch_linux
    # bat no Ubuntu chama-se batcat -> symlink para 'bat'
    if have batcat && ! have bat; then
      run mkdir -p "$HOME/.local/bin"
      run ln -sf "$(command -v batcat)" "$HOME/.local/bin/bat"
    fi
    # editor por omissão
    run_sh 'sudo update-alternatives --set editor /usr/bin/vim.basic 2>/dev/null || true'

  elif [ "$PM" = "brew" ]; then
    run brew install "${PKGS_COMMON[@]}" "${PKGS_BREW_ONLY[@]}"

  else # dnf/yum
    run sudo "$PM" install -y epel-release
    run sudo "$PM" install -y "${PKGS_COMMON[@]}" man-db shellcheck
    warn "glow/eza/fastfetch: em $PM instala manualmente ou via brew."
  fi
}

install_fastfetch_linux() {
  have fastfetch && { log "fastfetch já instalado."; return 0; }
  log "A instalar fastfetch (.deb do GitHub)..."
  run_sh 'curl -LJO https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-linux-amd64.deb'
  run_sh 'sudo dpkg -i fastfetch-linux-amd64.deb || sudo apt-get install -f -y'
  run_sh 'rm -f fastfetch-linux-amd64.deb'
}

# =========================================================
# Starship
# =========================================================
install_starship() {
  have starship && { log "Starship já instalado."; return 0; }
  log "A instalar Starship..."
  if [ "$PM" = "brew" ]; then run brew install starship
  else run_sh 'curl -sS https://starship.rs/install.sh | sh -s -- -y'; fi
}

# =========================================================
# Rust / Cargo
# =========================================================
install_rust() {
  [ "$WANT_RUST" -eq 1 ] || return 0
  have cargo && { log "Rust/Cargo já instalados."; return 0; }
  log "A instalar Rust (rustup)..."
  run_sh "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"
}

# =========================================================
# Python extras via pipx (só tldr)
# =========================================================
install_pipx_tools() {
  [ "$WANT_TLDR" -eq 1 ] || return 0
  if ! have pipx; then
    log "A instalar pipx..."
    if [ "$PM" = "brew" ]; then run brew install pipx; else run sudo apt-get install -y pipx; fi
  fi
  run pipx ensurepath
  have tldr || { log "A instalar tldr (pipx)..."; run pipx install tldr; }
}

# =========================================================
# Ansible
# =========================================================
install_ansible() {
  [ "$WANT_ANSIBLE" -eq 1 ] || return 0
  have ansible && { log "Ansible já instalado."; return 0; }
  log "A instalar Ansible..."
  if [ "$PM" = "brew" ]; then run brew install ansible
  elif [ "$PM" = "apt" ]; then run sudo apt-get install -y ansible
  else run sudo "$PM" install -y ansible; fi
  run mkdir -p "$XDG_CONFIG_HOME/ansible"
  [ -f "$DOTFILES_DIR/ansible.cfg" ] && run ln -sfn "$DOTFILES_DIR/ansible.cfg" "$XDG_CONFIG_HOME/ansible/ansible.cfg"
}

# =========================================================
# Cloud CLIs
# =========================================================
install_awscli() {
  [ "$WANT_AWSCLI" -eq 1 ] || return 0
  have aws && { log "AWS CLI já instalado."; return 0; }
  log "A instalar AWS CLI v2..."
  if [ "$PM" = "brew" ]; then
    run brew install awscli
  else
    local arch; arch="$(uname -m)"; [ "$arch" = "arm64" ] && arch="aarch64"
    run_sh "curl -s 'https://awscli.amazonaws.com/awscli-exe-linux-${arch}.zip' -o /tmp/awscliv2.zip"
    run_sh "cd /tmp && unzip -q -o awscliv2.zip && sudo ./aws/install --update && rm -rf aws awscliv2.zip"
  fi
}

install_azurecli() {
  [ "$WANT_AZURECLI" -eq 1 ] || return 0
  have az && { log "Azure CLI já instalado."; return 0; }
  log "A instalar Azure CLI..."
  if [ "$PM" = "brew" ]; then run brew install azure-cli
  else run_sh 'curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash'; fi
}

# =========================================================
# kubectl
# =========================================================
install_kubectl() {
  [ "$WANT_KUBECTL" -eq 1 ] || return 0
  have kubectl && { log "kubectl já instalado."; return 0; }
  log "A instalar kubectl..."
  if [ "$PM" = "brew" ]; then
    run brew install kubectl
  else
    local arch; arch="$(uname -m)"; [ "$arch" = "x86_64" ] && arch="amd64"; [ "$arch" = "aarch64" ] && arch="arm64"
    run_sh "curl -LO \"https://dl.k8s.io/release/\$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/${arch}/kubectl\""
    run mkdir -p "$HOME/.local/bin"
    run chmod +x kubectl
    run mv ./kubectl "$HOME/.local/bin/kubectl"
  fi
}

# =========================================================
# kubectx / kubens
# =========================================================
install_kubectx() {
  [ "$WANT_KUBECTX" -eq 1 ] || return 0
  have kubectx && { log "kubectx já instalado."; return 0; }
  log "A instalar kubectx/kubens..."
  if [ "$PM" = "brew" ]; then
    run brew install kubectx            # traz kubectx E kubens
  elif [ "$PM" = "apt" ]; then
    run sudo apt-get install -y kubectx  # o pacote inclui os dois
  else
    run_sh "sudo git clone --depth=1 https://github.com/ahmetb/kubectx /opt/kubectx"
    run sudo ln -sf /opt/kubectx/kubectx /usr/local/bin/kubectx
    run sudo ln -sf /opt/kubectx/kubens  /usr/local/bin/kubens
  fi
  warn "Nota: kubens precisa de 'list namespaces' (RBAC). Sem isso, usa 'kn' (lista fixa)."
}

# =========================================================
# Terraform (desligado por toggle)
# =========================================================
install_terraform() {
  [ "$WANT_TERRAFORM" -eq 1 ] || return 0
  have terraform && { log "Terraform já instalado."; return 0; }
  log "A instalar Terraform..."
  if [ "$PM" = "brew" ]; then
    run brew tap hashicorp/tap && run brew install hashicorp/tap/terraform
  else
    run_sh 'wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg'
    local codename; codename="$(grep -oP "^VERSION_CODENAME=\K\w+" /etc/os-release)"
    run_sh "echo \"deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com ${codename} main\" | sudo tee /etc/apt/sources.list.d/hashicorp.list >/dev/null"
    run sudo apt-get update && run sudo apt-get install -y terraform
  fi
}

# =========================================================
# Nerd Fonts (conjunto reduzido)
# =========================================================
install_fonts() {
  [ "$WANT_FONTS" -eq 1 ] || return 0
  log "A instalar Nerd Fonts: ${NERD_FONTS[*]}"

  if [ "$PM" = "brew" ]; then
    local casks=()
    for f in "${NERD_FONTS[@]}"; do
      case "$f" in
        JetBrainsMono) casks+=("font-jetbrains-mono-nerd-font") ;;
        Meslo)         casks+=("font-meslo-lg-nerd-font") ;;
        Hack)          casks+=("font-hack-nerd-font") ;;
        FiraCode)      casks+=("font-fira-code-nerd-font") ;;
        *)             casks+=("font-$(echo "$f" | tr '[:upper:]' '[:lower:]')-nerd-font") ;;
      esac
    done
    run brew install --cask "${casks[@]}"
    return 0
  fi

  # Linux
  local ver="3.4.0" dir="/usr/local/share/fonts"
  run sudo mkdir -p "$dir"
  for f in "${NERD_FONTS[@]}"; do
    if find "$dir" -iname "${f//-/}*.ttf" 2>/dev/null | grep -q .; then
      log "$f já instalada."; continue
    fi
    log "A instalar $f Nerd Font..."
    run_sh "wget -q 'https://github.com/ryanoasis/nerd-fonts/releases/download/v${ver}/${f}.zip' -O /tmp/${f}.zip"
    run_sh "sudo unzip -o /tmp/${f}.zip -d '${dir}' >/dev/null && rm -f /tmp/${f}.zip"
  done
  run sudo fc-cache -f
  warn "Se estiveres em WSL, instala as fonts também no Windows a partir de $dir."
}

# =========================================================
# Dotfiles (symlinks robustos: backup + ln -sfn)
# =========================================================
LINKS=(
  "zshenv|$HOME/.zshenv"
  "zsh|$XDG_CONFIG_HOME/zsh"
  "vimrc|$HOME/.vimrc"
  "tmux.conf|$XDG_CONFIG_HOME/tmux/tmux.conf"
  "htoprc|$XDG_CONFIG_HOME/htop/htoprc"
  "glow.yml|$XDG_CONFIG_HOME/glow/glow.yml"
  "fastfetch_config.json|$XDG_CONFIG_HOME/fastfetch/config.jsonc"
  "ssh.sh|$XDG_CONFIG_HOME/tmux/scripts/ssh.sh"
  "weather.sh|$XDG_CONFIG_HOME/tmux/scripts/weather.sh"
)
EXECUTABLES=(ssh.sh weather.sh)

link_dotfiles() {
  log "A criar symlinks dos dotfiles..."
  for f in "${EXECUTABLES[@]}"; do [ -f "$DOTFILES_DIR/$f" ] && run chmod +x "$DOTFILES_DIR/$f"; done

  local entry src dst
  for entry in "${LINKS[@]}"; do
    src="$DOTFILES_DIR/${entry%%|*}"; dst="${entry#*|}"
    if [ ! -e "$src" ]; then warn "falta no repo: ${entry%%|*}"; continue; fi
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then log "ok (já linkado): $dst"; continue; fi
    if [ -e "$dst" ] || [ -L "$dst" ]; then
      run mkdir -p "$BACKUP_DIR"; run mv "$dst" "$BACKUP_DIR/"; warn "backup: $dst"
    fi
    run mkdir -p "$(dirname "$dst")"
    run ln -sfn "$src" "$dst"
    log "link: $dst"
  done
}

# =========================================================
# Shell por omissão -> zsh
# =========================================================
set_default_shell() {
  [ "$SET_DEFAULT_SHELL_ZSH" -eq 1 ] || return 0
  local zsh_bin; zsh_bin="$(command -v zsh)"
  [ -z "$zsh_bin" ] && { warn "zsh não encontrado; não mudei a shell."; return 0; }
  if [ "${SHELL:-}" = "$zsh_bin" ]; then log "zsh já é a shell por omissão."; return 0; fi
  log "A definir zsh como shell por omissão..."
  run_sh "grep -qx '$zsh_bin' /etc/shells || echo '$zsh_bin' | sudo tee -a /etc/shells >/dev/null"
  run chsh -s "$zsh_bin"
}

# =========================================================
# Git config (interativo ou via -n/-m/-b)
# =========================================================
update_gitconfig() {
  log "Configuração do Git..."
  [ -z "${git_user:-}" ]  && read -rp "Git username: " git_user
  [ -z "${git_email:-}" ] && read -rp "Git email: " git_email
  [ -z "${git_branch:-}" ] && read -rp "Branch inicial (main/master): " git_branch
  if [ "$DRY_RUN" -eq 0 ]; then
    git config --global user.name "$git_user"
    git config --global user.email "$git_email"
    git config --global init.defaultBranch "$git_branch"
  fi
  log "Git configurado: $git_user <$git_email> (branch $git_branch)."
  if [ ! -f "$HOME/.ssh/id_ed25519.pub" ] && [ ! -f "$HOME/.ssh/id_rsa.pub" ]; then
    warn "Sem chave SSH. Cria com: ssh-keygen -t ed25519 -C \"$git_email\" e adiciona ao GitHub."
  fi
}

# =========================================================
# vim: vim-plug + plugins
# =========================================================
install_vim() {
  local plug="$HOME/.vim/autoload/plug.vim"
  if [ ! -f "$plug" ]; then
    log "A instalar vim-plug..."
    run_sh "curl -fLo '$plug' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  fi
  run mkdir -p "$HOME/.vim/undodir"

  # Clonar o tema Dracula ANTES do PlugInstall, senão o 'colorscheme dracula'
  # do .vimrc queixa-se de E185 na primeira passagem (o tema ainda não existe).
  local dracula="$HOME/.vim/pack/themes/start/dracula"
  if [ ! -d "$dracula" ]; then
    log "A instalar tema Dracula (vim)..."
    run_sh "git clone --depth=1 https://github.com/dracula/vim.git '$dracula'"
  fi
  if have vim && [ "$DRY_RUN" -eq 0 ]; then
    log "A instalar plugins do vim..."; vim +'PlugInstall --sync' +qa || warn "PlugInstall falhou."
  else
    [ "$DRY_RUN" -eq 1 ] && echo "    ${C_D}[dry] vim +PlugInstall${C_0}"
  fi
}

# =========================================================
# tmux: TPM
# =========================================================
install_tmux() {
  if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    log "A instalar TPM (tmux)..."
    run_sh "git clone https://github.com/tmux-plugins/tpm '$HOME/.tmux/plugins/tpm'"
  else
    log "TPM já instalado."
  fi
  log "No tmux, faz Ctrl-a + I para instalar os plugins."
}

# =========================================================
# Update
# =========================================================
update_everything() {
  log "A atualizar..."
  case "$PM" in
    apt)  run sudo apt-get update && run sudo apt-get upgrade -y ;;
    brew) run brew update && run brew upgrade ;;
    dnf|yum) run sudo "$PM" upgrade -y ;;
  esac
  have pipx && { run pipx upgrade-all; run pipx ensurepath; }
  have rustup && run rustup update
  if [ -d "$DOTFILES_DIR/.git" ]; then run_sh "cd '$DOTFILES_DIR' && git pull --ff-only"; fi
  log "Feito. Reinicia a shell (exec zsh)."
}

# =========================================================
# Main
# =========================================================
usage() {
  cat <<EOF
Uso:
  ./install.sh -i -n <user> -m <email> -b <main|master>   instalar tudo
  ./install.sh -u                                          atualizar
  ./install.sh -i --dry-run                                simular
Opções:
  -i            instalar        -u   atualizar
  -n <user>     git username    -m <email>  git email    -b <main|master>
  --dry-run     não altera nada
  -h            ajuda
EOF
}

action=""; git_user=""; git_email=""; git_branch=""
while [ $# -gt 0 ]; do
  case "$1" in
    -i) action="install"; shift ;;
    -u) action="update"; shift ;;
    -n) git_user="$2"; shift 2 ;;
    -m) git_email="$2"; shift 2 ;;
    -b) git_branch="$2"; shift 2 ;;
    --dry-run) DRY_RUN=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) err "Argumento desconhecido: $1"; usage; exit 1 ;;
  esac
done

# menu se não houver ação
if [ -z "$action" ]; then
  read -rp "(i)nstalar, (u)pdate ou (q)uit? [i/u/q]: " c
  case "$c" in i) action="install" ;; u) action="update" ;; *) echo "A sair."; exit 0 ;; esac
fi

mkdir -p "$BACKUP_DIR"
[ "$DRY_RUN" -eq 1 ] && warn "DRY-RUN — nada será alterado."
detect_os

case "$action" in
  install)
    install_prereqs
    install_homebrew
    install_packages
    install_starship
    install_rust
    install_pipx_tools
    install_ansible
    install_awscli
    install_azurecli
    install_kubectl
    install_kubectx
    install_terraform
    install_fonts
    link_dotfiles
    set_default_shell
    update_gitconfig
    install_vim
    install_tmux
    echo
    log "Concluído. Backups/log em: $BACKUP_DIR"
    log "Abre uma shell nova (exec zsh) — os plugins do zsh clonam-se ao 1º arranque."
    ;;
  update) update_everything ;;
  *) err "Ação inválida."; exit 1 ;;
esac
