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
    use 'kyazdani42/nvim-web-devicons'
    use {'pwntester/octo.nvim', config=function()
      require"octo".setup({
        default_remote = {"origin", "upstream"}; -- order to try remotes
        reaction_viewer_hint_icon = "";         -- marker for user reactions
        user_icon = " ";                        -- user icon
        timeline_marker = "";                   -- timeline marker
        timeline_indent = "2";                   -- timeline indentation
        right_bubble_delimiter = "";            -- Bubble delimiter
        left_bubble_delimiter = "";             -- Bubble delimiter
        github_hostname = "";                    -- GitHub Enterprise host
        snippet_context_lines = 4;               -- number or lines around commented lines
        file_panel = {
          size = 10,                             -- changed files panel rows
          use_icons = true                       -- use web-devicons in file panel
        },
        mappings = {
          issue = {
            close_issue = "<space>ic",           -- close issue
            reopen_issue = "<space>io",          -- reopen issue
            list_issues = "<space>il",           -- list open issues on same repo
            reload = "<C-r>",                    -- reload issue
            open_in_browser = "<C-b>",           -- open issue in browser
            copy_url = "<C-y>",                  -- copy url to system clipboard
            add_assignee = "<space>aa",          -- add assignee
            remove_assignee = "<space>ad",       -- remove assignee
            create_label = "<space>lc",          -- create label
            add_label = "<space>la",             -- add label
            remove_label = "<space>ld",          -- remove label
            goto_issue = "<space>gi",            -- navigate to a local repo issue
            add_comment = "<space>ca",           -- add comment
            delete_comment = "<space>cd",        -- delete comment
            next_comment = "]c",                 -- go to next comment
            prev_comment = "[c",                 -- go to previous comment
            react_hooray = "<space>rp",          -- add/remove 🎉 reaction
            react_heart = "<space>rh",           -- add/remove ❤️ reaction
            react_eyes = "<space>re",            -- add/remove 👀 reaction
            react_thumbs_up = "<space>r+",       -- add/remove 👍 reaction
            react_thumbs_down = "<space>r-",     -- add/remove 👎 reaction
            react_rocket = "<space>rr",          -- add/remove 🚀 reaction
            react_laugh = "<space>rl",           -- add/remove 😄 reaction
            react_confused = "<space>rc",        -- add/remove 😕 reaction
          },
        pull_request = {
          checkout_pr = "<space>po",           -- checkout PR
          merge_pr = "<space>pm",              -- merge PR
          list_commits = "<space>pc",          -- list PR commits
          list_changed_files = "<space>pf",    -- list PR changed files
          show_pr_diff = "<space>pd",          -- show PR diff
          add_reviewer = "<space>va",          -- add reviewer
          remove_reviewer = "<space>vd",       -- remove reviewer request
          close_issue = "<space>ic",           -- close PR
          reopen_issue = "<space>io",          -- reopen PR
          list_issues = "<space>il",           -- list open issues on same repo
          reload = "<C-r>",                    -- reload PR
          open_in_browser = "<C-b>",           -- open PR in browser
          copy_url = "<C-y>",                  -- copy url to system clipboard
          add_assignee = "<space>aa",          -- add assignee
          remove_assignee = "<space>ad",       -- remove assignee
          create_label = "<space>lc",          -- create label
          add_label = "<space>la",             -- add label
          remove_label = "<space>ld",          -- remove label
          goto_issue = "<space>gi",            -- navigate to a local repo issue
          add_comment = "<space>ca",           -- add comment
          delete_comment = "<space>cd",        -- delete comment
          next_comment = "]c",                 -- go to next comment
          prev_comment = "[c",                 -- go to previous comment
          react_hooray = "<space>rp",          -- add/remove 🎉 reaction
          react_heart = "<space>rh",           -- add/remove ❤️ reaction
          react_eyes = "<space>re",            -- add/remove 👀 reaction
          react_thumbs_up = "<space>r+",       -- add/remove 👍 reaction
          react_thumbs_down = "<space>r-",     -- add/remove 👎 reaction
          react_rocket = "<space>rr",          -- add/remove 🚀 reaction
          react_laugh = "<space>rl",           -- add/remove 😄 reaction
          react_confused = "<space>rc",        -- add/remove 😕 reaction
        },
        review_thread = {
          goto_issue = "<space>gi",            -- navigate to a local repo issue
          add_comment = "<space>ca",           -- add comment
          add_suggestion = "<space>sa",        -- add suggestion
          delete_comment = "<space>cd",        -- delete comment
          next_comment = "]c",                 -- go to next comment
          prev_comment = "[c",                 -- go to previous comment
          select_next_entry = "]q",            -- move to previous changed file
          select_prev_entry = "[q",            -- move to next changed file
          close_review_tab = "<C-c>",          -- close review tab
          react_hooray = "<space>rp",          -- add/remove 🎉 reaction
          react_heart = "<space>rh",           -- add/remove ❤️ reaction
          react_eyes = "<space>re",            -- add/remove 👀 reaction
          react_thumbs_up = "<space>r+",       -- add/remove 👍 reaction
          react_thumbs_down = "<space>r-",     -- add/remove 👎 reaction
          react_rocket = "<space>rr",          -- add/remove 🚀 reaction
          react_laugh = "<space>rl",           -- add/remove 😄 reaction
          react_confused = "<space>rc",        -- add/remove 😕 reaction
        },
        submit_win = {
          approve_review = "<C-a>",            -- approve review
          comment_review = "<C-m>",            -- comment review
          request_changes = "<C-r>",           -- request changes review
          close_review_tab = "<C-c>",          -- close review tab
        },
        review_diff = {
          add_review_comment = "<space>ca",    -- add a new review comment
          add_review_suggestion = "<space>sa", -- add a new review suggestion
          focus_files = "<leader>e",           -- move focus to changed file panel
          toggle_files = "<leader>b",          -- hide/show changed files panel
          next_thread = "]t",                  -- move to next thread
          prev_thread = "[t",                  -- move to previous thread
          select_next_entry = "]q",            -- move to previous changed file
          select_prev_entry = "[q",            -- move to next changed file
          close_review_tab = "<C-c>",          -- close review tab
          toggle_viewed = "<leader><space>",   -- toggle viewer viewed state
        },
        file_panel = {
          next_entry = "n",                    -- move to next changed file
          prev_entry = "e",                    -- move to previous changed file
          select_entry = "<cr>",               -- show selected changed file diffs
          refresh_files = "R",                 -- refresh changed files panel
          focus_files = "<leader>e",           -- move focus to changed file panel
          toggle_files = "<leader>b",          -- hide/show changed files panel
          select_next_entry = "]q",            -- move to previous changed file
          select_prev_entry = "[q",            -- move to next changed file
          close_review_tab = "<C-c>",          -- close review tab
          toggle_viewed = "<leader><r>",   -- toggle viewer viewed state
        }
      }})
    end}
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use {
      'nvim-lua/completion-nvim',
      requires = {}
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
o.autoindent = true
o.autoread = true
o.autowrite = true
o.backspace = 'indent,eol,start'
o.backupcopy = 'yes'
o.compatible = false
o.completeopt = "menuone,noinsert,noselect"
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
gset('airline_powerline_fonts', 1)

-------------------
-- Octo Settings --
-------------------
