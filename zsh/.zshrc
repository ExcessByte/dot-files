plugin_dir="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins"
mkdir -p "$plugin_dir"

if [[ ! -f "$plugin_dir/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$plugin_dir/zsh-autosuggestions"
fi

source "$plugin_dir/zsh-autosuggestions/zsh-autosuggestions.zsh"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

autoload -Uz compinit && compinit

# Completion styling & behavior
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete _correct _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*' tag-order 'functions builtins commands'
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'


export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"

# --- Go ---
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"

# --- Git Global Config ---
export GIT_CONFIG_GLOBAL="${XDG_CONFIG_HOME:-$HOME/.config}/git/config"

# --- npm Cache ---
export npm_config_cache="${XDG_CACHE_HOME:-$HOME/.cache}/npm"
export NPM_CONFIG_PREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/npm"

# Ensure global directories exist
mkdir -p "$CARGO_HOME/bin" "$GOPATH/bin" "$(dirname "$GIT_CONFIG_GLOBAL")" "$npm_config_cache" "$NPM_CONFIG_PREFIX"

# --- Update PATH ---
# Prepend binary paths so user-installed binaries take precedence
path=(
  "$CARGO_HOME/bin"
  "$GOPATH/bin"
  "$NPM_CONFIG_PREFIX/bin"
  $path
)
# Retain unique entries in PATH automatically
typeset -U path
export PATH


alias ls="eza --icons=auto --group-directories-first"
alias ll="eza -lh --icons=auto --group-directories-first --git"
alias la="eza -ah --icons=auto --group-directories-first --git"
alias lt="eza --tree --level=2 --icons=auto"

alias cat="bat --style=plain"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

eval "$(zoxide init zsh)"
source <(fzf --zsh)

export FZF_DEFAULT_OPTS="
  --height 50%
  --layout=reverse
  --border
  --info=inline
  --prompt='>>> '
  --pointer='▶'
  --marker='✓'
"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

export FZF_CTRL_T_OPTS="
  --preview 'bat --style=numbers --color=always --line-range :50 {} 2>/dev/null || cat {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
"

export FZF_ALT_C_OPTS="
  --preview 'eza --tree --level=2 --icons=auto {} 2>/dev/null || ls {}'
"

export FZF_CTRL_R_OPTS="
  --preview 'echo {}'
  --preview-window down:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
"

# ==============================================================================
# NATIVE ZSH PROMPT SETUP
# ==============================================================================
autoload -Uz colors && colors

PROMPT='%F{cyan}%3~%f %(?.%F{green}.%F{red})>>>%f '

eval "$(zsh-patina activate)"

unset plugin_dir _scripts
