# .env options
# ZSH_DISABLE_COMPFIX=true

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# setopt configs
setopt autocd
setopt autopushd pushdminus pushdsilent pushdtohome pushdignoredups
setopt nohup
setopt globdots
setopt automenu
setopt cdablevars
setopt correct
setopt rmstarsilent
setopt shwordsplit

autoload -U add-zsh-hook

# custom aliases

## git
alias gs='git status'
alias gpo='git push origin'
alias gc='git commit -m'
alias ws='webstorm'
alias gagc='git add .; git commit -a -m '
alias gui='git submodule update --init --recursive'
alias gau='git add -u .'
alias gf='git fetch'
alias gbd='git branch -D '
alias gbm='git branch -m '
alias gcb='git checkout -b '
alias gauc='git add -u ; git commit -m '
alias gb='git branch '
alias gitls='git ls-tree --full-tree -r HEAD'
alias gpomaster='git pull origin master'
alias gpomain='git pull origin main'
alias grc='git rebase --continue'
alias grhh='git reset --hard HEAD'

## nix
alias nix-env-search='nix-env -qaP'
alias nix-env-install='nix-env -iA'
alias nix-env-update-all="nix-channel --update nixpkgs && nix-env -u '*'"
alias nix-up='nix-env -u'
alias nix-gc='nix-collect-garbage -d'

## other
alias j='just'
alias brewsetta='/usr/local/bin/brew'
alias python='python3'
alias ws='webstorm'
alias rf='rm -rf'

## sai
alias sai-proxy="source ../../../venv/bin/activate && just proxy"
alias sai-proxy-run="source ../../../venv/bin/activate && just proxy-run"

source $ZSH/oh-my-zsh.sh
source ~/.bash_profile
source ~/.profile

# Initialize modules.
source ${ZIM_HOME}/init.zsh

eval "$(fnm env --use-on-cd)"
eval "$(starship init zsh)"

export EDITOR=vim

# pnpm
export PNPM_HOME="/Users/rogeryee/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
