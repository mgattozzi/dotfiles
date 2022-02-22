-------------------
-- Local Imports --
-------------------
local fs = require('fs')
local maps = require('maps')
local sys = require('sys')

-----------------------------
-- NeoVim Function Binding --
-----------------------------
local execute = vim.api.nvim_command
local fn = vim.fn
local o = vim.o
local wo = vim.wo
local bo = vim.bo

-----------------------------
-- Import Function Binding --
-----------------------------
local nmap = maps.nmap
local nnoremap = maps.nnoremap
local noremap = maps.noremap
local vmap = maps.vmap
local vnoremap = maps.vnoremap

-------------------
-- Load Packages --
-------------------

-- Make sure packer is installed before executing the rest of the script
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fs.does_not_exist(install_path) then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
else
  vim.cmd [[packadd packer.nvim]]
end
local packer = require('packer')

---------------------
-- Packer Settings --
---------------------

packer.startup(function()
    use {'wbthomason/packer.nvim', opt = true}
    -- Packages
    use 'airblade/vim-gitgutter'
    use 'bronson/vim-trailing-whitespace'
    use 'cespare/vim-toml'
    use 'chriskempson/base16-vim'
    use 'editorconfig/editorconfig-vim'
    use {
      'junegunn/fzf.vim',
      requires = {{'junegunn/fzf', hook='./install --all' }}
    }
    use 'mhinz/vim-mix-format'
    use 'rust-lang/rust.vim'
    use 'tbastos/vim-lua'
    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive'
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'tpope/vim-abolish'
    use 'neovim/nvim-lspconfig'
    use 'simrat39/rust-tools.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'},
        {'nvim-telescope/telescope-ui-select.nvim' }
      }
    }
    use {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup {}
      end
    }
end)

---------------------
-- Package Imports --
---------------------
local lspconfig = require('lspconfig')

------------------
-- LSP Settings --
------------------
require('rust-tools').setup({})

------------------
-- Vim Settings --
------------------
-- global
o.autoindent = true
o.autoread = true
o.autowrite = true
o.backspace = 'indent,eol,start'
o.backupcopy = 'yes'
o.compatible = false
o.completeopt = "menu,menuone,noselect"
o.expandtab = true
o.fileencoding = 'UTF-8'
o.formatoptions = 'tcq'
o.hlsearch = true
o.ignorecase = true
o.incsearch = true
o.lcs = 'tab:/|/,space:·'
o.shiftwidth = 2
o.shortmess = "Sc"
o.showmatch = true
o.smartcase = true
o.smartindent = true
o.softtabstop = 2
o.syntax = 'on'
o.tabstop = 2
o.textwidth = 80
o.timeoutlen = 1000
o.ttimeoutlen = 0
o.undofile = true

if sys.is_linux or sys.is_macos then
  o.undodir = os.getenv('HOME') .. '/.vim/undo-dir'
elseif sys.is_windows then
  o.undodir = fn.stdpath('data') .. '\\undo-dir'
end

o.laststatus = 2

-- window-local
wo.colorcolumn = '101'
wo.list = true
wo.number = true
wo.relativenumber = true
wo.wrap = true

-- Colorscheme
vim.g.base16colorspace = 256
vim.cmd('colorscheme base16-default-dark')
vim.cmd('filetype plugin indent on')

-- Autocmd
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')
vim.cmd('autocmd BufRead,BufNewFile *.md,*.txt setlocal spell spelllang=en_us')
vim.cmd('autocmd BufRead,BufNewFile *.htm,*.html setlocal tabstop=2 shiftwidth=2 softtabstop=2')

-- Keep undo history across sessions by storing it in a file
if fs.does_not_exist(o.undodir) and (sys.is_linux or sys.is_macos) then
  os.execute('mkdir -p' .. o.undodir .. '-m=0770')
elseif fs.does_not_exist(o.undodir) and sys.is_windows then
  os.execute('mkdir ' .. o.undodir)
end

-- Colemak Remaps
vim.g.mapleader = " "
noremap('n','gj')
noremap('e','gk')
noremap('i','l')
vnoremap('n','gj')
vnoremap('e','gk')
vnoremap('i','l')
nnoremap(';',':')
nnoremap('<leader>i','i')
nnoremap('<leader>n','n')
nnoremap('<leader>o','o')
nnoremap('<leader>o',':')

-- Window Remaps
noremap('<A-n>','<C-w>j')
noremap('<A-e>','<C-w>k')
noremap('<A-h>','<C-w>h')
noremap('<A-i>','<C-w>l')
noremap('<A-s>','<C-w>s')
noremap('<A-v>','<C-w>v')

-- Convenience
nnoremap('<leader><leader>','<ESC>')
vnoremap('<leader><leader>','<ESC>')
nnoremap('<leader><space>',':noh<cr>')
nmap('<leader>bn',':bnext<CR>')
nmap('<leader>bd',':bdelete<CR>')
nmap('<leader>bp',':bprevious<CR>')
nnoremap('<leader>gfp',':Gfp<CR>')
nnoremap('<leader>rg',':Rg<CR>')
-- Remove trailing whitespace
nmap('<leader>rtws',':%s/\\s\\+$//e<CR>')

-------------------
-- Rust Settings --
-------------------
vim.g.rustfmt_autosave = 1
vim.g.rustfmt_recommended_style = 0
vim.g.rust_recommended_style = 0
vim.g.mix_format_on_save = 1

------------------
-- FZF Settings --
------------------
-- Search files with ripgrep to select from
vim.cmd([[command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --no-heading --line-number --color=always -- '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)]])
-- Show gitfiles with preview and select
vim.cmd([[command! -bang -nargs=* Gfp call fzf#vim#gitfiles('', fzf#vim#with_preview('right'))]])

--------------------------
-- Vim-Airline Settings --
--------------------------
local a = 'airline#extensions#'
local gset = vim.api.nvim_set_var
gset(a..'tabline#enabled', 1)
gset(a..'branch#enabled', 1)
gset(a..'branch#empty_message', '')
gset(a..'branch#use_vcscommand', 0)
gset(a..'branch#displayed_head_limit', 10)
gset(a..'branch#format', 0)
gset(a..'hunks#enabled', 1)
gset(a..'hunks#non_zero_only', 0)
gset(a..'hunks#hunk_symbols', "['+', '~', '-']")
vim.cmd([[let g:airline_theme='base16']])
gset('airline_powerline_fonts', 1)

