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
