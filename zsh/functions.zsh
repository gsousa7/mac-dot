# =========================================================
# functions.zsh — helpers utilitários
# =========================================================

field() {
    awk -F "${2:- }" "{ print \$${1:-1} }"
}

tempo() {
    curl -s "wttr.in/${1}?format=4"
}

tempof() {
    curl -s "wttr.in/${1}"
}


explain() {
    if [ "$#" -eq 0 ]; then
        while read "cmd?Command: "; do
            curl -Gs "https://www.mankier.com/api/explain/?cols=$(tput cols)" --data-urlencode "q=$cmd"
        done
        echo "Bye!"
    elif [ "$#" -eq 1 ]; then
        curl -Gs "https://www.mankier.com/api/explain/?cols=$(tput cols)" --data-urlencode "q=$1"
    else
        echo "Usage"
        echo "explain                  interactive mode."
        echo "explain 'cmd -o | ...'   one quoted command to explain it."
    fi
}

lintsh() {
  shellcheck "$1"
}

fmtsh() {
  shfmt -i 2 -sr -ci -w "$1"
}

epoch() {
    local num=${1:--1}
    if [ "$num" = "-1" ]; then
        date '+%B %d, %Y %-I:%M:%S %p %Z'
    else
        date -r "$num" '+%B %d, %Y %-I:%M:%S %p %Z'
    fi
}

hl() {
  if [ -p /dev/stdin ]; then
    bat -l conf -p
  else
    "$@" | bat -l conf -p
  fi
}
