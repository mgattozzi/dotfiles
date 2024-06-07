# Remove any existing configs and symlink the dotfiles
mkdir ~/.config/nushell

rm -f ~/.config/nushell/config.nu
rm -f ~/.config/nushell/env.nu
ln -s (pwd | $in ++ /nushell/config.nu) ~/.config/nushell/config.nu
ln -s (pwd | $in ++ /nushell/env.nu) ~/.config/nushell/env.nu

rm -f ~/.tmux.conf
ln -s (pwd | $in ++ /tmux.conf) ~/.tmux.conf

rm -f ~/.lesskey
ln -s (pwd | $in ++ /lesskey) ~/.lesskey

rm -f ~/.gitconfig
ln -s (pwd | $in ++ /gitconfig) ~/.gitconfig

rm -f ~/.config/nvim
ln -s (pwd | $in ++ /nvim) ~/.config/nvim

rm -f ~/.alacritty.toml
ln -s (pwd | $in ++ /alacritty.toml) ~/.alacritty.toml

rm -f ~/.config/topgrade.toml
ln -s (pwd | $in ++ /topgrade.toml) ~/.config/topgrade.toml
