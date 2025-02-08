return {
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
    end,
  },
  {
    'junegunn/goyo.vim',
    cmd = 'Goyo',
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
