alias code='vim -n -c "set rnu"'
alias rw='vim -n -c "set rnu" $(find -type f)'
alias push='git add --all && git commit -m "chore: make updates" && git push'

# if ! command -v bat >/dev/null 2>&1; then
	# sudo apt-get update && sudo apt-get install -y bat
	# [ ! -e /usr/local/bin/bat ] && sudo ln -s /usr/bin/batcat /usr/local/bin/bat
# fi

# git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
# sh ~/.vim_runtime/install_basic_vimrc.sh
