# .env options
# ZSH_DISABLE_COMPFIX=true
export PATH="/usr/local/bin:$PATH"
export FZF_DEFAULT_OPTS='--color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD'
export PATH=$PATH:/Users/rogeryee/.spicetify

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# themes

# catppuccin
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

export LS_COLORS="$(vivid generate snazzy)"

# setopt configs
setopt autocd
setopt autopushd pushdminus pushdsilent pushdtohome pushdignoredups
setopt nohup
setopt automenu
setopt cdablevars
setopt correct
setopt rmstarsilent
setopt shwordsplit

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# custom aliases

# git
alias gl='git log'
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

# exa
alias ls='ls -l -h -B'

gsquashmaster() {
  git checkout master && git branch -m $1 $1-FAT && git checkout -b $1 && git
  merge --squash $1-FAT
}
# 1. git checkout master
#   - checks out to master
# 2. rename old branch to X-FAT
# 3. checkout to new branch X
# 4. squash and merge the old one (X-FAT) onto new (X)

# Then commit and push

gsquashmain() { git checkout main && git branch -m $1 $1-FAT && git checkout -b $1 && git merge --squash $1-FAT; }

gsquashonto() { git checkout $2 && git branch -m $1 $1-FAT && git checkout -b $1 && git merge --squash $1-FAT; }

# nix
alias nix-env-search='nix-env -qaP'
alias nix-env-install='nix-env -iA'
alias nix-env-update-all="nix-channel --update nixpkgs && nix-env -u '*'"
alias nix-up='nix-env -u'
alias nix-gc='nix-collect-garbage -d'

# other
alias j='just'
alias brewsetta='/usr/local/bin/brew'
alias brew='/opt/homebrew/bin/brew'
alias python='python3'
alias ws='webstorm'
alias rf='rm -rf'

# npm
alias lpd='--legacy-peer-deps'

# pnpm
alias pnpx='pnpm dlx'

# system
alias ip="ipconfig getifaddr en0"

# sai
alias sai-proxy="source ../../../venv/bin/activate && just proxy"
alias sai-proxy-run="source ../../../venv/bin/activate && just proxy-run"

# <<< Zi zsh plugin manager >>>
# sh -c "$(curl -fsSL git.io/get-zi)" -- -i skip -b main

typeset -A ZI
ZI[BIN_DIR]="${HOME}/.zi/bin"
source "${ZI[BIN_DIR]}/zi.zsh"

if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod go-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

#< Zi zsh plugin manager

#  *** Rust Annexes ***
# RA: Rust and ogham/exa
zi ice rustup cargo'!exa -> ls' id-as'exa' as'program' nocompile
zi load z-shell/0

# RA: Peltoche/lsd
zi ice rustup cargo'!lsd' id-as'lsd' as'program' nocompile
zi load z-shell/0

# *** Completions ***
#
# fzf-tab
# COMP: Aloxaf/fzf-tab
zi ice lucid wait has'fzf'
zi light Aloxaf/fzf-tab

# ripgrep
# COMP: BurntSushi/ripgrep/rg
zi ice lucid wait as'completion' blockf has'rg'
zi snippet https://github.com/BurntSushi/ripgrep/blob/master/complete/_rg

# git
# COMP: git/git
#zi ice lucid wait as'completion' blockf mv'git-completion.zsh -> _git'
#zi snippet https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh

zi ice lucid wait as'completion' blockf mv'git-completion.zsh -> _git'
zi snippet https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh

# git completions
#zi ice lucid wait as'completion' blockf mv'git-completion.zsh -> _git'
#zi snippet https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh

# zsh-completions
# COMP: zsh-users/zsh-completions
# zi ice lucid wait as'completion'
# zi light zsh-users/zsh-completions

# cargo
zi ice lucid wait as'completion' blockf has'cargo'
zi snippet https://github.com/rust-lang/cargo/blob/master/src/etc/_cargo

# zsh-completions
# zi ice lucid wait as'completion' blockf
# zi light zchee/zsh-completions

# bun
zi ice lucid wait as'completion' blockf has'bun'
zi snippet https://github.com/oven-sh/bun/blob/main/completions/bun.zsh

# *** Programs ***

# vivid
zi ice from'gh-r' as'program' mv'vivid* vivid' sbin'**/vivid(.exe|) -> vivid'
zi light @sharkdp/vivid

# exa
zi ice from'gh-r' as'program' sbin'**/exa -> exa' atclone'cp -vf completions/exa.zsh _exa'
zi light ogham/exa

# youtube-dl
# B: ytdl-org/youtube-dl
zi for as'program' nocompile'!' depth'1' \
  has'python' pick'$ZPFX/bin/youtube-dl*' make'!PREFIX=$ZPFX install' \
  atclone'ln -sfv youtube-dl.zsh _youtube-dl' atpull'%atclone' \
    ytdl-org/youtube-dl

# fzf
# GH-R: junegunn/fzf
zi ice from'gh-r' as'program'
zi light junegunn/fzf

# exa
# GH-R: ogham/exa
zi ice from'gh-r' as'program' sbin'**/exa -> exa' atclone'cp -vf completions/exa.zsh _exa'
zi light ogham/exa

# neovim
# GH-R: neovim/neovim
zi ice as'program' from'gh-r' \
  bpick'nvim-linux64.tar.gz' sbin'**/bin/nvim -> nvim'
zi light neovim/neovim

# zoxide
# GH-R: ajeetdsouza/zoxide
zi ice as'program' from'gh-r' pick'zoxide' \
  atclone'ln -s completions/_zoxide -> _zoxide;
  cp man/man1/*.1 $ZI[MAN_DIR]/man1; ./zoxide init zsh --cmd x > init.zsh' \
  atpull'%atclone' src'init.zsh' nocompile'!'
zi light ajeetdsouza/zoxide

# zsh-diff-so-fancy
# SC: z-shell/zsh-diff-so-fancy
zi ice wait lucid as'program' pick'bin/git-dsf'
zi load z-shell/zsh-diff-so-fancy

# pyenv
# B: pyenv/pyenv
zi ice atclone'PYENV_ROOT="$PWD" ./libexec/pyenv init - > zpyenv.zsh' \
  atinit'export PYENV_ROOT="$PWD"' atpull"%atclone" \
  as'program' pick'bin/pyenv' src"zpyenv.zsh" nocompile'!'
zi light pyenv/pyenv

# git-extras
# B tj/git-extras
zi ice wait lucid as'program' pick'$ZPFX/bin/git-*' make'PREFIX=$ZPFX' nocompile
zi light tj/git-extras

# lsd
# RA: Rust and Peltoche/lsd
zi ice rustup cargo'!lsd' id-as'lsd' as'program' nocompile
zi load z-shell/0

# *** Plugins ***

# zsh-zoxide
zi has'zoxide' wait lucid for \
  z-shell/zsh-zoxide

# zsh-exa
zi wait lucid for \
  has'exa' atinit'AUTOCD=1' \
    zplugin/zsh-exa

# LS_C0L0RS
# zi ice wait lucid reset \
#  atclone"[[ -z \${commands[dircolors]} ]] && local P=g
#     \${P}sed -i '/DIR/c\DIR 38;5;63;1' LS_COLORS
#     \${P}dircolors -b LS_COLORS >! clrs.zsh" \
#  atpull'%atclone' pick"clrs.zsh" nocompile'!' \
#  atload'zstyle ":completion:*:default" list-colors "${(s.:.)LS_COLORS}";'
# zi light trapd00r/LS_COLORS

# forgit
zi ice wait lucid
zi load wfxr/forgit

# zsh-autopair
zi ice wait lucid pick'autopair.zsh'
zi load hlissner/zsh-autopair

# zsh-navigation-tools
zi ice wait lucid
zi load z-shell/zsh-navigation-tools

# fast-syntax-highlighting
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
# source ~/.zsh/zsh-syntax-highlighting/catppuccin_mocha-zsh-syntax-highlighting.zsh

zi wait lucid for \
  atinit"ZI[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    z-shell/F-Sy-H \
  blockf \
    zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# autosuggestions
zi ice wait lucid atload"!_zsh_autosuggest_start"
zi load zsh-users/zsh-autosuggestions

# starship theme
zi ice as"command" from"gh-r" \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull"%atclone" src"init.zsh"
zi light starship/starship

# fnm
zi light "dominik-schwabe/zsh-fnm"

# asdf
zi light "asdf-vm/asdf"
fpath=(${ASDF_DIR}/completions $fpath)

# format PATH variable for easier viewing
function path(){
    old=$IFS
    IFS=:
    printf "%s\n" $PATH
    IFS=$old
}

# Initialize modules.
export EDITOR=nvim

# pnpm
export PNPM_HOME="/Users/rogeryee/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#> pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
#< pyenv

# zi wait lucid atload"zicompinit; zicdreplay" blockf for \
#   zsh-users/zsh-completions

zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -U add-zsh-hook
autoload -Uz compinit && compinit
# zi cdreplay -q

eval "$(fnm env --use-on-cd)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# custom keybindings
bindkey '^I'   complete-word       # tab          | complete
# bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest
