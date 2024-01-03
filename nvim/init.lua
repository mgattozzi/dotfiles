-- Plugin loader
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-------------
-- Plugins --
-------------
vim.g.mapleader = " "
require('lazy').setup({
    {
      'RRethy/nvim-base16',
      config = function()
        -- Colorscheme
        vim.o.termguicolors = true
        vim.g.base16colorspace = 256
        vim.cmd('colorscheme base16-default-dark')
      end
    },
    'editorconfig/editorconfig-vim',
    'f-person/git-blame.nvim',
    {
      "folke/trouble.nvim",
      config = function()
        local nnoremap = require('maps').nnoremap
        require('trouble').setup()
        nnoremap('<leader>xx','<cmd>TroubleToggle<cr>')
        nnoremap('<leader>xw','<cmd>TroubleToggle workspace_diagnostics<cr>')
        nnoremap('<leader>xd','<cmd>TroubleToggle document_diagnostics<cr>')
        nnoremap('<leader>xq','<cmd>TroubleToggle quickfix<cr>')
        nnoremap('<leader>xl','<cmd>TroubleToggle loclist<cr>')
      end
    },
    {
      'kevinhwang91/nvim-hlslens',
      config = function()
        require('hlslens').setup()
      end
    },
    {
      'kyazdani42/nvim-tree.lua',
      config = function()
        local nnoremap = require('maps').nnoremap
        require('nvim-tree').setup()
        nnoremap('<C-n>', ':NvimTreeToggle<CR>')
        nnoremap('<leader>r', ':NvimTreeRefresh<CR>')
      end
    },
    'kyazdani42/nvim-web-devicons',
    {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup()
      end
    },
    {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('ibl').setup()
      end
    },
    {
      'm-demare/hlargs.nvim',
      config = function()
        require('hlargs').setup()
      end
    },
    {
      'neovim/nvim-lspconfig',
      config = function()
      end
    },
    {
      'noib3/nvim-cokeline',
      config = function()
        require('cokeline').setup({
          sidebar = {
            filetype = 'NvimTree',
            components = {
              {
                text = '  NvimTree',
                style = 'bold',
              },
            }
          },
        })
      end
    },
    {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    },
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
    {
      'nvim-lualine/lualine.nvim',
      config = function()
        require('lualine').setup({
          extensions = {'nvim-tree'},
          sections = {
            lualine_c = {'filename'},
          },
        })
      end
    },
    'nvim-telescope/telescope-ui-select.nvim',
    {
      'nvim-telescope/telescope.nvim',
      config = function()
        local nnoremap = require('maps').nnoremap
        require('telescope').setup()
        require('telescope').load_extension('notify')
        require("telescope").load_extension("ui-select")
        tb = require('telescope.builtin');
        nnoremap('<leader>ff', '<cmd> lua tb.find_files()<cr>')
        nnoremap('<leader>fg', '<cmd> lua tb.live_grep()<cr>')
        nnoremap('<leader>fb', '<cmd> lua tb.buffers()<cr>')
        nnoremap('<leader>fh', '<cmd> lua tb.help_tags()<cr>')
        nnoremap('<leader>fi', '<cmd> lua tb.current_buffer_fuzzy_find()<cr>')
        nnoremap('<leader>ca', '<cmd> lua vim.lsp.buf.code_action()<cr>')
        nnoremap('<leader>gb', '<cmd> lua tb.git_branches()<cr>')
        nnoremap('<leader>ts', '<cmd> lua tb.treesitter()<cr>')
      end
    },
    {
      'petertriho/nvim-scrollbar',
      config = function()
        require('scrollbar').setup({
            handle = {
              color = '#b8b8b8',
            },
            handlers = {
                search = true,
            },
        })
      end
    },
    {
      'rust-lang/rust.vim',
    },
    {
      'simrat39/rust-tools.nvim',
      config = function()
        local opts = {
          tools = {
            runnables = {
              use_telescope = true,
            },
            inlay_hints = {
              auto = true,
              show_parameter_hints = false,
              parameter_hints_prefix = "",
              other_hints_prefix = "",
            },
          },
          server = {
            on_attach = on_attach,
            settings = {
              ["rust-analyzer"] = {
                checkOnSave = {
                  command = "clippy",
                },
              },
            },
          },
        }
        require("rust-tools").setup(opts)
      end
    },
    'yamatsum/nvim-cursorline',
    {
      'rcarriga/nvim-notify',
      config = function()
        vim.notify = require('notify')
      end
    },
    {
      "j-hui/fidget.nvim",
      tag = "legacy",
      event = "LspAttach",
      config = function()
        require("fidget").setup()
      end
    },
    { 
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        require('nvim-treesitter.configs').setup {
          ensure_installed = "all",
          highlight = {
            enable = true,
          },
        }
      end
    },
    {
      url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
      config = function()
        require('lsp_lines').setup()
        vim.diagnostic.config({
          virtual_text = false
        })
      end
    },
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end
    },
    {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require("mason-lspconfig").setup()
        require("lspconfig").rust_analyzer.setup {}
        require("lspconfig").gopls.setup {}
      end
    }
})

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
local g = vim.g

-----------------------------
-- Remap Function Bindings --
-----------------------------
local nmap = maps.nmap
local nnoremap = maps.nnoremap
local noremap = maps.noremap
local vmap = maps.vmap
local vnoremap = maps.vnoremap

------------------
-- Vim Settings --
------------------

-- Undo History
if sys.is_linux or sys.is_macos then
  o.undodir = os.getenv('HOME') .. '/.vim/undo-dir'
elseif sys.is_windows then
  o.undodir = fn.stdpath('data') .. '\\undo-dir'
end
if fs.does_not_exist(o.undodir) and (sys.is_linux or sys.is_macos) then
  os.execute('mkdir -p' .. o.undodir .. '-m=0770')
elseif fs.does_not_exist(o.undodir) and sys.is_windows then
  os.execute('mkdir ' .. o.undodir)
end

-- Autocmd
vim.cmd('filetype plugin indent on')
vim.cmd('autocmd BufRead,BufNewFile *.md,*.txt setlocal spell spelllang=en_us')

-- Global
o.autoindent = true
o.autoread = true
o.autowrite = true
o.backspace = 'indent,eol,start'
o.backupcopy = 'yes'
o.compatible = false
o.completeopt = "menu,menuone,noselect"
o.expandtab = true
o.fileencoding = 'UTF-8'
o.foldenable = false
o.foldexpr='nvim_treesitter#foldexpr()'
o.foldmethod='expr'
o.formatoptions = 'tcq'
o.hlsearch = true
o.ignorecase = true
o.incsearch = true
o.laststatus = 2
o.shiftwidth = 2
o.shortmess = "Sc"
o.showmatch = true
o.smartcase = true
o.smartindent = true
o.softtabstop = 2
o.tabstop = 2
o.termguicolors = true
o.textwidth = 80
o.timeoutlen = 1000
o.ttimeoutlen = 0
o.undofile = true

g.mix_format_on_save = 1
g.rust_recommended_style = 0
g.rustfmt_autosave = 1
g.rustfmt_recommended_style = 0

-- Window Local
wo.colorcolumn = '101'
wo.list = true
wo.number = true
wo.relativenumber = true
wo.wrap = true

-- Colemak Remaps
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
nnoremap('<leader>z','zA')
-- Remove trailing whitespace
nmap('<leader>rtws',':%s/\\s\\+$//e<CR>')
