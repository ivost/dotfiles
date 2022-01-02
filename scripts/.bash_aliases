#!/usr/bin/env bash

#export PS1=${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)
#set -e

#echo 🔥 ✋ 🛑  💣
### echo v.2022.01.01
#echo 🔥 ✋ 🛑  💣


export PS1="\T \W$ "
export HISTCONTROL=erasedups
export HISTSIZE=10000
export HISTFILESIZE=10000
# dont save commands starting with space 
export HISTIGNORE="[ \t]*:pwd:ls:ll:h:a:rm"
#export HISTIGNORE="rm *:h:a"

#MYIP=$(ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | tail -1 | cut -d: -f2 | awk '{ print $1}')
#export PS1=$MYIP" \W $"


alias a='alias'
alias e='echo'
alias h='history'
alias s='source'
# alias c=clear
alias t=tree
alias gr=egrep
alias del='rm'

#alias ep='subl ~/.profile; source ~/.profile'
#alias ep='subl ~/.bash_profile; source ~/.bash_profile'
#alias erc='subl ~/.bashrc; source ~/.bashrc'
#alias ezrc='subl ~/.zshrc; source ~/.zshrc'

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"
alias cex='chmod +x'

# Shortcuts
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
#alias p="cd ~/projects"

# for locked files on mac
a zap='sudo chflags -R noschg,nohidden'

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	# shellcheck disable=SC2034
	colorflag="--color"
	export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
else # macOS `ls`
	# shellcheck disable=SC2034
	colorflag="-G"
	export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
fi

####################
###  🔥 LS 🔥  ###
####################

# List all files colorized in long format
alias l='ls -lF $colorflag'

# List all files colorized in long format, excluding . and ..
alias lsall='ls -lAF $colorflag'

# List only directories
alias lsdir='ls -lF $colorflag | grep --color=never "^d" '

# Always use color output for `ls`
alias ls='command ls $colorflag'

alias ls1='ls -F1'
alias lst='ls -FLlhtr'
alias ll='ls -Floghtr'
alias lat='ls -FLalhtr'

####################
###  🔥 GIT 🔥  ###
####################

alias clone='git clone'
alias amend='git commit --amend -m'
alias orphan='git checkout --orphan'

alias gita='git add -A '
alias gitb='git branch '
# delete remote branch
alias gitdrb='git push origin --delete'

alias gitc='git commit -a -m '
alias gitconf='git config --list --show-origin'
alias gitck='git checkout'
alias gitp='git push; git push --tags'
alias gitl='git pull'
alias gitls='git ls-files'
alias gitmr="git merge --strategy-option theirs"
alias gitml="git merge --strategy-option ours"
alias gits='git status'
alias gitsq='echo "to squash last N commits - append HEAD~N" && git reset --soft'
alias gitresetDEVELOP='git reset --hard origin/develop'

alias wip='git commit -a -m wip'
alias wipp='git commit -a -m wip && git push'

alias gitlog='git log --graph --decorate --oneline'
alias gitlog='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'

# Enable aliases to be sudo’ed
#alias sudo='sudo '

# always use unidiff
alias diff='diff -u'
alias k9='kill -9'

alias pssh='ps aux|grep ssh'
alias gign='vi .gitignore'

export PATH=/usr/local/bin:$HOME/tools:$PATH
export PATH=$HOME/tools/platform-tools:$PATH
export PATH=$HOME/go/bin:$PATH
export GOPATH=$HOME/go


alias sba='source ~/.bash_aliases'
alias pu='lsof -i '
alias npmi='npm install'

# alias docker='lima nerdctl'

alias d=docker
alias dclr='docker rm $(docker ps -a -f status=exited -q)'
alias dim='docker images'
alias dk='docker kill'
alias dps='docker ps -a'
alias prune='docker system prune -f'
alias dl='docker logs'
alias dk='docker kill'
alias dimd='docker image rm -f'
alias dc=docker-compose

alias eh='sudo vi /etc/hosts'
alias prot='chmod 0400'

function MD() {
  echo creating dir "$1"
  mkdir -p "$1"
  cd "$1" || return
  pwd
}

function LEN() {
  V=$1
  echo length of "$V": ${#V}
}

##########################
###  🔥 FUNCTIONS 🔥  ###
#########################

# OS detection
function is_osx() {
  [[ "$OSTYPE" =~ ^darwin ]] || return 1
}

function is_ubuntu() {
  [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1
}

function scp1() {
  scp $1 root@192.168.1.1:
}

function is_ubuntu_desktop() {
  dpkg -l ubuntu-desktop >/dev/null 2>&1 || return 1
}

function get_os() {
  for os in osx ubuntu ubuntu_desktop; do
    is_$os; [[ $? == "${1:-0}" ]] && echo $os
  done
}

# git branch
function git_br() {
	echo $( (git branch 2> /dev/null) | grep \* | cut -c3-)
}
  
function setup_git() {
  git config --global user.email ivostoy@gmail.com
  git config --global user.name ivo
  git config --global core.editor "subl -n -w"
}

# git rebase remote after push
function rebase() {
  local B=$(git_br)
  local N=$1
  #echo git rebase -i origin/$B~$N $B
  git rebase -i origin/$B~$N $B
}

# git force push
function gitfp() {
  local B
  B=$(git_br)
  git push origin +"$B"
}

# pyclean () {
#     find . -regex '^.*\(__pycache__\|\.py[co]\)$' -delete
# }

export EDITOR=subl
alias inst='sudo apt install'
alias upd='sudo apt update'
alias eba='subl ~/.bash_aliases; source ~/.bash_aliases'

## aliases depending on OS
### MAC
if [[ "$OSTYPE" =~ ^darwin ]]; then 
	alias inst='brew install'
	alias bd='brew doctor'

	function iterm2_print_user_vars() {
	   iterm2_set_user_var gitBranch "$( (git branch 2> /dev/null) | grep '\*' | cut -c3-)"
	}

  # Recursively delete `.DS_Store` files
  alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

  # Empty the Trash on all mounted volumes and the main HDD.
  # Also, clear Apple’s System Logs to improve shell startup speed.
  # Finally, clear download history from quarantine. https://mths.be/bum
  alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

  # Show/hide hidden files in Finder
  alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
  alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

  # Hide/show all desktop icons (useful when presenting)
  alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
  alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
  alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/Bin/subl'
  #alias m=multipass

	#x=$(brew --prefix)/etc/bash_completion
	# shellcheck disable=SC1090
	#[[ -f "$x" ]] && source "$x"
fi
### END MAC

#curl -i -X POST -H "$A" $URL  -d '{"value": "'$L'"}'

# colorizer
[[ -s "/usr/local/etc/grc.bashrc" ]] && source /usr/local/etc/grc.bashrc

# if you have ssh problems
alias sshv='ssh -vvv -o LogLevel=DEBUG3'

#a mb='make extraclean && make api && make generate'
alias mode="stat -f '%A %a %N' "

###############
# Coral board #
###############
# ping bored-kid.local
# 10.0.1.194
#export CORAL=10.0.1.194
#a sh-coral='mdt shell'

alias N='date +''%s'''

# default file creation mask
#umask 0022

# alias mm='make menuconfig'

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

a p=python

export OPENSSL_DIR=/usr/local/opt/openssl
export OPENSSL_ROOT_DIR=/usr/local/opt/openssl

# export OPENSSL_DIR=/usr/local/Cellar/openssl@1.1/1.1.1g
# export OPENSSL_ROOT_DIR=/usr/local/Cellar/openssl@1.1/1.1.1g

#If you need to have openssl first in your PATH run:
#  echo 'export PATH="/usr/local/opt/openssl/bin:$PATH"' >> ~/.profile

export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/Cellar/mosquitto/1.6.12/bin:$PATH"
#alias mqstart='mosquitto -c /usr/local/etc/mosquitto/mosquitto.conf'
alias mqstart='brew services start mosquitto'
alias mqstop='brew services stop mosquitto'
alias mqs='mosquitto_sub -t top'
alias mqp='mosquitto_pub -t top'
alias mqs1='mosquitto_sub -h 192.168.1.1 -t top'

#For compilers to find openssl you may need to set:
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

#For pkg-config to find openssl you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"

# export PI=192.168.1.1
# alias sshj='ssh root@$I'


a sshu='ssh -i "~/.ssh/ivo-keypair-2020.pem" ubuntu@ec2-18-189-20-67.us-east-2.compute.amazonaws.com'
complete -C '/usr/local/bin/aws_completer' aws

a gb='go build  -ldflags "-s -w"; ls -altrh'

a gba='GOOS=linux GOARCH=arm  CGO_ENABLED=0 go  build -ldflags "-s -w" ; ls -altrh'
a gba1='GOOS=linux GOARCH=arm  go  build; ls -altrh'

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# export PATH="$HOME/tools/apache-maven-3.6.3/bin:$PATH"

export PATH="/Users/ivo/.local/bin:$PATH"


if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
  fi
fi

export KE='/Users/ivo/go/src/github.com/kubeedge'
a cdke='cd $KE'

a k='kubectl --insecure-skip-tls-verify'

a kaf='kubectl apply -f'
a kdf='kubectl delete -f'


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


[[ -s /Users/ivo/.autojump/etc/profile.d/autojump.sh ]] && source /Users/ivo/.autojump/etc/profile.d/autojump.sh

# eval "$(register-python-argcomplete pipx)"

a cdg='cd ~/github'
a pi='pip install'
a pir='pip install -r requirements.txt'
a pipu='pip install --upgrade pip'
a ve='python3 -m venv .venv'
a ave='source .venv/bin/activate'

a mk='minikube'
a mke='eval $(minikube docker-env)'
a c=chalice

# install docker in multipass
a std='multipass launch -c 4 -m 6G -d 40G -n docker 20.04 --cloud-init ~/dotfiles/scripts/docker.yaml'

# start docker in multipass instance
a std='multipass start docker'
a mp=multipass
a s-u='ssh ubuntu@docker.local'

# export DOCKER_BUILDKIT=1
export CDK_DEFAULT_ACCOUNT=897440107178
export CDK_DEFAULT_REGION=us-east-1

# export DOCKER_HOST="ssh://ubuntu@docker.local"
# export DOCKER_HOST=192.168.64.7:22
# export DOCKER_HOST=localhost

a d-ctx='docker context create dock --docker "host=ssh://ubuntu@docker.local"'
a d-u='docker context use dock'

export DOCKER_CONTEXT=dock

a bss='brew services start'
a bsp='brew services stop'

a k-s='bss zookeeper; bss kafka'
a k-p='bsp kafka; bsp zookeeper'

# a kaf='docker run --rm -p 2181:2181 -p 3030:3030 -p 8081-8083:8081-8083 -p 9581-9585:9581-9585 -p 9092:9092 -e ADV_HOST=$DOCKER_HOST lensesio/fast-data-dev:latest'
# in vm
# docker run --rm --net=host lensesio/fast-data-dev
# landoop console
# a land='open http://192.168.64.7:3030'

# kafdrop https://github.com/obsidiandynamics/kafdrop
# a kd='java --add-opens=java.base/sun.nio.ch=ALL-UNNAMED -jar target/kafdrop-3.28.0-SNAPSHOT.jar --kafka.brokerConnect=192.168.64.7:9092'

a p-g='openssl rand -base64 7'

# raspberry pi 8GB  pi `
export R4=192.168.7.226
a r4='ssh pi@$R4'

# to remove files from git history/reflogs
# https://rtyley.github.io/bfg-repo-cleaner/
alias bfg='java -jar ~/tools/bfg-1.14.0.jar'

# docker context use dock
# ssh port forwarding / tunnel
# ssh -L local_port:destination_server_ip:remote_port ssh_server_hostname

# kafka cluster created in multipass docker instance
# rpk container start -n 3
# this works both on host (my mac) and guest (ubu/multipass)
# rpk cluster info --brokers 127.0.0.1:45405,127.0.0.1:37999,127.0.0.1:41145
# rpk container stop
# rpk container purge
a k-tun='ssh -L 45405:127.0.0.1:45405 -L 37999:127.0.0.1:37999  -L 41145:127.0.0.1:41145  -C -N -l ubuntu docker.local'


export KB=127.0.0.1:45405

a k-tc='kafka-topics --bootstrap-server $KB --create --topic test --replication-factor 3 --partitions 4'
a k-tl='kafka-topics --bootstrap-server $KB --list'
a k-pr='kafka-console-producer --broker-list $KB --topic test --property "parse.key=true" --property "key.separator=:"'
a k-con='kafka-console-consumer --bootstrap-server $KB --topic test'
a k-d='cd ~/github/kafdrop; java -jar target/kafdrop-3.28.0-SNAPSHOT.jar --kafka.brokerConnect=$KB'

