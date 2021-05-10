# ctrl+w respects "/"
# alt+backspace delete whole word
# bash like word deletion (opposite binds though)

function _move_backward_shortword() {
    if [[ "${#CURSOR}" -eq 0 ]]; then
        return
    fi

    local word_ranges='A-Za-z0-9._+-'
    _move_backward_while_character ' '
    case "${BUFFER:${CURSOR} - 1:1}" in
        /)
            _move_backward_while_character /
            _move_backward_while_pattern "[${word_ranges}]"
            ;;
        [A-Za-z0-9._+-])
            _move_backward_while_pattern "[${word_ranges}]"
            ;;
        *)
            _move_backward_while_pattern "[^ /${word_ranges}]"
            ;;
    esac
}

function _move_backward_while_character() {
    local skip_character="${1}"
    while [[ "${CURSOR}" -gt 0 ]]; do
        if [[ "${BUFFER:${CURSOR} - 1:1}" != "${skip_character}" ]]; then
            break
        fi
        CURSOR=$((${CURSOR} - 1))
    done
}

function _move_backward_while_pattern() {
    local skip_pattern="${1}"
    zmodload zsh/pcre
    pcre_compile -s "${skip_pattern}"
    while [[ "${CURSOR}" -gt 0 ]]; do
        if ! pcre_match -- "${BUFFER:${CURSOR} - 1:1}"; then
            break
        fi
        CURSOR=$((${CURSOR} - 1))
    done
}

function _backward_kill_shortword() {
    local MARK="${CURSOR}"
    local CURSOR="${CURSOR}"
    zle _move_backward_shortword
    zle kill-region
}
zle -N _backward_kill_shortword
zle -N _move_backward_shortword
bindkey '^w' _backward_kill_shortword

function _backward_kill_blankword() {
    local MARK="${CURSOR}"
    local CURSOR="${CURSOR}"
    zle vi-backward-blank-word
    zle kill-region
}
zle -N _backward_kill_blankword
bindkey '^[^?' _backward_kill_blankword
