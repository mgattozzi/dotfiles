--Gfp-----------------
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
    use 'ElmCast/elm-vim'
    use 'LnL7/vim-nix'
    use 'airblade/vim-gitgutter'
    use 'bronson/vim-trailing-whitespace'
    use 'cespare/vim-toml'
    use 'chriskempson/base16-vim'
    use 'editorconfig/editorconfig-vim'
    use 'elixir-editors/vim-elixir'
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
    use 'neovim/nvim-lspconfig'
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use {
      'nvim-lua/completion-nvim',
      requires = {}
    }
end)
---------------------
-- Package Imports --
---------------------
local lspconfig = require('lspconfig')
local completion = require('completion')
-------------------------
-- Completion Settings --
-------------------------
execute([[
  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
]])
------------------
-- LSP Settings --
------------------
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- LSP Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end

  completion.on_attach()
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = { "rust_analyzer" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

------------------
-- Vim Settings --
------------------
-- global
o.autoread = true
o.autowrite = true
o.backspace = 'indent,eol,start'
o.backupcopy = 'yes'
o.hlsearch = true
o.ignorecase = true
o.incsearch = true
o.lcs = 'tab:/|/,space:·'
o.compatible = false
o.showmatch = true
o.smartcase = true
o.timeoutlen = 1000
o.ttimeoutlen = 0
o.completeopt = "menuone,noinsert,noselect"
o.shortmess = "Sc"

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

-- buffer-local
bo.autoindent = true
bo.expandtab = true
bo.fileencoding = 'UTF-8'
bo.formatoptions = 'tcq'
bo.shiftwidth = 2
bo.smartindent = true
bo.softtabstop = 2
bo.syntax = 'on'
bo.tabstop = 2
bo.textwidth = 80
bo.undofile = true

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

------------------------
-- Telescope Settings --
------------------------
local tb = "<cmd>lua require('telescope.builtin')."
nmap('<leader>ff', tb..'find_files()<cr>')
nmap('<leader>fg', tb..'live_grep()<cr>')
nmap('<leader>fb', tb..'buffer()<cr>')
nmap('<leader>fh', tb..'help_tags()<cr>')
nmap('<leader>la', tb..'lsp_code_actions()<cr>')
vmap('<leader>la', tb..'lsp_code_actions()<cr>')

-------------------
-- Rust Settings --
-------------------
vim.g.rustfmt_autosave = 1
vim.g.rustfmt_recommended_style = 0
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
gset('airline_powerline_fonts', 1)
