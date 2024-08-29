# t1=$(/opt/homebrew/bin/gdate +%s%N)
if [[ "$TERM" == "xterm-256color" || "$TERM" == "screen-256color" ]]; then
    /opt/homebrew/bin/fastfetch -c ~/.config/fastfetch/start.jsonc
fi

# Brew setup
eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(starship init zsh)"

export HISTFILE="$HOME/.omz_history"
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE

export ENABLE_CORRECTION="true"

export ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
export ZSH_CACHE_DIR="$HOME/.cache"
export ANTIDOTE_HOME="$HOME/.cache/antidote"
export zsh_plugins="$HOME/.zsh_plugins"

# MySql client
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PKG_CONFIG_PATH="/opt/homebrew/opt/mysql-client/lib/pkgconfig"
# export LDFLAGS="-L/opt/homebrew/opt/mysql-client/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/mysql-client/include"

# Java path
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# My paths
export WorkDir="$HOME/WorkDir"
export PATH="$WorkDir/bin:$PATH"
export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
export LESS='--mouse -R'

# Time command format
export TIMEFMT=$'%J\n\t%U user\t%S system\t%P cpu\t%*E total'

# Zsh vim plugin timeout
export KEYTIMEOUT=15

export AUTO_NOTIFY_IGNORE=("nvim" "lf" "batman" "bat" "htop" "git log" "ta" "ts" "yy")

# Timer omz extention
export TIMER_FORMAT='[%d]'
export TIMER_PRECISION=2

# FZF
export FZF_DEFAULT_COMMAND='fd --strip-cwd-prefix -HLtf --ignore-file ~/.ignore'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_DEFAULT_OPTS='--layout=reverse --info=inline --no-multi-line'
export FZF_COMPLETION_OPTS='--border'
export FZF_CTRL_T_OPTS="--height 80% --preview-window=right:70% --preview 'preview {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_CTRL_R_OPTS="--height 80% --border --preview 'echo {}' --preview-window up:3:hidden:wrap --bind 'ctrl-/:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --color header:italic --header 'Press CTRL-Y to copy command into clipboard'"

zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:*' switch-group 'H' 'L'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' continuous-trigger '.'
zstyle ':fzf-tab:*' fzf-bindings '<:toggle-out' '>:toggle-in' 'ctrl-a:toggle-all'

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons --git -TL2 --color=always $realpath'

zstyle ':antidote:bundle' use-friendly-names 'yes'

autoload -Uz compinit
compinit

_fzf_compgen_path() {
  fd -HL --ignore-file ~/.ignore . "$1"
}

_fzf_compgen_dir() {
  fd -td -HL --ignore-file ~/.ignore . "$1"
}

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

compdef batman=man

zvm_after_init(){
  source $HOME/.scripts.zsh
  source "$ANTIDOTE_HOME/https-COLON--SLASH--SLASH-github.com-SLASH-hlissner-SLASH-zsh-autopair/autopair.zsh"
  source <(fzf --zsh)
}

# Load Angular CLI autocompletion.
# source <(ng completion script)

# pnpm
export PNPM_HOME="/Users/emre/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
pyenv() {
  if [[ ! $PYENV_LAZY_LOAD ]]; then
    export PYENV_LAZY_LOAD=true
    eval "$(pyenv init -)"
  fi
  command pyenv "$@"
}

# Node version manager
export NVM_DIR="$HOME/.nvm"
nvm() {
  if [[ ! $NVM_LAZY_LOAD ]]; then
    export NVM_LAZY_LOAD=true
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
  fi
  nvm "$@"
}

source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load

# t2=$(/opt/homebrew/bin/gdate +%s%N)
# echo "Load time: $(( (t2 - t1) / 1000000 )) milliseconds"
