# Setup Color Theme
autoload -U colors && colors
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
base16_default-dark

# Source Configuration Options
for f in $HOME/.zshrc.d/*; do
  source $f;
done

# If not in tmux start it up and if we're in tmux skip
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach -t default || tmux new -s default
fi

# Setup broot
source /home/michael/.config/broot/launcher/bash/br

# Setup zoxide
eval "$(zoxide init zsh)"

# Setup the prompt
eval "$(starship init zsh)"

