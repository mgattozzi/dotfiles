# ZSH Options

## Rebinds

# Delete Key
bindkey "^[[3~" delete-char
# Home Key
bindkey "^[[1~" beginning-of-line
# End Key
bindkey "^[[4~" end-of-line

# End
# Home
## History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000000000
SAVEHIST=1000000000
# Treat the '!' character specially during expansion.
setopt BANG_HIST
# Write the history file in the ":start:elapsed;command" format.
setopt EXTENDED_HISTORY
# Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY
# Share history between all sessions.
setopt SHARE_HISTORY
# Expire duplicate entries first when trimming history.
setopt HIST_EXPIRE_DUPS_FIRST
# Don't record an entry that was just recorded again.
setopt HIST_IGNORE_DUPS
# Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_ALL_DUPS
# Do not display a line previously found.
setopt HIST_FIND_NO_DUPS
# Don't record an entry starting with a space.
setopt HIST_IGNORE_SPACE
# Don't write duplicate entries in the history file.
setopt HIST_SAVE_NO_DUPS
# Remove superfluous blanks before recording entry.
setopt HIST_REDUCE_BLANKS
# Don't execute immediately upon history expansion.
setopt HIST_VERIFY
# Beep when accessing nonexistent history.
setopt HIST_BEEP

## Functions
fpath+=${ZDOTDIR:-~}/.zsh_functions

# Personal Configurations
autoload -U colors && colors
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
base16_default-dark

# Source Other Files
source $HOME/.zshrc.d/fzf.zsh
source $HOME/.private.zsh
source $HOME/.work.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/michael/.google-cloud-sdk/google-cloud-sdk/path.zsh.inc' ]; then . '/home/michael/.google-cloud-sdk/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/michael/.google-cloud-sdk/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/michael/.google-cloud-sdk/google-cloud-sdk/completion.zsh.inc'; fi

# Environment Variables
export EDITOR='nvim'
export GOPATH="$HOME/.go"
export GOPATH_BIN="$HOME/.go/bin"
export FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
export FZF_DEFAULT_COMMAND='fd -HI --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export TERM=xterm-256color
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
export XDG_RUNTIME_DIR=/run/user/$(id -u)

## Path Env Var
function p() {
  export PATH=$PATH:$1
}
p $HOME/.local/bin
p $HOME/.cargo/bin
p $ANDROID_HOME/tools
p $ANDROID_HOME/tools/bin
p $ANDROID_HOME/platform-tools
p $ANDROID_HOME/emulator
p $GOPATH
p $GOPATH_BIN
p /usr/bin:/usr/local/bin
p $HOME/.bin
p $HOME/.gem/ruby/2.7.0/bin
p $HOME/dev-suite/target/debug

# Aliases
alias ls="exa"
alias nedit="nvim $HOME/.config/nvim/init.lua"

## WSL2
alias pbcopy='/mnt/c/Windows/System32/clip.exe'

## Git Aliases
alias gprune='git prune && git remote prune origin'

## Neovim Aliases
alias vim='nvim'
alias vimf='nvim $(fzf)'
alias vi='nvim'
alias rmswap='rm $HOME/.local/share/nvim/swap/*'

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach -t default || tmux new -s default
fi

eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
