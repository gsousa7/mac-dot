# =========================================================
# kubectl.zsh — aliases (workflow ArgoCD / maioritariamente read-only)
# O ArgoCD é dono do estado; aqui só inspecionamos. Verbos que mutam
# estado (apply/edit/delete/scale/rollout) ficam DE FORA de propósito.
# Documentado em: zfo kubectl
# =========================================================

# Só ativa se o kubectl existir
if ! command -v kubectl >/dev/null 2>&1; then
  return 0
fi

# ---- completion (kubectl + alias k) ----
source <(kubectl completion zsh)
compdef k=kubectl 2>/dev/null

# ---- core ----
alias k='kubectl'

# ---- pods ----
alias kgp='kubectl get pods'
alias kgpl='kgp -l'
alias kgpn='kgp -n'
alias kgpsl='kubectl get pods --show-labels'
alias kgpw='kgp --watch'
alias kgpwide='kgp -o wide'
alias kdp='kubectl describe pods'      # events: ImagePull, CrashLoop, Pending
alias keti='kubectl exec -t -i'        # shell dentro do pod
alias kpf='kubectl port-forward'       # bater no pod/serviço localmente

# ---- deployments (a tua unidade de trabalho) ----
alias kgd='kubectl get deployment'
alias kgdwide='kgd -o wide'
alias kdd='kubectl describe deployment'
alias kgrs='kubectl get replicaset'    # rollout ativa vs antiga
alias krh='kubectl rollout history'    # histórico (não muta nada)

# ---- rede / contexto (read-only) ----
alias kgs='kubectl get svc'
alias kgi='kubectl get ingress'

# ---- events ----
alias kge="kubectl get events --sort-by='.lastTimestamp'"
alias kgew="kubectl get events --watch --sort-by='.lastTimestamp'"

# ---- logs ----
alias kl='kubectl logs'
alias klf='kubectl logs -f'

# ---- wrappers de output colorido (precisam de jq/fx/yh) ----
alias kj="kubectl get -o json | jq"
alias kjx="kubectl get -o json | fx"
alias ky="kubectl get -o yaml | yh"

# ---- contexto (kubectx: lê o kubeconfig LOCAL, funciona sem RBAC) ----
alias kx="kubectx"

# ---- namespaces ----
# O teu user não tem 'list namespaces' (e o kubens precisa disso).
# Logo: lista fixa aqui + switch LOCAL (não precisa de permissão nenhuma).
# Edita KNOWN_NS com os teus namespaces reais (fonte: argocd app list).
KNOWN_NS=(argocd default kube-system)

knls() { printf '%s\n' "${KNOWN_NS[@]}"; }   # listar os conhecidos

kn() {                                        # trocar de namespace no contexto atual
  local ns="${1:-}"
  if [ -z "$ns" ]; then
    PS3="namespace> "
    select ns in "${KNOWN_NS[@]}"; do [ -n "$ns" ] && break; done
  fi
  [ -z "$ns" ] && return 1
  kubectl config set-context --current --namespace="$ns" && echo "→ namespace: $ns"
}
