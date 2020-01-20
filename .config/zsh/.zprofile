# start X at login on first console or otherwise source ~/.profile
if [[ -z "$DISPLAY" && "$XDG_VTNR" -eq 1 ]] && which /bin/sx > /dev/null; then
    exec sx ~/.xsession
else
    source ~/.profile
fi
