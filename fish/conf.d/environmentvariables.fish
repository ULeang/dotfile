if status --is-interactive
  set -gx PATH $PATH "/usr/lib/rustup/bin"
  set -gx PATH "$HOME/.config/scripts" $PATH
  set -gx PATH $PATH "$HOME/.ghcup/bin"
# mpc
# export MPD_HOST="$HOME/.config/mpd/socket"
  set -gx MPD_HOST localhost
  set -gx MPD_PORT 6600

  set -gx EDITOR nvim
  set -gx VISUAL nvim

# my scgxipt dir
  set -gx XDG_CONFIG_HOME "$HOME/.config"
  set -gx XDG_DATA_HOME "$HOME/.local/share"
  set -gx XDG_CACHE_HOME "$HOME/.cache"
  set -gx XDG_STATE_HOME "$HOME/.local/state"

# ysyx
  set -gx NEMU_HOME "$HOME/ysyx-workbench/nemu"
  set -gx AM_HOME "$HOME/ysyx-workbench/abstract-machine"
  set -gx NPC_HOME "$HOME/ysyx-workbench/npc"
  set -gx NVBOARD_HOME "$HOME/ysyx-workbench/nvboard"
  set -gx CPUTS_HOME "$HOME/ysyx-workbench/cputs"

  set -g fish_greeting

# some program expects some behaviours of bash/sh,
# see https://wiki.archlinux.org/title/Fish#Setting_fish_as_default_shell
  set -gx DEBUGINFOD_URLS "https://debuginfod.archlinux.org"
end
