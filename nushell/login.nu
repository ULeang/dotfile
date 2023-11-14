let display = $env.DISPLAY?
if ($display == null or $display == '') and $env.XDG_VTNR? == '1' {
  exec Hyprland
}
