-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require 'custom.config.null-ls'
    end,
  },

  {
    'glacambre/firenvim',
    build = ':call firenvim#install(0)',
    config = function()
      vim.g.firenvim_config = {
        globalSettings = { alt = 'all' },
        localSettings = {
          ['.*'] = {
            cmdline = 'neovim',
            content = 'text',
            priority = 0,
            selector = 'textarea', -- constrain to simple textareas
            takeover = 'never', -- manual trigger
          },
        },
      }
    end,
  },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'custom.config.harpoon'
    end,
  },

  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
    },
  },
}
