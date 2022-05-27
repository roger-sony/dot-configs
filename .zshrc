# Fig pre block. Keep at the top of this file.
. "$HOME/.fig/shell/zshrc.pre.zsh"
# Fig pre block. Keep at the top of this file.

ZSH_DISABLE_COMPFIX=true
ZIM_HOME=~/.zim

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

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

# plugins=(fzf zsh-syntax-highlighting forgit zsh-autosuggestions zsh-fnm)

autoload -U add-zsh-hook

HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
  source "$HB_CNF_HANDLER";
fi

alias brewsetta='/usr/local/bin/brew'
alias python='python3'
alias ga='git add .'
alias gc='git commit -m'
alias gs='git status'
alias gf='git fetch'
alias gpm='git pull origin master'
alias gp='git push'
alias gpo='git push origin'

source $ZSH/oh-my-zsh.sh
# source $HOME/.nix-profile/etc/profile.d/nix.sh
# Initialize modules.
source ${ZIM_HOME}/init.zsh

eval "$(fnm env --use-on-cd)"
eval "$(starship init zsh)"

# Fig post block. Keep at the bottom of this file.
. "$HOME/.fig/shell/zshrc.post.zsh"
