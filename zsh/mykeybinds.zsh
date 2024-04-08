# Use hjlk in menu selection (during completion)
# Doesn't work well with interactive mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
# function zle-keymap-select {
#   if [[ ${KEYMAP} == vicmd ]] ||
#      [[ $1 = 'block' ]]; then
#     echo -ne '\e[1 q'
#   elif [[ ${KEYMAP} == main ]] ||
#        [[ ${KEYMAP} == viins ]] ||
#        [[ ${KEYMAP} = '' ]] ||
#        [[ $1 = 'underline' ]]; then
#     echo -ne '\e[3 q'
#   fi
# }
# zle -N zle-keymap-select
# zle-line-init() {
#     echo -ne "\e[3 q"
# }
# zle -N zle-line-init

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# bindkey 'jk' vi-cmd-mode
bindkey '^J' vi-cmd-mode
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^K' up-line-or-history
bindkey '^U' kill-whole-line
bindkey '^W' backward-kill-word
bindkey '^H' backward-delete-char
# ctrl /
bindkey '^_' history-incremental-search-backward

# backspace
# bindkey '^?' vi-backward-delete-char

# bindkey '^H' backward-word
# bindkey '^L' forward-word
# bindkey '^J' down-line-or-history
# bindkey '^K' up-line-or-history
# bindkey '^A' beginning-of-line
# bindkey '^E' end-of-line
# bindkey '^O' clear-screen
# # bindkey '^B' backward-kill-line
# bindkey '^N' kill-whole-line
# bindkey '^W' backward-kill-word

bindkey -s '^S' '\eIsudo \eA'

autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done
