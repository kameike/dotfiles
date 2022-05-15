

# if [ $OSTYPE = 'Mac' ]; then
#   if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# fi

unalias -a
bindkey -e

alias d-clean='docker rm -v $(docker ps -aq -f status=exited)'

alias move-branch="git branch --move \`git branch | grep \* | sed 's/\*//'\` "
alias pbedit="pbpaste > ~/tmp/current_buffer && nvim  ~/tmp/current_buffer  && cat ~/tmp/current_buffer | pbcopy"
alias pe="pbedit"
alias gc="git add --all && git commit"
alias gp="git push \`git remote\` HEAD"
alias gf="git fetch"
alias gm="git branch --all | fzf | xargs git merge"
alias gb="git branch --all"
alias gch="git branch --all | fzf | xargs git checkout"
alias gcp="git add --all && git commit &&  git push \`git remote\` HEAD"
alias gs="git status"
alias c="clear"
alias go="go1.18rc1"
alias syncchama="ssh min /home/kei/dev/chamasoft/prototype/server/scripts/deploylocal.sh"

alias addpackage="nvim ~/dotfiles/packages.toml && sacoche ~/dotfiles/packages.toml"

alias sweep-remort-merged-branch="git branch -a  --merged | grep -v \* | grep -v develop | grep -v master | sed -e 's/remotes\/origin\///g' | xargs git push --delete origin"
alias sweep-local-branch='git fetch --prune && git branch -D `git branch --merged | grep -v \* | xargs`'


stty stop undef
stty start undef

PROMPT="[%T]`echo $CPUARC` %c: "
export PATH="/usr/local/opt/ruby/bin:$PATH"
