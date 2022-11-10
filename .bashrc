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
alias ls="ls -a --color=auto"
alias ll="ls -lahF --color=auto"
alias vim="nvim"
# Run Joplin from terminal directly using the command 'joplin'
alias joplin="/var/lib/flatpak/app/net.cozic.joplin_desktop/current/active/files/joplin-desktop/joplin &"

eval "$(starship init bash)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/(user_name)/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/(user_name)/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/(user_name)/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/(user_name)/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
