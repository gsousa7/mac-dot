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
alias gl='git pull'
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
