--------------------------
-- Caching for init.lua --
--------------------------
require('impatient')

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
-- Remap Function Bindings --
-----------------------------
local nmap = maps.nmap
local nnoremap = maps.nnoremap
local noremap = maps.noremap
local vmap = maps.vmap
local vnoremap = maps.vnoremap

-------------
-- Plugins --
-------------
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
require('packer').startup(function()
  use {
    'RRethy/nvim-base16',
    'SmiteshP/nvim-gps',
    'bronson/vim-trailing-whitespace',
    'editorconfig/editorconfig-vim',
    'ellisonleao/carbon-now.nvim',
    'f-person/git-blame.nvim',
    'folke/which-key.nvim',
    'folke/zen-mode.nvim',
    'kevinhwang91/nvim-hlslens',
    'kyazdani42/nvim-tree.lua',
    'kyazdani42/nvim-web-devicons',
    'lewis6991/gitsigns.nvim',
    'lewis6991/impatient.nvim',
    'lukas-reineke/indent-blankline.nvim',
    'm-demare/hlargs.nvim',
    'neovim/nvim-lspconfig',
    'noib3/nvim-cokeline',
    'numToStr/Comment.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
    'nvim-lualine/lualine.nvim',
    'nvim-neorg/neorg',
    'nvim-neorg/neorg-telescope',
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-telescope/telescope.nvim',
    'p00f/nvim-ts-rainbow',
    'petertriho/nvim-scrollbar',
    'rust-lang/rust.vim',
    'simrat39/rust-tools.nvim',
    'wbthomason/packer.nvim',
    'yamatsum/nvim-cursorline',
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    before = "neorg",
    run = ':TSUpdate'
  }
  if packer_bootstrap then
    require('packer').sync()
  end
end)

------------------
-- Vim Settings --
------------------

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
o.formatoptions = 'tcq'
o.hlsearch = true
o.ignorecase = true
o.incsearch = true
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
o.laststatus = 2

if sys.is_linux or sys.is_macos then
  o.undodir = os.getenv('HOME') .. '/.vim/undo-dir'
elseif sys.is_windows then
  o.undodir = fn.stdpath('data') .. '\\undo-dir'
end

-- Window Local
wo.colorcolumn = '101'
wo.list = true
wo.number = true
wo.relativenumber = true
wo.wrap = true
o.foldmethod='expr'
o.foldexpr='nvim_treesitter#foldexpr()'

-- Colorscheme
vim.g.base16colorspace = 256
vim.cmd('colorscheme base16-default-dark')
vim.cmd('filetype plugin indent on')

-- Autocmd
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')
vim.cmd('autocmd BufRead,BufNewFile *.md,*.txt setlocal spell spelllang=en_us')

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
nnoremap('<leader>z','zA')
-- Remove trailing whitespace
nmap('<leader>rtws',':%s/\\s\\+$//e<CR>')


------------------------
-- Nvim Plugin Configs -
------------------------

-- Git Signs - Left sidebar git indicators
require('gitsigns').setup()

-- NvimTree - File navigator sidebar
require('nvim-tree').setup()
nnoremap('<C-n>', ':NvimTreeToggle<CR>')
nnoremap('<leader>r', ':NvimTreeRefresh<CR>')

-- Which Key - Helpful pop up of what keybindings exist
require("which-key").setup()

-- Nvim GPS - status line component to show where you are in a file
require("nvim-gps").setup()
local gps = require("nvim-gps")

-- Lualine - status line plugin
require('lualine').setup({
  extensions = {'nvim-tree'},
  sections = {
    lualine_c = {'filename', { gps.get_location, cond = gps.is_available } },
  },
})

-- Cokeline - Bufferbar plugin
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

-- Indent Blankline - Show indentation and what block your in
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
require('indent_blankline').setup({
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
})

-- NVIM TreeSitter - Treesitter configs
require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }

}
local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
parser_configs.norg_meta = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
        files = { "src/parser.c" },
        branch = "main"
    },
}
parser_configs.norg_table = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
        files = { "src/parser.c" },
        branch = "main"
    },
}

-- Neorg - A newer org mode but for neovim
require('neorg').setup({
    load = {
        ['core.defaults'] = {},
        ['core.integrations.telescope'] = {},
        ['core.integrations.treesitter'] = {},
        ['core.norg.manoeuvre'] = {},
        ['core.presenter'] = {
          config = {
            zen_mode = 'zen-mode',
          }
        },
        ['core.norg.qol.todo_items'] = {},
        ['core.norg.qol.toc'] = {},
        ['core.norg.esupports.metagen'] = {},
        ['core.norg.esupports.hop'] = {},
        ['core.norg.concealer'] = {},
        ['core.norg.news'] = {},
        ['core.norg.journal'] = {},
        ['core.norg.dirman'] = {
            config = {
                workspaces = {
                    notes = '~/notes',
                }
            }
        }

    }
})

-- hlargs - Highlight function args using treesitter
require('hlargs').setup()

-- Rust Tools - Setup lsp and more automatically for rust
require('rust-tools').setup()

-- Carbon Now - Share snippets to Carbon for nice screenshots on the web
require('carbon-now').setup({
  options = {
    theme = "Base16 (Dark)",
    font_family = "Iosevka",
  }
})
vim.keymap.set("v", "<leader>cn", function() require('carbon-now').create_snippet() end, { noremap = true, silent = true})

-- Telescope - Search, file finding, grepping, and more using powerful builtins
require('telescope').setup()
tb = require('telescope.builtin');
nnoremap('<leader>ff', '<cmd> lua tb.find_files()<cr>')
nnoremap('<leader>fg', '<cmd> lua tb.live_grep()<cr>')
nnoremap('<leader>fb', '<cmd> lua tb.buffers()<cr>')
nnoremap('<leader>fh', '<cmd> lua tb.help_tags()<cr>')
nnoremap('<leader>fi', '<cmd> lua tb.current_buffer_fuzzy_find()<cr>')
nnoremap('<leader>ca', '<cmd> lua tb.lsp_code_actions()<cr>')
nnoremap('<leader>gb', '<cmd> lua tb.git_branches()<cr>')
nnoremap('<leader>ts', '<cmd> lua tb.treesitter()<cr>')


-- Zen Mode - Have a moment of zen when writing
require("zen-mode").setup()

-- Scrollbar - Add a scroll bar to neovim
require("scrollbar").setup({
    handle = {
      color = '#b8b8b8',
    },
    handlers = {
        search = true,
    },
})
-- Comment - Comment keymaps for extra powers on what to comment out
require('Comment').setup()

------------------------
-- Vim Plugin Configs --
------------------------
vim.g.rustfmt_autosave = 1
vim.g.rustfmt_recommended_style = 0
vim.g.rust_recommended_style = 0
vim.g.mix_format_on_save = 1
