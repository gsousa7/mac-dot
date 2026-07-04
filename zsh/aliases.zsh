# =========================================================
# aliases.zsh — aliases gerais
# =========================================================

# ---- eza (ls moderno) ----
alias l='eza --icons --sort=name --group-directories-first --color=auto'
alias ls='eza -a --icons --git --sort=name --group-directories-first --color=auto'
alias ll='eza -lah --icons --git --sort=name --group-directories-first --color=auto'
alias lls='eza -lah --icons --git --sort=size --group-directories-first --color=auto'
alias ld='eza --only-dirs --git --icons --sort=name --color=auto'
alias lf='eza --only-files --git --icons --sort=name --color=auto'
alias lda='eza -lah --only-dirs --git --icons --color=auto'
alias lfa='eza -lah --only-files --git --icons --color=auto'
alias tree='eza -aT --icons --color=auto --sort=name --group-directories-first'
alias ltree='eza -lahT --icons --color=auto --sort=name --group-directories-first --git'
alias l.='eza -lh --icons ../'
alias l..='eza -lh --icons ../../'
alias l...='eza -lh --icons ../../../'
alias lt="eza -lTg --color=auto --icons --sort=Name --group-directories-first --git"
alias lt2="eza -lTg --level=2 --color=auto --icons --sort=Name --group-directories-first --git"
alias lt3="eza -lTg --level=3 --color=auto --icons --sort=Name --group-directories-first --git"
alias lt4="eza -lTg --level=4 --color=auto --icons --sort=Name --group-directories-first --git"
alias lta="eza -lTag --color=auto --icons --sort=Name --group-directories-first --git"
alias lta2="eza -lTag --level=2 --color=auto --icons --sort=Name --group-directories-first --git"
alias lta3="eza -lTag --level=3 --color=auto --icons --sort=Name --group-directories-first --git"
alias lta4="eza -lTag --level=4 --color=auto --icons --sort=Name --group-directories-first --git"
compdef eza=ls   # reaproveita a completion do ls para o eza

# ---- bat (cat moderno) ----
alias cat="bat -p --no-paging --color=always"
alias bats="bat -pn --no-paging"

# ---- grep com cor ----
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ---- data / meteo ----
alias data='echo $(date "+%d/%m/%Y %H:%M:%S")'
alias tempolx='curl wttr.in/Lisboa\?format=4'
alias temposx='curl wttr.in/Seixal\?format=4'
alias tempolxf='curl wttr.in/Lisboa'
alias temposxf='curl wttr.in/Seixal'

# ---- editar / recarregar config (paths novos: ZDOTDIR) ----
alias rz='exec zsh'                             # reinicia a shell (reload limpo)
alias ez='$EDITOR $ZDOTDIR/.zshrc'
alias ea='$EDITOR $ZDOTDIR/aliases.zsh'
alias ex='$EDITOR $ZDOTDIR/exports.zsh'
alias evrc='$EDITOR $HOME/.vimrc'

# ---- navegação ----
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias wdir='cd $HOME/work'
alias gdir='cd $HOME/git'
alias gpdir='cd $HOME/git/personal'
alias gwdir='cd $HOME/git/work'
alias ddir='cd $HOME/git/personal/mac-dotfiles'   # corrigido (era ~/git/mac-dotfiles)
alias zdir='cd $ZDOTDIR'

# ---- editores ----
alias v='vim'
alias svim='sudo vim'

# ---- macOS ----
alias finder='open .'
alias clip='pbcopy'
alias paste='pbpaste'

# ---- tmux ----
alias t='tmux'
alias ta='tmux attach -t'
alias td='tmux detach'
alias tl='tmux list-sessions'
alias tn='tmux new -s'
alias tks='tmux kill-session -t'
alias ts='tmux switch -t'
alias tkss='tmux kill-server'
alias trew='tmux rename-window'
alias tres='tmux rename-session -t'
alias tw='tmux list-windows'
alias tns='tmux new-session -A -s'
alias tslt='tmux select-layout tiled'
