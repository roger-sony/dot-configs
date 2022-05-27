# Fig pre block. Keep at the top of this file.
. "$HOME/.fig/shell/zshrc.pre.zsh"
# Fig pre block. Keep at the top of this file.
# # If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

ZSH_DISABLE_COMPFIX=true

PROFILE_STARTUP=true

if [[ "$PROFILE_STARTUP" == true ]]; then
  zmodload zsh/zprof
  PS4=$'%D{%M%S%.} %N:%i> '
  exec 3>&2 2>$HOME/startlog.$$
  setopt xtrace prompt_subst
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZDOTDIR="/"

setopt autocd
setopt autopushd pushdminus pushdsilent pushdtohome pushdignoredups
setopt nohup
setopt globdots
setopt automenu
setopt cdablevars
setopt correct
setopt rmstarsilent
setopt shwordsplit

# Keybindings for autosuggestions plugin
bindkey '^ ' autosuggest-accept
bindkey '^f' autosuggest-accept

# Gray color for autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=247'

# fzf settings. Uses sharkdp/fd for a faster alternative to `find`.
FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git --exclude .cache'
FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'

PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
alias ls="ls --color=always"

# tabtab source for packages
# uninstall by removing these lines
# [[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || truei

if [[ -r "${XDG_CONFIG_HOME:-$HOME/.config}/zi/init.zsh" ]]; then
  source "${XDG_CONFIG_HOME:-$HOME/.config}/zi/init.zsh" && zzinit
#   zi snippet OMZP::brew
#   zi snippet OMZP::git
#   zi snippet OMZP::dotenv
#   zi snippet OMZP::rake
#   zi snippet OMZP::rbenv
#   zi snippet OMZP::fzf
#   zi snippet OMZP::forgit
#   zi snippet OMZP::zoxide
#   zi snippet OMZP::zsh-fnm
#   zi snippet OMZP::docker-compose
#   zi snippet OMZP::fnm
#   zi snippet OMZP::npm
#   zi snippet OMZP::sudo
#   zi snippet OMZP::vscode
#   zi snippet OMZP::wd
#   zi snippet OMZP::zoxide
#   zi snippet OMZP::z
#   zi snippet OMZP::zsh-autosuggestions
#   zi snippet OMZP::common-aliases
fi

zi snippet OMZP::brew
zi snippet OMZP::git
zi snippet OMZP::dotenv
zi snippet OMZP::rake
zi snippet OMZP::rbenv
zi snippet OMZP::fzf
zi snippet OMZP::forgit
zi snippet OMZP::zoxide
zi snippet OMZP::zsh-fnm
zi snippet OMZP::docker-compose
zi snippet OMZP::fnm
zi snippet OMZP::npm
zi snippet OMZP::sudo
zi snippet OMZP::vscode
zi snippet OMZP::wd
zi snippet OMZP::zoxide
zi snippet OMZP::z
zi snippet OMZP::zsh-autosuggestions
zi snippet OMZP::common-aliases
zi snippet OMZP::zsh-syntax-highlighting

zi ice wait lucid reset \
 atclone"[[ -z \${commands[dircolors]} ]] && local P=g
    \${P}sed -i '/DIR/c\DIR 38;5;63;1' LS_COLORS
    \${P}dircolors -b LS_COLORS >! clrs.zsh" \
 atpull'%atclone' pick"clrs.zsh" nocompile'!' \
 atload'zstyle ":completion:*:default" list-colors "${(s.:.)LS_COLORS}";'
zi light trapd00r/LS_COLORS

plugins=(fzf zsh-syntax-highlighting forgit zsh-autosuggestions zsh-fnm)

autoload -U add-zsh-hook

HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
source "$HB_CNF_HANDLER";
fi

# if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
#
#   setopt shwordsplit
#
#   # Keybindings for autosuggestions plugin
#   bindkey '^ ' autosuggest-accept
#   bindkey '^f' autosuggest-accept
#
#   # Gray color for autosuggestions
#   ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=247'
#
#   # fzf settings. Uses sharkdp/fd for a faster alternative to `find`.
#   FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git --exclude .cache'
#   FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
#
#   # Bliss Theme
#   PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
#   MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
#   alias ls="ls --color=always"
#
#   # plugins=(brew fzf zsh-syntax-highlighting forgit zoxide zsh-autosuggestions zsh-fnm)
#
#   # tabtab source for packages
#   # uninstall by removing these lines
#   [[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
#
# fi

alias brewsetta='/usr/local/bin/brew'
alias python='python3'
# alias p ='pnpm'
# alias pa='pnpm add'
# alias pad='pnpm add -D'
# alias pag='pnpm add --global'
# alias pr='pnpm remove'
alias ga='git add .'
alias gc='git commit -m'
alias gs='git status'
alias gf='git fetch'
alias gpm='git pull origin master'
alias gp='git push'
alias gpo='git push origin'

source $ZSH/oh-my-zsh.sh
source $HOME/.nix-profile/etc/profile.d/nix.sh

eval "$(fnm env --use-on-cd)"
eval "$(starship init zsh)"

if [["$PROFILE_STARTUP" == true]]; then
  unsetopt xtrace
  exec 2>&3 3>&-; zprof > ~/zshprofile$(date +'%s')
fi

# Fig post block. Keep at the bottom of this file.
. "$HOME/.fig/shell/zshrc.post.zsh"
