# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

export LD_LIBRARY_PATH=$HOME/misc_code/MultiNest/lib:$LD_LIBRARY_PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc
# make ls better
alias ls="exa -a"
alias ll="exa -lahF"
alias fkill="kill_fzf"
# use fzf to move to different folders fast
bind '"\C-f":"cd_fzf\n"'
bind '"\C-o":"open_fzf\n"'
# sync calendar using calcurse-caldav
alias calsync='CALCURSE_CALDAV_PASSWORD=$(pass show probitjkalita@disroot.org) calcurse-caldav'
# make ripgrep better
alias rg="rg -i -p -. -L"
eval "$(starship init bash)"

# functions
cd_fzf(){
    dest=`fd -H -t d . $HOME | rg -N --color never -v .git | fzf --preview="tree -L 2 {}" --bind="space:toggle-preview" --border --reverse --color='fg+:#11111b,bg+:#f5c2e7,hl+:#8839ef,fg:#f5e0dc,bg:#1e1e2e,hl:#fe640b,query:#eebebe,gutter:#181825,prompt:#1e66f5,pointer:#8839ef'` && cd "$dest"
}
open_fzf(){
    fd -H -t f . ~/PhD_work/ ~/Documents/ ~/misc_code/ ~/.config/ ~ | rg -N --color never -v .git | fzf --preview="bat --style=full --color=always {}" --border --reverse --color='fg+:#11111b,bg+:#f5c2e7,hl+:#8839ef,fg:#f5e0dc,bg:#1e1e2e,hl:#fe640b,query:#eebebe,gutter:#181825,prompt:#1e66f5,pointer:#8839ef' | xargs -r nvim
}
kill_fzf(){
    ps aux |  fzf --border --reverse --color='fg+:#11111b,bg+:#f5c2e7,hl+:#8839ef,fg:#f5e0dc,bg:#1e1e2e,hl:#fe640b,query:#eebebe,gutter:#181825,prompt:#1e66f5,pointer:#8839ef' | awk '{print $2}' | xargs kill -9
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

minfetch
