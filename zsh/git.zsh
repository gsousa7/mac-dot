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

# gpull — git pull que antes simula o merge (git merge-tree, em memória) e
# pede confirmação se houver conflitos. Requer git >= 2.38.
function gpull() {
  if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    print "\e[31mErro: Não estás num repositório Git!\e[0m"
    return 1
  fi

  local upstream
  upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)

  # Sem upstream: git pull normal e deixa o Git decidir/avisar
  if [[ -z "$upstream" ]]; then
    print "\e[33mNenhum upstream configurado para esta branch. A tentar git pull normal...\e[0m"
    git pull "$@"
    return $?
  fi

  print "\e[34m[1/3] A atualizar referências remotas (git fetch)...\e[0m"
  git fetch --quiet || return

  if [[ -z "$(git rev-list HEAD..@{u} 2>/dev/null)" ]]; then
    print "\e[32m✅ Já está atualizado com $upstream.\e[0m"
    return 0
  fi

  print "\e[34m[2/3] A verificar conflitos potenciais com $upstream...\e[0m"

  # merge-tree só compara commits (HEAD vs upstream). Output com --name-only:
  # 1ª linha = OID da tree resultante, restantes = ficheiros em conflito.
  local out exit_code
  out=$(git merge-tree --write-tree --name-only --no-messages HEAD @{u} 2>/dev/null)
  exit_code=$?
  local -a lines=( ${(f)out} ) conflicts
  (( exit_code == 1 )) && conflicts=( ${lines[2,-1]} )

  # Alterações locais não commitadas em ficheiros que o upstream também muda
  # (o git pull recusa-se a avançar nesses casos).
  local -a changed dirty overlap
  changed=( ${(f)"$(git diff --name-only HEAD...@{u})"} )
  dirty=( ${(f)"$(git diff --name-only HEAD)"} )
  overlap=( ${changed:*dirty} )

  if (( exit_code > 1 )); then
    print "\e[33mNão foi possível simular o merge (git < 2.38?). A avançar sem verificação.\e[0m"
  elif (( exit_code == 1 || ${#overlap} )); then
    if (( ${#conflicts} )); then
      print "\e[31m⚠️  ALERTA: Foram detetados conflitos de merge!\e[0m"
      print "\e[33mFicheiros que vão entrar em conflito:\e[0m"
      print -l -- "  - "${^conflicts}
    fi
    if (( ${#overlap} )); then
      print "\e[31m⚠️  Alterações locais não commitadas em ficheiros alterados no remoto:\e[0m"
      print -l -- "  - "${^overlap}
      print "\e[33m(o git pull vai recusar; faz commit/stash antes, ou usa gupa)\e[0m"
    fi
    print ""
    local response
    read -r "response?$(print '\e[35mQueres continuar com o git pull mesmo assim? (y/N): \e[0m')"
    if [[ "$response" != [Yy] ]]; then
      print "\e[31mPull abortado. Nenhum ficheiro foi alterado.\e[0m"
      return 1
    fi
  else
    print "\e[32m✅ Sem conflitos detetados! Seguro avançar.\e[0m"
  fi

  print "\e[34m[3/3] A efetuar git pull...\e[0m"
  git pull "$@"
}

# gpall — corre gpull em cada repositório git imediatamente abaixo do diretório atual
function gpall() {
  local dir found_repos=0

  for dir in *(N/); do
    # -e e não -d: em worktrees/submódulos o .git é um ficheiro
    [[ -e "$dir/.git" ]] || continue
    found_repos=1
    print "\n\e[36m========== Repositório: ${dir} ==========\e[0m"
    ( cd "$dir" && gpull "$@" )
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
