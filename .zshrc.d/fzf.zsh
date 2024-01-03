# Setup fzf
# ---------
source /usr/share/doc/fzf/examples/key-bindings.zsh
export FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
export FZF_DEFAULT_COMMAND='fd -HI --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
