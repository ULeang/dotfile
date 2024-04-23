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
end
