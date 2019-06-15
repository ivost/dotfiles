
#export PS1=${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)
#echo **🔥


export PS1="\W$ "

#MYIP=$(ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | tail -1 | cut -d: -f2 | awk '{ print $1}')
#export PS1=$MYIP" \W $"

alias a='alias'
alias e='echo'
alias h='history'
alias s='source'
alias c=clear

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
a p=python
alias gita='git add -A '
alias gitb='git branch '
alias gitcl='git clone --recurse-submodules'
alias gitc='git commit -a --no-verify -m '

alias gitck='git checkout'
alias gitckr='git checkout --recurse-submodules --remote'

alias gitl='git pull'
alias gitlr='git submodule update --recursive --remote'

alias gitsub='git submodule update --init --recursive'

alias gitf='git fetch --recurse-submodules'
alias gitp='git push; git push --tags'
#alias gitpull='for d in */ ; do  pushd $d;    git pull; popd; done'
alias gits='git status'
alias gitsz='git count-objects -v'

a gi='gitc wip && git push'

a gitmu='git submodule update'
a gitd1='git diff HEAD^ HEAD'
a gitd2='git diff HEAD^^ HEAD'
a gitd3='git diff HEAD^^^ HEAD'
a gitl1w='git log --oneline --since=1.weeks'
a gitl1m='git log --oneline --since=1.months'
a gitl3m='git log --oneline --since=3.months'
a gitll='git log --oneline HEAD^..HEAD'
a gitll2='git log --oneline HEAD^^..HEAD'
a gitlog='git log --graph --oneline'
a gitlogp='git log --pretty="%h - %an, %ar : %s"'
a gitbis='git bisect start'
a gitbisr='git bisect reset'
a gitbisb='git bisect bad'
a gitbisg='git bisect good'
a gitsh='git show HEAD'
a gitca='git commit --amend -m'
a gitref='git for-each-ref'

export HISTCONTROL=erasedups
export HISTSIZE=800
export HISTFILESIZE=800
export HISTIGNORE="pwd:ls:ll:h:a:rm"

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


# git log --author=^ivos --grep=log --all-match

a p3=python3

a del=rm
a dir=ls

export PATH=$HOME/tools:/usr/local/bin/:$PATH

# M A C  O S

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

# squash last N commits before push e.g. gsq HEAD~5
alias gsq='git reset --soft'

alias d=docker
alias dclr='docker rm `docker ps --no-trunc -a -q` '
alias dim='docker images|less'
alias dk='docker kill'
alias dps='docker ps'

alias d_c_clean='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'
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

a dr='docker run --rm -p8000:8000 -p8001:8001 -p8443:8443 -p8444:8444 '

#export GOROOT=$HOME/go

# this is "regular" go path
#export GOPATH=/Volumes/Ivo/go
#export GO111MODULE=off

# this is go 1.12 source
#export GOPATH=$HOME/go

export GO111MODULE=on

export PATH=$PATH:/usr/local/go/bin
#export PATH=$HOME/go/bin:$GOPATH/bin:$PATH

a nomod='export GO111MODULE=off'


alias g='go run main.go'

alias gb='go build -ldflags "-s -w" -o /tmp/t; ls -alh /tmp/t'
alias gw=goweight
alias gmw='go mod why'

alias armgo='CGO_ENABLED=0 GOARCH=arm64 GOOS=linux go build -v -a -tags netgo -ldflags "-w -extldflags '\''-static'\'' " '
alias xgo='CGO_ENABLED=1 CC=aarch64-buildroot-linux-gnu-gcc GOOS=linux GOARCH=arm64 go build '

alias skms='cd ~/.ssh; cp id_rsa_t.pub id_rsa.pub; cp id_rsa_t id_rsa; '
alias sksd='cd ~/.ssh; cp id_rsa_sd.pub id_rsa.pub; cp id_rsa_sd id_rsa; '
alias ve=virtualenv


function iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
}

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# The next line updates PATH for the Google Cloud SDK.
test -e "${HOME}/tools/google-cloud-sdk/path.bash.inc" && source "/Users/ivos/tools/google-cloud-sdk/path.bash.inc"

# The next line enables shell command completion for gcloud.
test -e "${HOME}/google-cloud-sdk/completion.bash.inc" && source  "/Users/ivos/tools/google-cloud-sdk/completion.bash.inc"
	
alias eh='sudo vi /etc/hosts'

#export PYTHON_CONFIGURE_OPTS="--enable-framework"

#eval "$(pyenv init -)"

a pip-req='pip install -r requirements.txt'

#a ports='lsof -n -F | python lsofgraph.py | unflatten -l 1 -c 6 | dot -T jpg > /tmp/a.jpg && open /tmp/a.jpg'

#a gb='go build -ldflags "-s -w" -o /tmp/a; ls -alh /tmp/a'
a gmt='go mod tidy'

#######
#export PATH=$HOME/Library/Python/3.7/bin:$PATH

# JAVA
#export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

# useful redis cli cmd

# redis-cli --stat
# redis-cli --bigkeys
# redis-cli -r 100 -i 1 info | grep used_memory_human:

# export DOCKER_HOST_IP=10.200.10.1

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
#a cdap='cd $AMB_ROOT/boards/SparkFun_Edge_BSP'

echo "docker system prune -f"
docker system prune -f

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ivos/tools/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/ivos/tools/google-cloud-sdk/completion.bash.inc'; fi

<<"COMMENT"
sudo ifconfig lo0 alias 10.200.10.1/24
export DOCKER_HOST_IP=10.200.10.1

cdgh
cd eventuate-tram-examples-customers-and-orders-redis
./verify-docker-host-ip.sh
DOCKER_HOST_IP= 10.200.10.1

Server running on port: 8889
About to make HTTP request to self
Making HTTP request to self via url= http://10.200.10.1:8889
COMMENT

function iterm2_print_user_vars() {
 iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
}

