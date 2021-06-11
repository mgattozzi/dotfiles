# Setup fzf
# ---------
if [[ ! "$PATH" == */home/michael/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/michael/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/michael/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/michael/.fzf/shell/key-bindings.zsh"

export FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
export FZF_DEFAULT_COMMAND='fd -HI --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
