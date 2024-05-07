if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

HISTFILE="$HOME/.omz_history"
HISTSIZE=10000000
SAVEHIST=10000000

# Brew setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# MySql client

export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PKG_CONFIG_PATH="/opt/homebrew/opt/mysql-client/lib/pkgconfig"
# export LDFLAGS="-L/opt/homebrew/opt/mysql-client/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/mysql-client/include"

# Java path
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# My paths
export DevOps="$HOME/Desktop/DevOps"
export PATH="$DevOps/bin:$PATH"
export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Time command format
export TIMEFMT=$'%J\n\t%U user\t%S system\t%P cpu\t%*E total'

# Zsh vim plugin timeout
export KEYTIMEOUT=15

export AUTO_NOTIFY_IGNORE=("nvim" "lf" "batman" "bat" "htop" "git log")

# Timer omz extention
export TIMER_FORMAT='[%d]'
export TIMER_PRECISION=2

# FZF
export FZF_DEFAULT_OPTS='--height 70% --layout=reverse --info=inline'
export FZF_COMPLETION_OPTS='--border'
export FZF_CTRL_T_OPTS="--height 80% --preview-window=right:70% --preview 'preview {} | head -300' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_CTRL_R_OPTS="--height 60% --preview 'echo {}' --preview-window up:3:hidden:wrap --bind 'ctrl-/:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --color header:italic --header 'Press CTRL-Y to copy command into clipboard'"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --height 80% --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --height 80% --preview-window=right:70% --preview 'preview {} | head -300' "$@" ;;
    # *)            fzf --height 80% --preview-window=right:70% --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates


zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:*' switch-group 'H' 'L'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons --git -TL2 --color=always $realpath'

# zstyle ':completion:*' menu no


zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

plugins=(
  git
  sudo
  tmux
  timer
  vi-mode
  fzf-tab
  history
  docker
  zoxide
  # copypath
  # copyfile
  # copybuffer
  # dirhistory
  auto-notify
  # zsh-autocomplete
  zsh-autosuggestions
  zsh-syntax-highlighting
  # web-search
)


source $ZSH/oh-my-zsh.sh
source $DevOps/bin/scripts

compdef batman=man

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load Angular CLI autocompletion.
# source <(ng completion script)

# bindkey -v


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/emre/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/emre/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# if [ -f '/Users/emre/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/emre/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
