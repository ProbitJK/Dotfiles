#!/usr/bin/bash
du -a ~/.local/bin/  /usr/local/bin/ /usr/local/sbin/ /usr/bin/ /usr/sbin/ | awk '{print $2}' | /home/probit/misc_code/fzf/bin/fzf --border --cycle --reverse --padding 3% --no-info --prompt='  ' --pointer=' ' --color='fg+:#11111b,bg+:#f5c2e7,hl+:#8839ef,fg:#f5e0dc,bg:#1e1e2e,hl:#fe640b,query:#eebebe,gutter:#181825,prompt:#1e66f5,pointer:#8839ef' | xargs -r swaymsg exec --
