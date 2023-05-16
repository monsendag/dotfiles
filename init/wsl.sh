[[ -e /proc/version && -n `grep --ignore-case microsoft /proc/version` ]] || return 0;

# link windows user directory to ~/home
win_home_path=$(cmd.exe /c echo %userprofile% 2>/dev/null | tr -d '\r')
win_home_wsl_path=$(wslpath -u "$win_home_path")
ln -s "$win_home_wsl_path" ~/Home


