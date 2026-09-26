# =========================================================
# git.zsh — aliases do plugin 'git' do Oh My Zsh (migrados)
# Mantém o muscle memory (gst, gco, gcb, gp, ...) sem framework.
# Documentados em: zfo git
# =========================================================

# ---- funções auxiliares (usadas por vários aliases) ----
function current_branch() {
  git symbolic-ref --quiet HEAD 2>/dev/null | sed 's|^refs/heads/||' \
    || git rev-parse --short HEAD 2>/dev/null || return
}

function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,master}; do
    if command git show-ref -q --verify "$ref"; then
      echo "${ref:t}"
      return 0
    fi
  done
  echo master
  return 1
}

function grename() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: grename old_branch new_branch"
    return 1
  fi
  git branch -m "$1" "$2"
  if git push origin :"$1"; then
    git push --set-upstream origin "$2"
  fi
}

function gpull() {
  # 1. Garantir que estamos num repositório git
  if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    print "\e[31mErro: Não estás num repositório Git!\e[0m"
    return 1
  fi

  # 2. Obter o upstream (remoto associado)
  local upstream
  upstream=$(git rev-parse --abbrev-ref @{u} 2>/dev/null)

  # Se não houver upstream configurado, faz git pull normal e deixa o Git decidir/avisar
  if [[ -z "$upstream" ]]; then
    print "\e[33mNenhum upstream configurado para esta branch. A tentar git pull normal...\e[0m"
    git pull "$@"
    return $?
  fi

  print "\e[34m[1/3] A atualizar referências remotas (git fetch)...\e[0m"
  # Fetch silencioso para o upstream correspondente
  local remote="${upstream%%/*}"
  local branch="${upstream#*/}"
  git fetch "$remote" "$branch" --quiet

  print "\e[34m[2/3] A verificar conflitos potenciais com $upstream...\e[0m"
  
  # Usar git merge-tree para simular o merge inteiramente em memória (seguro com uncommitted changes)
  local conflicts
  conflicts=$(git merge-tree --name-only HEAD "$upstream" 2>/dev/null)
  local exit_code=$?

  # Se o exit_code for 1 ou se houver ficheiros em conflito
  if (( exit_code == 1 )) && [[ -n "$conflicts" ]]; then
    print "\e[31m⚠️  ALERTA: Foram detetados conflitos de merge!\e[0m"
    print "\e[33mFicheiros que vão entrar em conflito:\e[0m"
    print "$conflicts" | sed 's/^/  - /'
    print ""
    echo -n -e "\e[35mQueres continuar com o git pull mesmo assim? (y/N): \e[0m"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
      print "\e[34m[3/3] A efetuar git pull...\e[0m"
      git pull "$@"
    else
      print "\e[31mPull abortado. Nenhum ficheiro foi alterado.\e[0m"
      return 1
    fi
  else
    print "\e[32m✅ Sem conflitos detetados! Seguro avançar.\e[0m"
    print "\e[34m[3/3] A efetuar git pull...\e[0m"
    git pull "$@"
  fi
}

function gpall() {
  local found_repos=0

  # Iterar por todas as pastas no diretório atual
  for dir in */; do
    # Remover a barra final do nome da pasta para apresentação
    local repo_name="${dir%/}"

    # Verificar se a subpasta é um repositório git (tem uma pasta .git ou é worktree)
    if [[ -d "$dir/.git" ]] || git -C "$dir" rev-parse --is-inside-work-tree &>/dev/null; then
      found_repos=1
      print -P "\n\e[36m========== Repositório: %F{cyan}${repo_name}%f ==========\e[0m"
      
      # Entrar na pasta do repositório, executar gpull, e voltar para a pasta original via subshell
      (
        cd "$dir" || return
        gpull "$@"
      )
    fi
  done

  if (( found_repos == 0 )); then
    print "\e[33mNenhum subrepositório Git encontrado no diretório atual.\e[0m"
  fi
}

# ---- base ----
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gst='git status'
alias gss='git status --short'
alias gsb='git status --short --branch'

# ---- commit ----
alias gc='git commit --verbose'
alias 'gc!'='git commit --verbose --amend'
alias 'gcn!'='git commit --verbose --no-edit --amend'
alias gcmsg='git commit --message'
alias gca='git commit --verbose --all'
alias 'gca!'='git commit --verbose --all --amend'
alias gcam='git commit --all --message'

# ---- branch & checkout ----
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'
alias gbnm='git branch --no-merged'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git checkout $(git_main_branch)'
alias gcd='git checkout develop'
alias gsw='git switch'
alias gswc='git switch --create'

# ---- push & pull ----
alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease'
alias 'gpf!'='git push --force'
alias gpsup='git push --set-upstream origin $(current_branch)'
alias gl='gpull'
alias gpall='gpall'
alias ggl='git pull origin $(current_branch)'
alias ggp='git push origin $(current_branch)'
alias gf='git fetch'
alias gfa='git fetch --all --prune --jobs=10'
alias gfo='git fetch origin'
alias gup='git pull --rebase'
alias gupa='git pull --rebase --autostash'

# ---- log ----
alias glog='git log --oneline --decorate --graph'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all"
alias glols="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat"
alias glo='git log --oneline --decorate'
alias glg='git log --stat'
alias glgp='git log --stat --patch'

# ---- diff ----
alias gd='git diff'
alias gdca='git diff --cached'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdw='git diff --word-diff'

# ---- stash ----
alias gsta='git stash push'
alias gstaa='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --patch'
alias gstc='git stash clear'

# ---- merge & rebase ----
alias gm='git merge'
alias gma='git merge --abort'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'
alias grbm='git rebase $(git_main_branch)'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

# ---- remote ----
alias gr='git remote'
alias grv='git remote --verbose'
alias gra='git remote add'
alias grrm='git remote remove'
alias grmv='git remote rename'
alias grset='git remote set-url'

# ---- reset & clean ----
alias grh='git reset'
alias grhh='git reset --hard'
alias grhs='git reset --soft'
alias gpristine='git reset --hard && git clean --force -dfx'
alias gclean='git clean --interactive -d'

# ---- tags ----
alias gts='git tag --sign'
alias gtv='git tag | sort -V'

# ---- worktree ----
alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtls='git worktree list'
alias gwtmv='git worktree move'
alias gwtrm='git worktree remove'

# ---- WIP ----
alias gwip='git add -A; git rm $(git ls-files --deleted) 2>/dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q -- "--wip--" && git reset HEAD~1'
