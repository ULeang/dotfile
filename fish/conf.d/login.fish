if status --is-login
  if test -z "$DISPLAY" -a $XDG_VTNR = 1
    exec Hyprland
  end
end
