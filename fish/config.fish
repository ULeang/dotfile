if status --is-interactive
  starship init fish | source

  set -gx _ZO_DATA_DIR "$HOME/.config/fish/zoxide"
  zoxide init fish | source
end
