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
# use fzf to move to different folders fast
bind '"\C-f":"cd_fzf\n"'
bind '"\C-o":"open_fzf\n"'
# fzf aliases for faster searches
#alias nva="du -a ~/PhD_work/ ~/Documents/ ~/misc_code/ ~/.config/ ~/.bashrc | awk '{print \$2}' | fzf --preview 'cat {}' --border --reverse --color='fg+:#11111b,bg+:#f5c2e7,hl+:#8839ef,fg:#f5e0dc,bg:#1e1e2e,hl:#fe640b,query:#eebebe,gutter:#181825,prompt:#1e66f5,pointer:#8839ef,preview-fg:#1e1e2e,preview-bg:#f5c2e7' | xargs -r nvim"
#alias nvh="du -a | awk '{print \$2}' | fzf --preview 'w3m {}' --border --reverse --color='fg+:#11111b,bg+:#f5c2e7,hl+:#8839ef,fg:#f5e0dc,bg:#1e1e2e,hl:#fe640b,query:#eebebe,gutter:#181825,prompt:#1e66f5,pointer:#8839ef,preview-fg:#1e1e2e,preview-bg:#f5c2e7' | xargs -r nvim"
# make ripgrep better
alias rg="rg -i -p -. -L"
eval "$(starship init bash)"

# functions
cd_fzf(){
    cd $HOME && cd "$(fd -H -t d | rg -N --color never -. -v .git | fzf --preview="tree -L 2 {}" --bind="space:toggle-preview" --border --reverse --color='fg+:#11111b,bg+:#f5c2e7,hl+:#8839ef,fg:#f5e0dc,bg:#1e1e2e,hl:#fe640b,query:#eebebe,gutter:#181825,prompt:#1e66f5,pointer:#8839ef')"
}
open_fzf(){
    fd -H -t f . ~/PhD_work/ ~/Documents/ ~/misc_code/ ~/.config/ ~ | rg -N --color never -. -v .git | fzf --preview="bat --style=full --color=always {}" --border --reverse --color='fg+:#11111b,bg+:#f5c2e7,hl+:#8839ef,fg:#f5e0dc,bg:#1e1e2e,hl:#fe640b,query:#eebebe,gutter:#181825,prompt:#1e66f5,pointer:#8839ef' | xargs -r nvim
}

# onefetch to give quickview of git repository everytime we enter a git repository
last_repository=
check_directory_for_new_repository() {
	current_repository=$(git rev-parse --show-toplevel 2> /dev/null)
	
	if [ "$current_repository" ] && \
	   [ "$current_repository" != "$last_repository" ]; then
		onefetch -c 4
	fi
	last_repository=$current_repository
}
cd() {
	builtin cd "$@"
	check_directory_for_new_repository
}

# optional, greet also when opening shell directly in repository directory
# adds time to startup
check_directory_for_new_repository

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/probit/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/probit/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/probit/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/probit/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
