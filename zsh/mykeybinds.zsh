# Use hjlk in menu selection (during completion)
# Doesn't work well with interactive mode
bindkey -v
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

bindkey 'jk' vi-cmd-mode
bindkey '^A' beginning-of-line
bindkey '^F' end-of-line
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
