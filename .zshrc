if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE="$HOME/.omz_history"
HISTSIZE=10000000
SAVEHIST=$HISTSIZE

ENABLE_CORRECTION="true"

ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
ZSH_CACHE_DIR="$HOME/.cache"
ANTIDOTE_HOME="$HOME/.cache/antidote"
zsh_plugins="$HOME/.zsh_plugins"


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

export AUTO_NOTIFY_IGNORE=("nvim" "lf" "batman" "bat" "htop" "git log" "ta" "ts")

# Timer omz extention
export TIMER_FORMAT='[%d]'
export TIMER_PRECISION=2

# FZF
export FZF_DEFAULT_OPTS='--height 70% --layout=reverse --info=inline'
export FZF_COMPLETION_OPTS='--border'
export FZF_CTRL_T_OPTS="--height 80% --preview-window=right:70% --preview 'preview {} | head -300' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_CTRL_R_OPTS="--height 60% --preview 'echo {}' --preview-window up:3:hidden:wrap --bind 'ctrl-/:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --color header:italic --header 'Press CTRL-Y to copy command into clipboard'"

compdef batman=man

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


[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zvm_after_init(){
  source $DevOps/bin/scripts.zsh
  source "$ANTIDOTE_HOME/https-COLON--SLASH--SLASH-github.com-SLASH-hlissner-SLASH-zsh-autopair/autopair.zsh"
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}

zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:*' switch-group 'H' 'L'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons --git -TL2 --color=always $realpath'

# Load Angular CLI autocompletion.
# source <(ng completion script)

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/emre/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/emre/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# if [ -f '/Users/emre/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/emre/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# pnpm
export PNPM_HOME="/Users/emre/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load

autoload -Uz compinit
compinit
