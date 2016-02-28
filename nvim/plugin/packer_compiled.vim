" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/home/michael/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/michael/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/michael/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/michael/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/michael/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, err = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(err)
  end
end

_G.packer_plugins = {
  ["base16-vim"] = {
    loaded = true,
    path = "/home/michael/.local/share/nvim/site/pack/packer/start/base16-vim"
  },
  ["coc.nvim"] = {
    loaded = true,
    path = "/home/michael/.local/share/nvim/site/pack/packer/start/coc.nvim"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/home/michael/.local/share/nvim/site/pack/packer/start/editorconfig-vim"
  },
  ["elm-vim"] = {
    loaded = true,
    path = "/home/michael/.local/share/nvim/site/pack/packer/start/elm-vim"
  },
  fzf = {
    loaded = true,
    path = "/home/michael/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["packer.nvim"] = {
    loaded = false,
    path = "/home/michael/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["rust.vim"] = {
    loaded = true,
    path = "/home/michael/.local/share/nvim/site/pack/packer/start/rust.vim"
  },
  ["vim-airline"] = {
    loaded = true,
    path = "/home/michael/.local/share/nvim/site/pack/packer/start/vim-airline"
  },
  ["vim-airline-themes"] = {
    loaded = true,
    path = "/home/michael/.local/share/nvim/site/pack/packer/start/vim-airline-themes"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/michael/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-elixir"] = {
    loaded = true,
    path = "/home/michael/.local/share/nvim/site/pack/packer/start/vim-elixir"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/michael/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/home/michael/.local/share/nvim/site/pack/packer/start/vim-gitgutter"
  },
  ["vim-lua"] = {
    loaded = true,
    path = "/home/michael/.local/share/nvim/site/pack/packer/start/vim-lua"
  },
  ["vim-mix-format"] = {
    loaded = true,
    path = "/home/michael/.local/share/nvim/site/pack/packer/start/vim-mix-format"
  },
  ["vim-nix"] = {
    loaded = true,
    path = "/home/michael/.local/share/nvim/site/pack/packer/start/vim-nix"
  },
  ["vim-toml"] = {
    loaded = true,
    path = "/home/michael/.local/share/nvim/site/pack/packer/start/vim-toml"
  },
  ["vim-trailing-whitespace"] = {
    loaded = true,
    path = "/home/michael/.local/share/nvim/site/pack/packer/start/vim-trailing-whitespace"
  }
}

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
