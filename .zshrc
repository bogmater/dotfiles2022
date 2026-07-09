# ==============================================================================
# Zinit Plugin Manager
# ==============================================================================

if [[ ! -d ~/.local/share/zinit/zinit.git ]]; then
  mkdir -p ~/.local/share/zinit
  git clone https://github.com/zdharma-continuum/zinit.git \
    ~/.local/share/zinit/zinit.git
fi

source ~/.local/share/zinit/zinit.git/zinit.zsh

# ==============================================================================
# Plugins
# ==============================================================================

# oh-my-zsh plugins you actually use
zinit wait lucid for \
  OMZ::plugins/git \
  OMZ::plugins/composer \
  OMZ::plugins/npm \
  OMZ::plugins/ssh-agent \
  OMZ::plugins/tmux \
  OMZ::plugins/tmuxinator \
  OMZ::plugins/z

# External plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting


# ==============================================================================
# Shell Configuration
# ==============================================================================

HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

typeset -U path cdpath fpath

# Vim mode
bindkey -v
export KEYTIMEOUT=1

export ANDROID_HOME="$HOME/Android/Sdk/"
export GIT_EDITOR=vim

# PATH entries
path+=(
  $HOME/.local/bin
  $HOME/.bin
  $HOME/bin
  $HOME/.composer/vendor/bin
  $HOME/.symfony5/bin/
  $HOME/.go/bin
  ./vendor/bin
  ${ANDROID_HOME}tools/
  ${ANDROID_HOME}platform-tools/
)

setopt auto_cd
cdpath=($HOME/Code)

# Completion styling
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %B%d%b
zstyle ':completion:*:complete:(cd|pushd):*' tag-order 'local-directories named-directories'

export EDITOR='vim'
export NVIM_LISTEN_ADDRESS='/tmp/nvimsocket'
export ARTISAN_OPEN_ON_MAKE_EDITOR='nvr'
export FZF_DEFAULT_COMMAND='ag -u -g ""'

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt appendhistory
setopt sharehistory
setopt inc_append_history
setopt extended_history


# ==============================================================================
# Aliases & Functions (ALL PRESERVED)
# ==============================================================================

# Laravel
alias a="artisan"
alias tinker="artisan tinker"
alias serve="artisan serve"
alias mfs="artisan migrate:fresh --seed"

homestead() { ( cd ~/Homestead && vagrant "$@" ) }

# Git
alias g="git"
alias gs="git s"
alias nah="git reset --hard;git clean -df"
alias co="git checkout"
alias glp="git log --all --decorate --oneline --graph"

# Docker
alias d="docker"
alias dc="docker-compose"
alias dce="docker-compose exec"
alias dcea="docker-compose exec app"
dceas () { docker-compose exec app su app -c "$*" }
alias dceasa="dceas php artisan"

# General
alias vim="nvim"
alias mux="tmuxinator"
alias copy="xclip -selection clipboard"
alias paste="xclip -o -selection clipboard"
alias ag="sag"
alias fakeafk="keep-presence -s 600"
alias webcam="gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video1"
alias usephp7.4="sudo update-alternatives --set php /usr/bin/php7.4"
alias usephp8.1="sudo update-alternatives --set php /usr/bin/php8.1"
alias kgp="kubectl get pods -A --no-headers | fzf | awk '{print $2, $1}' | xargs -n 2 sh -c 'kubectl describe pod $0 -n $1'"
alias awsp="source _awsp"

# z + nvim integration
v() {
  if [[ -n "$1" ]]; then
    z "$1"
  fi
  nvim
}

# tixx k8s environment
ticd () {
  export AWS_PROFILE=tixx-dev-frame01
  export KUBECONFIG="$HOME/.kube/tixx-dev"
  echo "k8s env tixx-dev"
}

open () {
  xdg-open "$@" > /dev/null 2>&1
}

# tag integration
if (( $+commands[tag] )); then
  tag() { command tag "$@"; source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null }
  alias ag=tag
fi


# ==============================================================================
# Startup Scripts
# ==============================================================================

if [[ $- == *i* && $0 == '/bin/zsh' ]]; then
  ~/.dotfiles/scripts/login.sh
fi


# ==============================================================================
# Tools & Environment
# ==============================================================================

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# NVM
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"

# MySQL & Go
export PATH="/usr/local/opt/mysql-client/bin:/usr/local/go/bin:$PATH"

# Keybindings
bindkey -v
bindkey '^R' history-incremental-search-backward

# Starship prompt
eval "$(starship init zsh)"

# PNPM
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Disable leftover NVIM socket override
export NVIM_LISTEN_ADDRESS=''

# -------------------------------
# Directory colors for Linux
# -------------------------------

# 1. Force colored ls
alias ls='ls --color=auto'

# 2. LS_COLORS for directory highlighting
# di = directories (blue bold), ln = symlinks (cyan), executable scripts (green)
export LS_COLORS="di=1;34:ln=1;36:*.sh=1;32:*.py=1;32:*.pl=1;32:*.rb=1;32:*.php=1;32:*.js=1;32:*.ts=1;32:${LS_COLORS}"

# 3. Zsh completion colors (after compinit)
autoload -Uz compinit
compinit
zstyle ':completion:*' list-colors "${LS_COLORS}"

# 4. Zsh syntax highlighting for typed directories
if (( $+commands[zsh-syntax-highlighting] )); then
  ZSH_HIGHLIGHT_STYLES[path]='fg=34,bold'
  ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=34,bold'
fi

# 5. Zsh autosuggestions style
if (( $+commands[zsh-autosuggestions] )); then
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
fi

# opencode
export PATH=/home/dtrupcevic/.opencode/bin:$PATH
