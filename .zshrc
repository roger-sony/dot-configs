# Fig pre block. Keep at the top of this file.
. "$HOME/.fig/shell/zshrc.pre.zsh"

# .env options
ZSH_DISABLE_COMPFIX=true
ZIM_HOME=~/.zim

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

# Download zimfw plugin manager if missing._
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
    https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
    https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

autoload -U add-zsh-hook

HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
  source "$HB_CNF_HANDLER"
fi

# custom aliases
alias gs='git status'
alias gpo='git push origin'
alias gc='git commit -m'
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

alias j='just'

alias brewsetta='/usr/local/bin/brew'
alias python='python3'

source $ZSH/oh-my-zsh.sh
# source $HOME/.nix-profile/etc/profile.d/nix.sh
# Initialize modules.
source ${ZIM_HOME}/init.zsh

eval "$(fnm env --use-on-cd)"
eval "$(starship init zsh)"

# Fig post block. Keep at the bottom of this file.
. "$HOME/.fig/shell/zshrc.post.zsh"
