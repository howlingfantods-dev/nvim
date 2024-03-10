-- Escape from insert mode by typing 'jk'
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true })

-- Share the Neovim clipboard with the system clipboard
vim.opt.clipboard = "unnamedplus"

-- Enable relative line numbers
vim.wo.relativenumber = true
-- keep 18 lines of context around the cursor when scrolling
vim.opt.scrolloff = 18

-- Set the number of spaces a tab character represents
vim.opt.tabstop = 2
-- Set the number of spaces inserted for a tab in insert mode
vim.opt.softtabstop = 2
-- Convert tabs to spaces
vim.opt.expandtab = true

-- Set the number of spaces to use for each step of (auto)indent
vim.opt.shiftwidth = 1
-- Set the maximum width of text before it wraps
vim.opt.textwidth = 80

-- Highlight matches as you type during search
vim.opt.incsearch = true

-- Do not highlight all matches after search
vim.opt.hlsearch = false

-- Set delay time for triggering plugins and showing messages in milliseconds
vim.opt.updatetime = 300

-- Display a vertical line at column 80 as a guide
vim.opt.colorcolumn = "80"
--    Always show the sign column
vim.opt.signcolumn = "yes"

-- Move selected lines down with 'J' in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- Move selected lines up with 'K' in visual mode
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Disable the 'Q' command in normal mode (Ex mode)
vim.keymap.set("n", "Q", "<nop>")

-- Set <space> as the global leader key and local leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- disabled nvim suspension
vim.api.nvim_set_keymap('n', '<C-z>', '<Nop>', { noremap = true, silent = true })

-- Remap Escape to act like Ctrl+C
vim.api.nvim_set_keymap('i', '<Esc>', '<C-c>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Esc>', '<C-c>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Esc>', '<C-c>', { noremap = true, silent = true })

-- Disable Copilot with <leader>x
vim.keymap.set("n", "<leader>x", ":Copilot disable<CR>", { noremap = true, silent = true })

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Make line numbers default
vim.wo.number = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
 vim.fn.system {
  'git',
  'clone',
  '--filter=blob:none',
  'https://github.com/folke/lazy.nvim.git',
  '--branch=stable', -- latest stable release
  lazypath,
 }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
 'tpope/vim-fugitive',
 'tpope/vim-rhubarb',
 'tpope/vim-sleuth',
 'tpope/vim-dadbod',
 'kristijanhusak/vim-dadbod-ui',

 {
  'numToStr/Comment.nvim',
  lazy = false,
  config = function()
   require('Comment').setup()
  end,
 },
 {
  'VonHeikemen/fine-cmdline.nvim',
 },
 -- NOTE: This is where your plugins related to LSP can be installed.
 --  The configuration is done below. Search for lspconfig to find it below.
 {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
   -- Automatically install LSPs to stdpath for neovim
   { 'williamboman/mason.nvim', config = true },
   'williamboman/mason-lspconfig.nvim',

   -- Useful status updates for LSP
   -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
   { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

   -- Additional lua configuration, makes nvim stuff amazing!
   'folke/neodev.nvim',
  },
 },

 {
  "christoomey/vim-tmux-navigator",
  cmd = {
   "TmuxNavigateLeft",
   "TmuxNavigateDown",
   "TmuxNavigateUp",
   "TmuxNavigateRight",
   "TmuxNavigatePrevious",
  },
  keys = {
   { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
   { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
   { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
   { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
   { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
 },
 {
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  dependencies = {
   -- Snippet Engine & its associated nvim-cmp source
   'L3MON4D3/LuaSnip',
   'saadparwaiz1/cmp_luasnip',

   -- Adds LSP completion capabilities
   'hrsh7th/cmp-nvim-lsp',

   -- Adds a number of user-friendly snippets
   'rafamadriz/friendly-snippets',
  },
 },
 {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
   require('nvim-autopairs').setup {}
  end
 },

 {
  'numToStr/Comment.nvim',
  lazy = false,
  config = function()
   require('Comment').setup()
  end,
 },


 -- Useful plugin to show you pending keybinds.
 { 'folke/which-key.nvim', opts = {} },
 {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
   -- See `:help gitsigns.txt`
   signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
   },
   on_attach = function(bufnr)
    vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
     { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
    vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
    vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
   end,
  },
 },

 {
  -- Theme inspired by Atom
  'navarasu/onedark.nvim',
  priority = 1000,
  config = function()
   vim.cmd.colorscheme 'onedark'
  end,
 },

 {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
   options = {
    icons_enabled = false,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
   },
  },
 },

 {
  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help indent_blankline.txt`
  opts = {
   char = '┊',
   show_trailing_blankline_indent = false,
  },
 },


 -- Fuzzy Finder (files, lsp, etc)
 {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
   'nvim-lua/plenary.nvim',
   -- Fuzzy Finder Algorithm which requires local dependencies to be built.
   -- Only load if `make` is available. Make sure you have the system
   -- requirements installed.
   {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
     return vim.fn.executable 'make' == 1
    end,
   },
  },
 },
 {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
   'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',
 },

 {
  "ThePrimeagen/harpoon",
  lazy = false,
  config = function()
   require("harpoon").setup {}
  end,
 },

 {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
   "nvim-tree/nvim-web-devicons",
  },
  config = function()
   require("nvim-tree").setup {}
   vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", { noremap = true, silent = true })
   vim.api.nvim_set_keymap("n", "<C-n>", ":wincmd w<CR>", { noremap = true, silent = true })
  end,
 },

 {
  'glacambre/firenvim',

  -- Lazy load firenvim
  -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
  lazy = not vim.g.started_by_firenvim,
  build = function()
   vim.fn["firenvim#install"](0)
  end,

  config = function()
   vim.g.firenvim_config = {
    -- config values, like in my case:
    localSettings = {
     [".*"] = {
      takeover = "never",
     },
    },
   }
  end
 },

 {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
   require("copilot").setup({
    panel = {
     enabled = true,
     auto_refresh = false,
     keymap = {
      accept = "<S-y>",
     },
     layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4,

     },
    },
    suggestion = {
     enabled = true,
     auto_trigger = true,
     debounce = 75,
     keymap = {
      accept = "<S-y>",
      accept_word = false,
      accept_line = false,
      next = "<C-n]>",
      prev = "<C-p>",
     },
    }
   })
  end,
 }
}, {})




-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
 callback = function()
  vim.highlight.on_yank()
 end,
 group = highlight_group,
 pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
 defaults = {
  mappings = {
   i = {
    ['<C-u>'] = false,
    ['<C-d>'] = false,
   },
  },
 },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>pf', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
 -- You can pass additional configuration to telescope to change theme, layout, etc.
 require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
  winblend = 10,
  previewer = false,
 })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
 -- Add languages to be installed here that you want installed for treesitter
 ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim', 'prisma' },

 -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
 auto_install = false,

 highlight = { enable = true },
 indent = { enable = true },
 incremental_selection = {
  enable = true,
  keymaps = {
   init_selection = '<c-space>',
   node_incremental = '<c-space>',
   scope_incremental = '<c-s>',
   node_decremental = '<M-space>',
  },
 },

 textobjects = {
  select = {
   enable = true,
   lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
   keymaps = {
    -- You can use the capture groups defined in textobjects.scm
    ['aa'] = '@parameter.outer',
    ['ia'] = '@parameter.inner',
    ['af'] = '@function.outer',
    ['if'] = '@function.inner',
    ['ac'] = '@class.outer',
    ['ic'] = '@class.inner',
   },
  },
  move = {
   enable = true,
   set_jumps = true, -- whether to set jumps in the jumplist
   goto_next_start = {
    [']m'] = '@function.outer',
    [']]'] = '@class.outer',
   },
   goto_next_end = {
    [']M'] = '@function.outer',
    [']['] = '@class.outer',
   },
   goto_previous_start = {
    ['[m'] = '@function.outer',
    ['[['] = '@class.outer',
   },
   goto_previous_end = {
    ['[M'] = '@function.outer',
    ['[]'] = '@class.outer',
   },
  },
  --[[ swap = {
   swap_next = {
    ['<leader>a'] = '@parameter.inner',
   },
   enable = true,
   swap_previous = {
    ['<leader>A'] = '@parameter.inner',
   },
  }, ]]
 },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>r', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
 -- NOTE: Remember that lua is a real programming language, and as such it is possible
 -- to define small helper and utility functions so you don't have to repeat yourself
 -- many times.
 --
 -- In this case, we create a function that lets us more easily define mappings specific
 -- for LSP related items. It sets the mode, buffer and description for us each time.
 local nmap = function(keys, func, desc)
  if desc then
   desc = 'LSP: ' .. desc
  end

  vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
 end

 nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
 nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

 nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
 nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
 nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
 nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
 nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
 nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

 -- See `:help K` for why this keymap
 nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
 nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

 -- Lesser used LSP functionality
 nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
 nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
 nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
 nmap('<leader>wl', function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
 end, '[W]orkspace [L]ist Folders')

 -- Format on save
 vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
   vim.lsp.buf.format()
  end,
  desc = "Format on save" -- Move the description inside the options table.
 })
end

local servers = {
 clangd = {},
 gopls = {},
 pyright = {},
 rust_analyzer = {},
 tsserver = {},
 html = { filetypes = { 'html', 'twig', 'hbs' } },

 lua_ls = {
  Lua = {
   workspace = { checkThirdParty = false },
   telemetry = { enable = false },
  },
 },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
 ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
 function(server_name)
  require('lspconfig')[server_name].setup {
   capabilities = capabilities,
   on_attach = on_attach,
   settings = servers[server_name],
   filetypes = (servers[server_name] or {}).filetypes,
  }
 end
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}



cmp.setup {
 snippet = {
  expand = function(args)
   luasnip.lsp_expand(args.body)
  end,
 },
 mapping = cmp.mapping.preset.insert {
  ['<C-n>'] = cmp.mapping.select_next_item(),
  ['<C-p>'] = cmp.mapping.select_prev_item(),
  ['<C-d>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-y>'] = cmp.mapping.confirm {
   behavior = cmp.ConfirmBehavior.Replace,
   select = true,
  },
 },
 sources = {
  { name = 'nvim_lsp' },
  { name = 'luasnip' },
 },
}



-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
