# Setup Color Theme
autoload -U colors && colors
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
base16_default-dark

# Source Configuration Options
source "$HOME/.zshrc.d/env.zsh"
source "$HOME/.zshrc.d/functions.zsh"
source "$HOME/.zshrc.d/fzf.zsh"
source "$HOME/.zshrc.d/gcloud.zsh"
source "$HOME/.zshrc.d/history.zsh"
source "$HOME/.zshrc.d/key_bindings.zsh"
source "$HOME/.zshrc.d/path.zsh"
source "$HOME/.zshrc.d/private.zsh"
source "$HOME/.zshrc.d/work.zsh"

# If not in tmux start it up and if we're in tmux skip
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach -t default || tmux new -s default
fi

# Setup the prompt
eval "$(starship init zsh)"
