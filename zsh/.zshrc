# Doom emacs
export PATH=$PATH:~/.emacs.d/bin
export XDG_CONFIG_HOME=~/.config

# flutter
export PATH=$PATH:~/development/flutter/bin
export PATH=$PATH:$HOME/.pub-cache/bin

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

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

eval "$(bw completion --shell zsh); compdef _bw bw;"


######################################################################
## Navigation function

# goSetFunction()
#{
#    if [ ! -d "${XDG_CONFIG_HOME}/go" ]; then
#        mkdir "${XDG_CONFIG_HOME}/go";
#    fi
#    echo `pwd` > "${XDG_CONFIG_HOME}/go/$1"
#}
#
#goFunction()
#{
#    if [ ! -e "${XDG_CONFIG_HOME}/go/$1" ]; then
#        echo "Entry not found!"
#    else
#        cd `cat ${XDG_CONFIG_HOME}/go/$1`;
##	jump set $1
#    fi
#}
#
#goAndLsFunction()
#{
#    if [ ! -e "${XDG_CONFIG_HOME}/go/$1" ]; then
#        echo "Entry not found!"
#    else
#        cd `cat ${XDG_CONFIG_HOME}/go/$1`
#	ls
#    fi
#}
#
#
#goOpenFolder()
#{
#    if [ ! -e "${XDG_CONFIG_HOME}/go/$1" ]; then
#        echo "Entry not found!"
#    else
#        open `cat ${XDG_CONFIG_HOME}/go/$1`
#    fi
#}
#
#alias "a=alias"
#a "go=goFunction"
#a "gset=goSetFunction"
#a "gop=goOpenFolder"
#
#alias pdflatex='pdflatex -8bit -etex -file-line-error -halt-on-error -synctex=1'
#alias we='open -a Emacs'


####################################################################
# defines the config base folder
JUMP_FOLDER=~/.jump
if [ -n "${XDG_CONFIG_HOME}" ]; then
  JUMP_FOLDER="${XDG_CONFIG_HOME}/jump"
elif [ -e ~/.config ]; then
  JUMP_FOLDER=~/.config/jump
fi

_jump_go() {
  [ ! -e "${JUMP_FOLDER}/$1" ] && {
    (>&2 echo "Entry $1 does not exist")
    return 2
  }
  cd -P "${JUMP_FOLDER}/$1"
}

_jump_list() {
  [ ! -d "${JUMP_FOLDER}" ] && return 1
  [ -z "$(ls -A ${JUMP_FOLDER})" ] && return 0
  case "$1" in
    details)
      for link in ${JUMP_FOLDER}/*; do
        echo -e "\e[1;96m${link##*/}\e[0;39m  ->  $(readlink ${link})"
      done
      ;;
    *)
      ls "${JUMP_FOLDER}"
      ;;
  esac
}

_jump_set() {
  [ ! -d "${JUMP_FOLDER}" ] && mkdir "${JUMP_FOLDER}"
  [ -e "${JUMP_FOLDER}/$1" ] && {
    (>&2 echo "Entry already exists: '$1' is linked to $(readlink ${JUMP_FOLDER}/$1)")
    return 3
  }
  ln -ns "${PWD}" "${JUMP_FOLDER}/$1"
}

_jump_rm() {
  [ ! -e "${JUMP_FOLDER}/$1" ] && {
    (>&2 echo "Entry $1 does not exist")
    return 2
  }
  rm "${JUMP_FOLDER}/$1"
}

_jump_clean() {
  [ ! -d "${JUMP_FOLDER}" ] && return 1
  [ -z "$(ls -A ${JUMP_FOLDER})" ] && return 0
  echo "Cleaning invalid entries..."
  for link in ${JUMP_FOLDER}/*; do
    [ ! -e "${link}" ] && {
      echo "remove invalid entry ${link##*/}"
      rm "${link}"
    }
  done
}

jump() {
  case "$1" in
    set)
      shift
      _jump_set "$@"
      ;;
    list)
      shift
      _jump_list "$@"
      ;;
    remove)
      shift
      _jump_rm "$@"
      ;;
    clean)
      _jump_clean
      ;;
    *)
      _jump_go "$@"
      ;;
  esac
}

_jump_completion_bash() {
  local argc cur opts prev

  argc=${COMP_CWORD};
  cur="${COMP_WORDS[argc]}"
  prev="${COMP_WORDS[argc-1]}"

  case "${prev}" in
    jump)
      opts="set remove list clean $(ls ${JUMP_FOLDER})"
      ;;
    list)
      opts="details"
      ;;
    set)
      # proposes the current directory name
      opts="${PWD##*/}"
      ;;
    clean)
      opts=""
      ;;
    remove)
      opts="$(ls ${JUMP_FOLDER})"
      ;;
  esac

  COMPREPLY=( $(compgen -W "$opts" -- $cur ) )
}

#[ -n "${ZSH_VERSION}" ] && {
#  autoload -U +X compinit && compinit
#  autoload -U +X bashcompinit && bashcompinit
#}

autoload -Uz compinit bashcompinit
compinit
bashcompinit
complete -F _jump_completion_bash jump


###################################################





#compdef git-bug

# zsh completion for git-bug                              -*- shell-script -*-

__git-bug_debug()
{
    local file="$BASH_COMP_DEBUG_FILE"
    if [[ -n ${file} ]]; then
        echo "$*" >> "${file}"
    fi
}

_git-bug()
{
    local shellCompDirectiveError=1
    local shellCompDirectiveNoSpace=2
    local shellCompDirectiveNoFileComp=4
    local shellCompDirectiveFilterFileExt=8
    local shellCompDirectiveFilterDirs=16

    local lastParam lastChar flagPrefix requestComp out directive comp lastComp noSpace
    local -a completions

    __git-bug_debug "\n========= starting completion logic =========="
    __git-bug_debug "CURRENT: ${CURRENT}, words[*]: ${words[*]}"

    # The user could have moved the cursor backwards on the command-line.
    # We need to trigger completion from the $CURRENT location, so we need
    # to truncate the command-line ($words) up to the $CURRENT location.
    # (We cannot use $CURSOR as its value does not work when a command is an alias.)
    words=("${=words[1,CURRENT]}")
    __git-bug_debug "Truncated words[*]: ${words[*]},"

    lastParam=${words[-1]}
    lastChar=${lastParam[-1]}
    __git-bug_debug "lastParam: ${lastParam}, lastChar: ${lastChar}"

    # For zsh, when completing a flag with an = (e.g., git-bug -n=<TAB>)
    # completions must be prefixed with the flag
    setopt local_options BASH_REMATCH
    if [[ "${lastParam}" =~ '-.*=' ]]; then
        # We are dealing with a flag with an =
        flagPrefix="-P ${BASH_REMATCH}"
    fi

    # Prepare the command to obtain completions
    requestComp="${words[1]} __complete ${words[2,-1]}"
    if [ "${lastChar}" = "" ]; then
        # If the last parameter is complete (there is a space following it)
        # We add an extra empty parameter so we can indicate this to the go completion code.
        __git-bug_debug "Adding extra empty parameter"
        requestComp="${requestComp} \"\""
    fi

    __git-bug_debug "About to call: eval ${requestComp}"

    # Use eval to handle any environment variables and such
    out=$(eval ${requestComp} 2>/dev/null)
    __git-bug_debug "completion output: ${out}"

    # Extract the directive integer following a : from the last line
    local lastLine
    while IFS='\n' read -r line; do
        lastLine=${line}
    done < <(printf "%s\n" "${out[@]}")
    __git-bug_debug "last line: ${lastLine}"

    if [ "${lastLine[1]}" = : ]; then
        directive=${lastLine[2,-1]}
        # Remove the directive including the : and the newline
        local suffix
        (( suffix=${#lastLine}+2))
        out=${out[1,-$suffix]}
    else
        # There is no directive specified.  Leave $out as is.
        __git-bug_debug "No directive found.  Setting do default"
        directive=0
    fi

    __git-bug_debug "directive: ${directive}"
    __git-bug_debug "completions: ${out}"
    __git-bug_debug "flagPrefix: ${flagPrefix}"

    if [ $((directive & shellCompDirectiveError)) -ne 0 ]; then
        __git-bug_debug "Completion received error. Ignoring completions."
        return
    fi

    local activeHelpMarker="_activeHelp_ "
    local endIndex=${#activeHelpMarker}
    local startIndex=$((${#activeHelpMarker}+1))
    local hasActiveHelp=0
    while IFS='\n' read -r comp; do
        # Check if this is an activeHelp statement (i.e., prefixed with $activeHelpMarker)
        if [ "${comp[1,$endIndex]}" = "$activeHelpMarker" ];then
            __git-bug_debug "ActiveHelp found: $comp"
            comp="${comp[$startIndex,-1]}"
            if [ -n "$comp" ]; then
                compadd -x "${comp}"
                __git-bug_debug "ActiveHelp will need delimiter"
                hasActiveHelp=1
            fi

            continue
        fi

        if [ -n "$comp" ]; then
            # If requested, completions are returned with a description.
            # The description is preceded by a TAB character.
            # For zsh's _describe, we need to use a : instead of a TAB.
            # We first need to escape any : as part of the completion itself.
            comp=${comp//:/\\:}

            local tab="$(printf '\t')"
            comp=${comp//$tab/:}

            __git-bug_debug "Adding completion: ${comp}"
            completions+=${comp}
            lastComp=$comp
        fi
    done < <(printf "%s\n" "${out[@]}")

    # Add a delimiter after the activeHelp statements, but only if:
    # - there are completions following the activeHelp statements, or
    # - file completion will be performed (so there will be choices after the activeHelp)
    if [ $hasActiveHelp -eq 1 ]; then
        if [ ${#completions} -ne 0 ] || [ $((directive & shellCompDirectiveNoFileComp)) -eq 0 ]; then
            __git-bug_debug "Adding activeHelp delimiter"
            compadd -x "--"
            hasActiveHelp=0
        fi
    fi

    if [ $((directive & shellCompDirectiveNoSpace)) -ne 0 ]; then
        __git-bug_debug "Activating nospace."
        noSpace="-S ''"
    fi

    if [ $((directive & shellCompDirectiveFilterFileExt)) -ne 0 ]; then
        # File extension filtering
        local filteringCmd
        filteringCmd='_files'
        for filter in ${completions[@]}; do
            if [ ${filter[1]} != '*' ]; then
                # zsh requires a glob pattern to do file filtering
                filter="\*.$filter"
            fi
            filteringCmd+=" -g $filter"
        done
        filteringCmd+=" ${flagPrefix}"

        __git-bug_debug "File filtering command: $filteringCmd"
        _arguments '*:filename:'"$filteringCmd"
    elif [ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]; then
        # File completion for directories only
        local subdir
        subdir="${completions[1]}"
        if [ -n "$subdir" ]; then
            __git-bug_debug "Listing directories in $subdir"
            pushd "${subdir}" >/dev/null 2>&1
        else
            __git-bug_debug "Listing directories in ."
        fi

        local result
        _arguments '*:dirname:_files -/'" ${flagPrefix}"
        result=$?
        if [ -n "$subdir" ]; then
            popd >/dev/null 2>&1
        fi
        return $result
    else
        __git-bug_debug "Calling _describe"
        if eval _describe "completions" completions $flagPrefix $noSpace; then
            __git-bug_debug "_describe found some completions"

            # Return the success of having called _describe
            return 0
        else
            __git-bug_debug "_describe did not find completions."
            __git-bug_debug "Checking if we should do file completion."
            if [ $((directive & shellCompDirectiveNoFileComp)) -ne 0 ]; then
                __git-bug_debug "deactivating file completion"

                # We must return an error code here to let zsh know that there were no
                # completions found by _describe; this is what will trigger other
                # matching algorithms to attempt to find completions.
                # For example zsh can match letters in the middle of words.
                return 1
            else
                # Perform file completion
                __git-bug_debug "Activating file completion"

                # We must return the result of this command, so it must be the
                # last command, or else we must store its result to return it.
                _arguments '*:filename:_files'" ${flagPrefix}"
            fi
        fi
    fi
}

# don't run the completion function when being source-ed or eval-ed
if [ "$funcstack[1]" = "_git-bug" ]; then
    _git-bug
fi

