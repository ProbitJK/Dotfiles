#!/usr/bin/bash

tmux attach -t $(tmux ls | fzf | awk '{print $1}' | sed 's/://') 
