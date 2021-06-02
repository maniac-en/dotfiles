# mkdir -p and cd $1
function mcd() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" || true; }
compdef -d mcd
compdef _directories mcd

# extract it away
function ex () {
  if [ -f "$1" ] ; then
      case "$1" in
          *.tar.bz2)    mkdir "${1%.*}" && cd "${1%.*}" && tar xvjf ../"$1"     ;;
          *.tar.gz)     mkdir "${1%.*}" && cd "${1%.*}" && tar xvzf ../"$1"     ;;
          *.tar.xz)     mkdir "${1%.*}" && cd "${1%.*}" && tar xf ../"$1"       ;;
          *.bz2)        mkdir "${1%.*}" && cd "${1%.*}" && bunzip2 ../"$1"      ;;
          *.rar)        mkdir "${1%.*}" && cd "${1%.*}" && rar x ../"$1"        ;;
          *.gz)         mkdir "${1%.*}" && cd "${1%.*}" && gunzip ../"$1"       ;;
          *.tar)        mkdir "${1%.*}" && cd "${1%.*}" && tar xvf ../"$1"      ;;
          *.tbz2)       mkdir "${1%.*}" && cd "${1%.*}" && tar xvjf ../"$1"     ;;
          *.tgz)        mkdir "${1%.*}" && cd "${1%.*}" && tar xvzf ../"$1"     ;;
          *.zip)        mkdir "${1%.*}" && cd "${1%.*}" && unzip ../"$1"        ;;
          *.Z)          mkdir "${1%.*}" && cd "${1%.*}" && uncompress ../"$1"   ;;
          *.7z)         mkdir "${1%.*}" && cd "${1%.*}" && 7z x ../"$1"         ;;
          *)            echo "don't know how to extract $1..." ;;
      esac
  else
      echo "Can not read file $1"
  fi
}

# wget dir
function wget_dir() {
    if [ "$#" -eq 2 ]
    then
        wget -r -nH --cut-dirs="$1" --no-parent --reject="index.html*" "$2"
    else
        echo -e "\nPass the required arguments as follows \
            \n\t\033[1;40;31mwget_dir 2 http://mysite.com/dir1/dir2/data\033[0m\n" >&2
    fi
}

# gist wrapper
function gist() {
    /usr/bin/gist -p --skip-empty "${@}" | clipster -c
}

# git wrapper
function g() {
    if [[ $# -gt 0 ]]; then
        git "$@"
    else
        { git headlog 2>/dev/null || : } && git status -sb
    fi
}
compdef g=git

# gcd
function gcd() {
    local git_root_path=$(git rev-parse --show-toplevel 2>/dev/null)
    if [[ -n "$git_root_path" ]]; then cd "$git_root_path"; fi
}
