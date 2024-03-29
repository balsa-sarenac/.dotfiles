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


