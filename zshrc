

# if [ $OSTYPE = 'Mac' ]; then
#   if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# fi

unalias -a
bindkey -e

alias d-clean='docker rm -v $(docker ps -aq -f status=exited)'

alias bashrc='nvim ~/.bashrc && source ~/.bashrc'
alias bash-profile='nvim ~/.bash_profile && source ~/.bash_profile'
alias config='nvim ~/.config'

alias move-branch="git branch --move \`git branch | grep \* | sed 's/\*//'\` "
alias pbedit="pbpaste > ~/tmp/current_buffer && nvim  ~/tmp/current_buffer  && cat ~/tmp/current_buffer | pbcopy"
alias pe="pbedit"
alias e="pbedit"
alias gc="git add --all && git commit"
alias gp="git push \`git remote\` HEAD"
alias gf="git fetch"
alias gm="git branch --all | fzf | xargs git merge"
alias gb="git branch --all"
alias gch="git branch --all | fzf | xargs git checkout"
alias gcp="git add --all && git commit &&  git push \`git remote\` HEAD"
alias gs="git status"
alias reload="source ~/.bashrc"
alias c="reload && clear"
alias rand="openssl rand -base64 16 | colrm 17"

alias sweep-remort-merged-branch="git branch -a  --merged | grep -v \* | grep -v develop | grep -v master | sed -e 's/remotes\/origin\///g' | xargs git push --delete origin"
alias sweep-local-branch='git branch -D `git branch --merged | grep -v \* | xargs`'


stty stop undef
stty start undef

PROMPT='[%T] %c: '