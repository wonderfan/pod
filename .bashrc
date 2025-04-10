alias code='vim -n -c "set rnu"'
alias push='git add --all && git commit -m "chore: make updates" && git push'
(! command -v bat >/dev/null 2>&1) && sudo apt-get update && sudo apt-get install bat && sudo ln -s /usr/bin/batcat /usr/local/bin/bat
