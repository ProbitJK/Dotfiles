#!/bin/bash

cd /home/probit/
swaymsg exec nohup zathura $(fd -H -c never '^.*\.pdf$' | fzf --multi --keep-right --border --cycle --reverse --padding 3% --no-info --prompt='Choose PDF: ' --pointer=' ' --color='fg+:#11111b,bg+:#f5c2e7,hl+:#8839ef,fg:#f5e0dc,bg:#1e1e2e,hl:#fe640b,query:#eebebe,gutter:#181825,prompt:#a6e3a1,pointer:#8839ef' | sed 's/\s/\\ /g') >/dev/null 2>&1
