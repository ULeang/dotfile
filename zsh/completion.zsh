# Should be called before compinit
zmodload zsh/complist

autoload -U compinit
compinit
# _comp_options+=(globdots) # With hidden files

setopt MENU_COMPLETE        # Automatically highlight first element of completion menu

# Ztyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Define completers
zstyle ':completion:*' completer _extensions _complete

# Use cache for commands using cache
# zstyle ':completion:*' use-cache on
# zstyle ':completion:*' cache-path "/home/ulya/.cache/zsh/.zcompcache"

# Allow you to select in a menu
zstyle ':completion:*' menu select

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true

zstyle ':completion:*' file-sort modification

zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}%B -- %d --%b%f'
zstyle ':completion:*:*:*:*:messages' format '%F{purple}%B -- %d --%b%f'
zstyle ':completion:*:*:*:*:warnings' format '%F{red}%B -- no matches found --%b%f'
# zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
# zstyle ':completion:*:complete:git:argument-1:' tag-order !aliases

# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''

zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' keep-prefix true

# kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'
