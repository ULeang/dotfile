if status --is-login
  if test -z "$DISPLAY" -a $XDG_VTNR = 1
    exec Hyprland
  end
end

if status --is-interactive
# mpc
# export MPD_HOST="$HOME/.config/mpd/socket"
  set -gx MPD_HOST localhost
  set -gx MPD_PORT 6600

  set -gx EDITOR nvim
  set -gx VISUAL nvim

# my scgxipt dir
  set -gx PATH "$HOME/.config/scripts" $PATH

  set -gx PATH $PATH "$HOME/.ghcup/bin"

  set -gx XDG_CONFIG_HOME "$HOME/.config"
  set -gx XDG_DATA_HOME "$HOME/.local/share"
  set -gx XDG_CACHE_HOME "$HOME/.cache"
  set -gx XDG_STATE_HOME "$HOME/.local/state"

# ysyx
  set -gx NEMU_HOME "$HOME/ysyx-workbench/nemu"
  set -gx AM_HOME "$HOME/ysyx-workbench/abstract-machine"
  set -gx NPC_HOME "$HOME/ysyx-workbench/npc"
  set -gx NVBOARD_HOME "$HOME/ysyx-workbench/nvboard"

  set -g fish_greeting

# alias ls="ls --color=auto"
# alias ll="ls -l --color=auto"
# alias la="ls -a --color=auto"
# alias l="ls -la --color=auto"
  alias grep="grep --color=auto"
  alias ls="lsd"
  alias ll="ls -l"
  alias la="ls -a"
  alias l="ls -la"
  alias lt="ls --tree"
# alias grep="rg"
# alias cat="bat"

  alias wp="cd ~/workspace/"
  alias mcd="cd ~/workspace/mcd/"

  alias nv="nvim"
  alias ems="emacs -nw"

  alias xx="cd ~/workspace/mcd/xxCodes"
  alias rs="cd ~/workspace/mcd/rsCodes"

  alias make="make -j16"

  starship init fish | source

  set -gx _ZO_DATA_DIR "$HOME/.config/fish/zoxide"
  zoxide init fish | source
end
