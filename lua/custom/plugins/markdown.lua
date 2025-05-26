return {

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },

  {
    'vimwiki/vimwiki',
    lazy = false, -- Load immediately
    config = function()
      vim.g.vimwiki_list = {
        {
          path = '~/vimwiki/', -- Change this to your preferred location
          syntax = 'markdown', -- Default is wiki syntax, change to 'markdown' if needed
          ext = '.md', -- Use .md for markdown files
        },
      }
      vim.g.vimwiki_global_ext = 0 -- Prevent conflicts with other markdown plugins
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'vimwiki',
        callback = function()
          vim.keymap.set('n', '<CR>', function()
            local line = vim.api.nvim_get_current_line()
            local file_path = line:match 'file:([^)]+)'
            if file_path and file_path:match '^~/' then
              vim.cmd('edit ' .. file_path)
            else
              vim.cmd 'VimwikiFollowLink'
            end
          end, { buffer = true })
        end,
      })
    end,
  },
  {
    'reedes/vim-pencil',
    config = function()
      vim.cmd 'let g:pencil#autoformat = 1' -- Enable auto formatting
      vim.cmd "let g:pencil#wrapModeDefault = 'soft'" -- Soft wrap text
      vim.cmd 'augroup pencil'
      vim.cmd 'autocmd!'
      vim.cmd 'autocmd FileType markdown,text,tex call pencil#init()'
      vim.cmd 'augroup END'
    end,
  },
}
