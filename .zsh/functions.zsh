print_colors() {
    for x in {0..8}; do
        for i in {30..37}; do
            for a in {40..47}; do
                echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
            done
            echo
        done
    done
    echo ""
}

# Notify on long-running commands (>5s) via kitty OSC 99
# __cmd_start=0
# __cmd_name=""
# preexec() { __cmd_start=$EPOCHSECONDS; __cmd_name="${1%% *}"; }
# precmd() {
#   (( __cmd_start > 0 && EPOCHSECONDS - __cmd_start >= 5 )) && {
#     local msg="$__cmd_name finished"
#     if [[ -n "$TMUX" ]]; then
#       printf '\033Ptmux;\033\033]99;;%s\033\033\\\033\\' "$msg"
#     else
#       printf '\033]99;;%s\033\\' "$msg"
#     fi
#   }
#   __cmd_start=0
# }
