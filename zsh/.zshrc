export XDG_CONFIG_HOME="$HOME/.config"

# path
export BUN_INSTALL="$HOME/.bun"
typeset -U path PATH
path=(
    "$HOME/.turso"
    "$BUN_INSTALL/bin"
    "/opt/homebrew/opt/postgresql@13/bin"
    $path
    "$HOME/.config/emacs/bin"
    "$HOME/.local/bin"
    "$HOME/Projects/balsa-sarenac/pharo-cli/bin"
    "$HOME/utils"
    "$HOME/.cargo/bin"
)

# postgres
export LDFLAGS="-L/opt/homebrew/opt/postgresql@13/lib"
export CPPFLAGS="-I/opt/homebrew/opt/postgresql@13/include"

# prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

# export VIRTUAL_ENV_DISABLE_PROMPT=1

virtualenv_info() {
    [[ -n "$VIRTUAL_ENV" ]] && print -n "($(basename "$VIRTUAL_ENV")) "
}
virtualenv_info() {
    print -n ""
}

PROMPT='[%*] $(virtualenv_info)%B%2~%b %# '

# zsh
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# zsh history
setopt EXTENDED_HISTORY
SAVEHIST=5000
HISTSIZE=2000
# share history across multiple zsh sessions
# setopt SHARE_HISTORY
# append to history
setopt APPEND_HISTORY
# adds commands as they are typed, not at shell exit
setopt INC_APPEND_HISTORY
# do not store duplications
setopt HIST_IGNORE_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

# aliases
alias ll='ls -al'
alias gd="git difftool --no-symlinks --dir-diff"
alias gti='git'
alias gitp='git'
alias puml='java -jar ~/.local/bin/plantuml.jar'

# completion
autoload -Uz compinit && compinit -C
# case-insensitive path completion
zstyle ':completion:*' matcher-list \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
# partial completion suggestions
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' expand prefix suffix


# keyremaps
# hidutil property --set '{"UserKeyMapping":
#     [{"HIDKeyboardModifierMappingSrc":0x700000039,
#       "HIDKeyboardModifierMappingDst":0x7000000E0}]
# }'

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh" --no-use
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# start emacs daemon
# emacs --daemon

# bitwarden completion
# eval "$(bw completion --shell zsh); compdef _bw bw;"

[ -f ~/.local/bin/jump.sh ] && source ~/.local/bin/jump.sh

# Gotham Shell
# GOTHAM_SHELL="$HOME/.config/gotham/gotham.sh"
# [[ -s $GOTHAM_SHELL ]] && source $GOTHAM_SHELL

# EXTENDED_HISTORY
export EDITOR=nvim
export REACT_EDITOR=nvim

eval "$(atuin init zsh)"

# Difftastic
# export GIT_EXTERNAL_DIFF=difft

# Pharo launcher
alias pharo-launcher='/Applications/PharoLauncher.app/Contents/Resources/pharo-launcher'
alias pl='pharo-launcher'

# QOL
alias vim=nvim
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gc="git commit -v"

# use newer ssh for yubikey things
# SSH_AUTH_SOCK="~/.ssh/agent"

# bun completions
[ -s "/Users/balsa/.bun/_bun" ] && source "/Users/balsa/.bun/_bun"

# opencode
# export PATH=/Users/balsa/.opencode/bin:$PATH

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# 1password ssh agent
export SSH_AUTH_SOCK='~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock'

# add guile to path
export GUILE_LOAD_PATH="/opt/homebrew/share/guile/site/3.0"
export GUILE_LOAD_COMPILED_PATH="/opt/homebrew/lib/guile/3.0/site-ccache"
export GUILE_SYSTEM_EXTENSIONS_PATH="/opt/homebrew/lib/guile/3.0/extensions"

# make these work in tmux
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history

# opencode
export PATH=/Users/balsa/.opencode/bin:$PATH
