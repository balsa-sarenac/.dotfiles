export XDG_CONFIG_HOME=~/.config

# Doom emacs
export PATH=$PATH:~/.emacs.d/bin

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# local scripts
export PATH="$PATH:$HOME/.local/bin"

# pharo-cli (github.com/balsa-sarenac/pharo-cli)
export PATH="$PATH:$HOME/Projects/balsa-sarenac/pharo-cli/bin"

# postgres
export PATH="/opt/homebrew/opt/postgresql@13/bin:$PATH"
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

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`')'
}

if [[ -v VIRTUAL_ENV ]]; then
    PROMPT='[%*] $(virtualenv_info) %B%2~%b %# '
else
    PROMPT='[%*] %B%2~%b %# '
fi

# zsh
setopt AUTO_CD
setopt CORRECT
# setopt CORRECT_ALL

# zsh history
setopt EXTENDED_HISTORY
SAVEHIST=5000
HISTSIZE=2000
# share history across multiple zsh sessions
setopt SHARE_HISTORY
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

# completion
autoload -Uz compinit && compinit
# case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
# partial completion suggestions
zstyle ':completion:*' list-suffixes zstyle ':completion:*' expand prefix suffix


# keyremaps
# hidutil property --set '{"UserKeyMapping":
#     [{"HIDKeyboardModifierMappingSrc":0x700000039,
#       "HIDKeyboardModifierMappingDst":0x7000000E0}]
# }'

# chrome driver
export PATH=$PATH:~/utils
export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# start emacs daemon
# emacs --daemon

# bitwarden completion
# eval "$(bw completion --shell zsh); compdef _bw bw;"

if [ -f ~/.local/bin/jump.sh ]; then
    source ~/.local/bin/jump.sh
else
    print "404: ~/.local/bin/jump.sh not found"
fi
