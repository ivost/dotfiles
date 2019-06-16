#!/usr/bin/env bash

#export PS1=${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)
#echo **🔥

export PS1="\W$ "
export HISTCONTROL=erasedups
export HISTSIZE=800
export HISTFILESIZE=800
export HISTIGNORE="pwd:ls:ll:h:a:rm"

#MYIP=$(ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | tail -1 | cut -d: -f2 | awk '{ print $1}')
#export PS1=$MYIP" \W $"

alias a='alias'
alias e='echo'
alias h='history'
alias s='source'
alias c=clear

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# Shortcuts
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/projects"

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
	export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
else # macOS `ls`
	colorflag="-G"
	export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
fi

# List all files colorized in long format
alias l="ls -lF ${colorflag}"

# List all files colorized in long format, excluding . and ..
alias la="ls -lAF ${colorflag}"

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# Always use color output for `ls`
alias ls="command ls ${colorflag}"

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Enable aliases to be sudo’ed
alias sudo='sudo '

# always use unidiff
alias diff='diff -u'x

alias k='kubectl'
alias kc='kubectl create'

alias k9='kill -9'
alias l='ls -1'
alias ll='ls -alhtr'
alias v='vagrant'
alias vs='vagrant status'
alias pssh='ps aux|grep ssh'
alias gign='vi .gitignore'
alias gita='git add -alias '
alias gitb='git branch '
alias gitcl='git clone --recurse-submodules'
alias gitc='git commit -a --no-verify -m '
alias gitck='git checkout'
alias gitckr='git checkout --recurse-submodules --remote'
alias gitl='git pull'
alias gitmr="git merge --strategy-option theirs"
alias gitml="git merge --strategy-option ours"
alias gitlr='git submodule update --recursive --remote'
alias gitsub='git submodule update --init --recursive'
alias gitf='git fetch --recurse-submodules'
alias gitp='git push; git push --tags'
# squash last N commits before push e.g. gsq HEAD~5
alias gsq='git reset --soft'
#alias gitpull='for d in */ ; do  pushd $d;    git pull; popd; done'
alias gits='git status'
alias gitsz='git count-objects -v'
alias gi='gitc wip && git push'
alias gitmu='git submodule update'
alias gitd1='git diff HEAD^ HEAD'
alias gitd2='git diff HEAD^^ HEAD'
alias gitd3='git diff HEAD^^^ HEAD'
alias gitl1w='git log --oneline --since=1.weeks'
alias gitl1m='git log --oneline --since=1.months'
alias gitl3m='git log --oneline --since=3.months'
alias gitll='git log --oneline HEAD^..HEAD'
alias gitll2='git log --oneline HEAD^^..HEAD'
alias gitlog='git log --graph --oneline'
alias gitlogp='git log --pretty="%h - %an, %ar : %s"'
alias gitbis='git bisect start'
alias gitbisr='git bisect reset'
alias gitbisb='git bisect bad'
alias gitbisg='git bisect good'
alias gitsh='git show HEAD'
alias gitca='git commit --amend -m'
alias gitref='git for-each-ref'
alias p=python
alias p3=python3
alias del=rm
alias dir=ls

export PATH=$HOME/tools:/usr/local/bin/:$PATH

# M alias C  O S

alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/Bin/subl'

alias ep='subl ~/.profile; source ~/.profile'
#alias ep='subl ~/.bash_profile; source ~/.bash_profile'
alias erc='subl ~/.bashrc; source ~/.bashrc'
alias ezrc='subl ~/.zshrc; source ~/.zshrc'
alias ea=ep
# port in use? use with :port e.g. pu :8080
alias pu='lsof -i '

alias jailbreak='sudo xattr -r -d com.apple.quarantine'
alias wait='wait-for-it.sh' 

alias dl='docker logs'
alias dk='docker kill'
#alias yoj='yo jhipster'
#alias yoji='yo jhipster:import-jdl'
alias npmi='npm install'

alias d=docker
alias dclr='docker rm `docker ps --no-trunc -alias -q` '
alias dim='docker images|less'
alias dk='docker kill'
alias dps='docker ps'

alias d_c_clean='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -alias -q)'
alias d_c_kill='docker kill $(docker ps -q)'
alias d_clean='dockercleanc || true && dockercleani'
alias d_i_clean='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'
alias dc=docker-compose
alias ddel='docker rmi -f '
alias dex=ssh_docker
alias dh='docker history '
alias di='docker inspect'
alias dim='docker images|less'
alias dk='docker kill'
alias dl='docker logs'

#alias dr='dotnet run'

alias dr='docker run --rm -p8000:8000 -p8001:8001 -p8443:8443 -p8444:8444 '

#export GOROOT=$HOME/go

# this is "regular" go path
#export GOPATH=/Volumes/Ivo/go
#export GO111MODULE=off

# this is go 1.12 source
#export GOPATH=$HOME/go

export GO111MODULE=on

export PATH=$PATH:/usr/local/go/bin
#export PATH=$HOME/go/bin:$GOPATH/bin:$PATH

alias nomod='export GO111MODULE=off'

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

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
alias g='go run main.go'
alias gb='go build -ldflags "-s -w" -o /tmp/t; ls -alh /tmp/t'
alias gw=goweight
alias gmw='go mod why'
alias armgo='CGO_ENABLED=0 GOARCH=arm64 GOOS=linux go build -v -alias -tags netgo -ldflags "-w -extldflags '\''-static'\'' " '
alias xgo='CGO_ENABLED=1 CC=aarch64-buildroot-linux-gnu-gcc GOOS=linux GOARCH=arm64 go build '
alias skms='cd ~/.ssh; cp id_rsa_t.pub id_rsa.pub; cp id_rsa_t id_rsa; '
alias sksd='cd ~/.ssh; cp id_rsa_sd.pub id_rsa.pub; cp id_rsa_sd id_rsa; '
alias ve=virtualenv	
alias eh='sudo vi /etc/hosts'

#export PYTHON_CONFIGURE_OPTS="--enable-framework"
#eval "$(pyenv init -)"
alias pip-req='pip install -r requirements.txt'
alias gmt='go mod tidy'

#echo "docker system prune -f"
#docker system prune -f

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ivos/tools/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/ivos/tools/google-cloud-sdk/completion.bash.inc'; fi

<<"COMMENT"

# !!:$ next to the  command gets argument from previous command
# !^ gets first argument from previous command
# ls -l !cp:2   !cp:2 searches for the previous command in history that starts with cp and takes the second argument of cp
# !cp:2 searches for the previous command in history that starts with cp and takes the second argument of cp
# !cp:$ takes the last argumen

#git checkout --orphan gh-pages
#git bisect run ./test-error.sh
#Doing so automatically runs test-error.sh on each checked-out 
# commit until Git finds the first broken commit. 
# Here, we have provided the scope of the bisect by putting 
# known bad and good commits with the bisect start command, 
# listing the known bad commit first and the known good commit(s) second.


#alias ports='lsof -n -F | python lsofgraph.py | unflatten -l 1 -c 6 | dot -T jpg > /tmp/a.jpg && open /tmp/a.jpg'

#alias gb='go build -ldflags "-s -w" -o /tmp/a; ls -alh /tmp/a'

# git log --author=^ivos --grep=log --all-match

alias ENV=export

ENV KONG_DATABASE=off
ENV KONG_NGINX_DAEMON=off
ENV KONG_DECLARATIVE_CONFIG=${KONG_PREFIX}/kong.yml

# for rust
#export PATH="$HOME/.cargo/bin:$PATH"

# ambiq apollo board / arm-m4
#export PATH=$HOME/tools/gcc-arm-none-eabi-8-2018-q4-major/bin:$PATH
#export AMB_ROOT=$HOME/tools/AmbiqSuite-Rel2.0.0
#export SWROOT=$HOME/tools/AmbiqSuite-Rel2.0.0

#export SERIAL_PORT=/dev/cu.usbserial-1410
#alias cdap='cd $AMB_ROOT/boards/SparkFun_Edge_BSP'

sudo ifconfig lo0 alias 10.200.10.1/24
export DOCKER_HOST_IP=10.200.10.1

cdgh
cd eventuate-tram-examples-customers-and-orders-redis
./verify-docker-host-ip.sh
DOCKER_HOST_IP= 10.200.10.1

Server running on port: 8889
About to make HTTP request to self
Making HTTP request to self vialias url= http://10.200.10.1:8889

#######
#export PATH=$HOME/Library/Python/3.7/bin:$PATH

# JAVA
#export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

# useful redis cli cmd

# redis-cli --stat
# redis-cli --bigkeys
# redis-cli -r 100 -i 1 info | grep used_memory_human:

# export DOCKER_HOST_IP=10.200.10.1

COMMENT

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# The next line updates PATH for the Google Cloud SDK.
test -e "${HOME}/tools/google-cloud-sdk/path.bash.inc" && source "/Users/ivos/tools/google-cloud-sdk/path.bash.inc"

# The next line enables shell command completion for gcloud.
test -e "${HOME}/google-cloud-sdk/completion.bash.inc" && source  "/Users/ivos/tools/google-cloud-sdk/completion.bash.inc"

function iterm2_print_user_vars() {
 iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
}

